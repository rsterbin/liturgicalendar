import copy
import datetime
import logging

from .config import config
from .fetch.federal_holidays import FederalHolidays
from .fetch.fixed_feasts import FixedFeasts
from .fetch.floating_feasts import FloatingFeasts
from .fetch.moveable_feasts import MoveableFeasts
from .season import YearIterator
from .static import StaticYear
from . import utils
from .valid_dates import valid_in_list

class Resolution:
    """Calculate the liturgical calendar for a full year"""

    def __init__(self, session):
        """Constructor"""
        self.session = session
        self.logger = logging.getLogger(__name__)

    def calculate_year(self, year):
        """Calculates the liturgical calendar and returns it as a StaticYear"""

        # Start up Resolution for this year
        self.logger.info('Starting resolution for ' + str(year))
        resolution = ResolutionYear(year, self.session, self.logger)

        # Set up the season framework
        self.logger.info('Importing seasons...')
        resolution.import_seasons()
        self.logger.info('done')

        # Add moveable feasts
        self.logger.info('Adding moveable feasts...')
        resolution.import_moveable_feasts()
        self.logger.info('done')

        # Add fixed feasts
        self.logger.info('Adding fixed feasts...')
        resolution.import_fixed_feasts()
        self.logger.info('done')

        # Add federal holidays
        self.logger.info('Adding federal holidays...')
        resolution.import_federal_holidays()
        self.logger.info('done')

        # Resolve
        self.logger.info('Resolving...')
        for cdate in sorted(resolution.full_year.iterkeys()):
            resolution.full_year[cdate].resolve()
        self.logger.info('done')

        # Add floating feasts and re-resolve
        self.logger.info('Adding floating feasts...')
        resolution.import_floating_feasts()
        for cdate in sorted(resolution.full_year.iterkeys()):
            resolution.full_year[cdate].resolve()
        self.logger.info('done')

        # Freeze the current state
        self.logger.info('Freezing current state...')
        static = resolution.freeze()
        self.logger.info('done')

        return static

class ResolutionYear:
    """Describes a year in the resolution process"""

    def __init__(self, year, session, logger):
        """Constructor"""
        self.year = year
        self.session = session
        self.logger = logger
        self.full_year = {}
        self.extras = {}

    def import_seasons(self):
        """Walk though the year and lay down our defaults according to the season on that date"""
        self.season_ticker = YearIterator(self.session, self.year)
        self.logger.debug('Fetched season iterator and began initial walk')
        while self.season_ticker.day.year == self.year:
            cdate = utils.day_to_lookup(self.season_ticker.day)
            self.full_year[cdate] = ResolutionDay(self.season_ticker.day, self)
            self.full_year[cdate].set_season(self.season_ticker.current(), self.season_ticker.sunday_count, self.season_ticker.is_last_week())
            self.season_ticker.advance_by_day()
        self.logger.debug('Completed initial walk')
        # We also need one day of the next year, in case of vigil
        alt_season_ticker = YearIterator(self.session, self.year + 1)
        self.logger.debug('Fetched season iterator for day one of next year')
        self.next_year_first = ResolutionDay(alt_season_ticker.day, self)
        self.next_year_first.set_season(alt_season_ticker.current(), alt_season_ticker.sunday_count, alt_season_ticker.is_last_week())

    def import_moveable_feasts(self):
        """Fetch moveable feasts and place them on the proper days"""
        self.moveable = MoveableFeasts(self.session, self.year)
        mf = self.moveable.feasts_by_date()
        self.logger.debug('Found moveable feasts on {days} days'.format(days=len(mf)))
        for info in mf:
            cdate = utils.day_to_lookup(info['day'])
            if cdate in self.full_year:
                self.full_year[cdate].add_feast(ResolutionFeast(info['feasts'], info['day']))
            else:
                if cdate not in self.extras:
                    self.extras[cdate] = []
                self.extras[cdate].append(ResolutionFeast(info['feasts'], info['day']))
        self.logger.debug('Added moveable feasts')

    def import_fixed_feasts(self):
        """Fetch fixed feasts and place them on the proper days"""
        self.fixed = FixedFeasts(self.session, self.year)
        ff = self.fixed.feasts_by_date()
        self.logger.debug('Found fixed feasts on {days} days'.format(days=len(ff)))
        for info in ff:
            cdate = utils.day_to_lookup(info['day'])
            if cdate in self.full_year:
                self.full_year[cdate].add_feast(ResolutionFeast(info['feasts'], info['day']))
            else:
                if cdate not in self.extras:
                    self.extras[cdate] = []
                self.extras[cdate].append(ResolutionFeast(info['feasts'], info['day']))
        self.logger.debug('Added fixed feasts')

    def import_floating_feasts(self):
        """Fetch floating feasts and place them on the proper days"""
        self.floating = FloatingFeasts(self.session, self.year)
        ff = self.floating.get_for_year(self.year, self.full_year)
        self.logger.debug('Found floating feasts on {days} days'.format(days=len(ff)))
        for info in ff:
            cdate = utils.day_to_lookup(info['day'])
            if cdate in self.full_year:
                self.full_year[cdate].add_feast(ResolutionFeast(info['feasts'], info['day']))
            else:
                if cdate not in self.extras:
                    self.extras[cdate] = []
                self.extras[cdate].append(ResolutionFeast(info['feasts'], info['day']))
        self.logger.debug('Added floating feasts')

    def import_federal_holidays(self):
        """Fetch federal holidays and place them on the proper days"""
        self.federal = FederalHolidays(self.session, self.year)
        fh = self.federal.holidays_by_date()
        self.logger.debug('Found federal holidays on {days} days'.format(days=len(fh)))
        for info in fh:
            cdate = utils.day_to_lookup(info['day'])
            if cdate in self.full_year:
                self.full_year[cdate].add_holiday(ResolutionHoliday(info['holidays'], info['day']))
            else:
                if cdate not in self.extras:
                    self.extras[cdate] = []
                self.extras[cdate].append(ResolutionHoliday(info['holidays'], info['day']))
        self.logger.debug('Added federal holidays')

    def freeze(self):
        """Freezes the current resolution and returns the static year"""
        static_year = StaticYear(self.year, self.session)
        overrides = []
        for cdate in sorted(self.full_year.iterkeys()):
            res_day = self.full_year[cdate]
            if res_day.base_block is not None:
                overrides.append(self._block_to_override(res_day.day, res_day.base_block, False))
            if res_day.vigil_block is not None:
                overrides.append(self._block_to_override(res_day.day, res_day.vigil_block, True))
        static_year.override(overrides)
        self.logger.debug('Froze year')
        return static_year

    def _block_to_override(self, day, block, is_vigil):
        """Converts a resolution block into a dictionary suitable for static overrides"""
        override = {}
        override['day'] = day
        if is_vigil:
            override['target_block'] = 'vigil'
        else:
            override['target_block'] = 'base'
        override['color'] = block.color
        override['name'] = block.name
        override['note'] = block.note
        override['services'] = []
        for service in block.services:
            override['services'].append({ 'name': service.name, 'start_time': service.start_time })
        return override

    def before(self, day):
        """Returns the day before the day given"""
        target = copy.deepcopy(day)
        target = target - datetime.timedelta(days=1)
        return self.full_year[utils.day_to_lookup(target)]

    def after(self, day):
        """Returns the day after the day given"""
        target = copy.deepcopy(day)
        target = target + datetime.timedelta(days=1)
        cdate = utils.day_to_lookup(target)
        if cdate in self.full_year:
            return self.full_year[cdate]

class ResolutionDay:
    """Describes a day in the resolution process"""

    def __init__(self, day, year):
        """Sets up a day within a year"""
        self.day = copy.deepcopy(day)
        self.year = year
        self.season = None
        self.current_feast = None
        self.current_precedence = 100
        self.has_vigil = False
        self.feasts = []
        self.holidays = []
        self.base_block = None
        self.vigil_block = None
        self.logger = year.logger

    def set_season(self, season, sunday_count, is_last_week):
        """Sets the season info for this day"""
        self.season = season
        self.sunday_count = sunday_count
        self.is_last_week = is_last_week

    def add_feast(self, feast):
        """Adds a feast"""
        feast.change_day(self.day)
        self.feasts.append(feast)

    def add_holiday(self, holiday):
        """Adds a holiday"""
        holiday.change_day(self.day)
        self.holidays.append(holiday)

    def resolve(self):
        """Look at today's season and any feasts, then set the main and vigil blocks accordingly"""
        if self.season is None:
            self.logger.warn('No season data for ' + utils.day_to_lookup(self.day))
            return

        pattern = self.season.pattern(self.day)
        if pattern.has_vigil(self.day):
            self._set_vigil_for_season()
        else:
            self._make_block_from_season()

        self.current_precedence = self.season.precedence(self.day)
        current_feast = None

        for feast in self.feasts:
            if feast.precedence() <= self.current_precedence:
                self.current_precedence = feast.precedence()
                current_feast = feast
            elif feast.precedence() <= config['transfer_precedence']:
                tomorrow = self.year.after(self.day)
                tomorrow.add_feast(feast)
                self.feasts.remove(feast)
                self.logger.debug('Transferring ' + feast.name() + ' to ' + utils.day_to_lookup(tomorrow.day))

        if current_feast is not None:
            self.current_feast = current_feast
            self._make_block_from_feast()
            if self.current_feast.has_eve():
                # Look back to yesterday and set the vigil
                yesterday = self.year.before(self.day)
                yesterday._set_vigil_for_feast(self.current_feast)

        for holiday in self.holidays:
            if holiday.open_time() is not None or holiday.close_time() is not None:
                if self.base_block.check_open_hours(holiday.open_time(), holiday.close_time()):
                    self.base_block.set_open_hours(holiday.open_time(), holiday.close_time())
                else:
                    self.base_block = None
                if self.vigil_block is not None:
                    if self.vigil_block.check_open_hours(holiday.open_time(), holiday.close_time()):
                        self.vigil_block.set_open_hours(holiday.open_time(), holiday.close_time())
                    else:
                        self.vigil_block = None
            if self.base_block is not None:
                note_lines = []
                if not holiday.skip_name():
                    note_lines.append(holiday.name())
                if holiday.note() is not None:
                    note_lines.append(holiday.note())
                if self.base_block.note is not None and len(note_lines) > 0:
                    self.base_block.note = "\n".join(note_lines) + "\n" + self.base_block.note
                elif len(note_lines) > 0:
                    self.base_block.note = "\n".join(note_lines)

    def _make_block_from_feast(self):
        """Use the current feast to set today's main block"""
        if self.current_feast is None:
            self.logger.warn('Attempting to make block from missing feast on ' + utils.day_to_lookup(self.day))
            return
        pattern = self.current_feast.pattern()
        if pattern is None:
            pattern = self.season.pattern(self.day)
        if pattern is None:
            self.logger.warn('Missing pattern for ' + self.current_feast.name() + ' on ' + utils.day_to_lookup(self.day))
        schedule = pattern.schedule(self.day, has_vigil = self.has_vigil)
        if schedule is None:
            self.logger.warn('Missing schedule for ' + self.current_feast.name() + ' on ' + utils.day_to_lookup(self.day))
            return
        self.base_block = ResolutionBlock(
            color = self.current_feast.color(),
            name = self.current_feast.name(),
            note = self.current_feast.note(),
            schedule = schedule
        )

    def _make_block_from_season(self):
        """Use the current season to set today's main block"""
        if self.season is None:
            self.logger.warn('Attempting to make block from missing season on ' + utils.day_to_lookup(self.day))
            return
        pattern = self.season.pattern(self.day)
        if pattern is None:
            self.logger.warn('Missing season pattern on ' + utils.day_to_lookup(self.day))
        schedule = pattern.schedule(self.day, has_vigil = self.has_vigil)
        if schedule is None:
            self.logger.warn('Missing season schedule on ' + utils.day_to_lookup(self.day))
            return
        self.base_block = ResolutionBlock(
            color = self.season.color,
            name = self.season.day_name(self.day, sunday_count = self.sunday_count, is_last = self.is_last_week),
            note = self.season.day_note(self.day),
            schedule = schedule
        )

    def _set_vigil_for_feast(self, feast):
        """Sets the vigil block on this day for a feast happening tomorrow"""
        pattern = feast.eve_pattern()
        if pattern is None:
            pattern = self.season.pattern(self.day)
        vigil_name = feast.eve_name()
        if vigil_name is None:
            vigil_name = 'Eve of ' + feast.name()
        vigil_schedule = pattern.schedule(self.day, is_vigil = True)
        if vigil_schedule is None:
            self.logger.warn('Missing vigil schedule for ' + feast.name() + ' on ' + utils.day_to_lookup(self.day))
            return
        cp = self.season.precedence(self.day)
        for f in self.feasts:
            if cp > f.precedence():
                cp = f.precedence()
        if cp < feast.precedence():
            return
        self.has_vigil = True
        self.vigil_block = ResolutionBlock(
            color = feast.color(),
            name = vigil_name,
            schedule = vigil_schedule
        )
        if self.current_feast:
            self._make_block_from_feast()
        else:
            self._make_block_from_season()

    def _set_vigil_for_season(self):
        """Sets the vigil block on this day using tomorrow's season info"""
        tomorrow = self.year.after(self.day)
        if tomorrow is None:
            self.logger.info('Setting vigil from the first day of next year')
            tomorrow = self.year.next_year_first
        self.has_vigil = True
        tpattern = tomorrow.season.pattern(self.day)
        self.vigil_block = ResolutionBlock(
            color = tomorrow.season.color,
            name = tomorrow.season.day_name(self.day, is_vigil = True, sunday_count = tomorrow.sunday_count, is_last = tomorrow.is_last_week),
            schedule = tpattern.schedule(self.day, is_vigil = True)
        )
        if self.current_feast:
            self._make_block_from_feast()
        else:
            self._make_block_from_season()

    def __repr__(self):
        """Displays the day as a string"""
        rep = self.day.strftime('%Y-%m-%d') + ' (' + utils.weekday(self.day) + '):'
        rep += "\n\t" + str(self.base_block)
        if self.vigil_block is not None:
            rep += "\n\t" + str(self.vigil_block)
        return rep

class ResolutionBlock:
    """Describes a service block on a particular day"""

    def __init__(self, **kwargs):
        """Constructor"""
        if 'color' in kwargs:
            self.color = kwargs['color']
        else:
            self.color = None
        if 'name' in kwargs:
            self.name = kwargs['name']
        else:
            self.name = None
        if 'note' in kwargs:
            self.note = kwargs['note']
        else:
            self.note = None
        if 'schedule' in kwargs:
            self.schedule = kwargs['schedule']
            self.services = self.schedule.sort_services()
        else:
            self.schedule = None
            self.services = []

    def check_open_hours(self, open_time, close_time):
        """Check the open hours against the service times to see if this block will have any services left"""
        ok = []
        if open_time is None:
            open_time = datetime.time(0, 0, 0)
        if close_time is None:
            close_time = datetime.time(23, 59, 59)
        for s in self.services:
            n = s.start_time.replace(tzinfo=None)
            if n > open_time and n < close_time:
                ok.append(s)
        return len(ok) > 0

    def set_open_hours(self, open_time, close_time):
        """Slice off services outside the open hours"""
        ok = []
        if open_time is None:
            open_time = datetime.time(0, 0, 0)
        if close_time is None:
            close_time = datetime.time(23, 59, 59)
        for s in self.services:
            n = s.start_time.replace(tzinfo=None)
            if n > open_time and n < close_time:
                ok.append(s)
        self.services = ok

    def __repr__(self):
        """Displays the block as a string"""
        rep = '[' + str(self.color) + '] ' + str(self.name)
        if self.note is not None:
            lines = self.note.split("\n")
            rep += "\n\t\t(" + "\n\t\t ".join(lines) + ')'
        for service in self.services:
            rep += "\n\t\t* " + str(service)
        return rep

class ResolutionFeast:
    """Describes a feast we're putting on the calendar"""

    def __init__(self, feasts, day):
        """Constructor"""
        self.feasts = feasts
        self.original_day = day
        self.current_day = day

    def _get_for_day(self, day):
        """Selects the feast model that's valid for a given day"""
        return valid_in_list(self.feasts, day)

    def change_day(self, day):
        """Changes the current day"""
        self.current_day = day

    def precedence(self):
        """Selects the precedence for this feast"""
        f = self._get_for_day(self.current_day);
        if f:
            return f.otype.precedence
        else:
            return -1

    def code(self):
        """Selects the code for this feast"""
        f = self._get_for_day(self.current_day);
        if f:
            return f.code
        else:
            return ''

    def color(self):
        """Selects the color for this feast"""
        f = self._get_for_day(self.current_day);
        if f:
            return f.color
        else:
            return ''

    def name(self):
        """Selects the name for this feast"""
        f = self._get_for_day(self.current_day);
        if f:
            return f.name
        else:
            return ''

    def note(self):
        """Selects the note for this feast"""
        f = self._get_for_day(self.current_day);
        if f:
            return f.note
        else:
            return ''

    def pattern(self):
        """Selects the pattern for this feast"""
        f = self._get_for_day(self.current_day);
        if f:
            return f.pattern(self.current_day)
        else:
            return ''

    def has_eve(self):
        """Selects the eve flag for this feast"""
        f = self._get_for_day(self.current_day);
        if f:
            return f.has_eve
        else:
            return ''

    def eve_name(self):
        """Selects the eve name for this feast"""
        f = self._get_for_day(self.current_day);
        if f:
            return f.eve_name
        else:
            return ''

    def eve_pattern(self):
        """Selects the eve pattern for this feast"""
        f = self._get_for_day(self.current_day);
        if f:
            return f.eve_pattern(self.current_day)
        else:
            return ''

    def __repr__(self):
        """Displays the feast as a string"""
        rep = '[' + str(self.color()) + '] ' + str(self.name())
        if self.note() is not None:
            lines = self.note().split("\n")
            rep += "\n\t\t(" + "\n\t\t ".join(lines) + ')'
        if self.pattern():
            rep += "\n\t\t* " + str(self.pattern().schedule(self.current_day))
        return rep

class ResolutionHoliday:
    """Describes a holiday we're putting on the calendar"""

    def __init__(self, holidays, day):
        """Constructor"""
        self.holidays = holidays
        self.original_day = day
        self.current_day = day

    def _get_for_day(self, day):
        """Selects the holiday model that's valid for a given day"""
        return valid_in_list(self.holidays, day)

    def change_day(self, day):
        """Changes the current day"""
        self.current_day = day

    def name(self):
        """Selects the name for this holiday"""
        h = self._get_for_day(self.current_day);
        if h:
            return h.name
        else:
            return ''

    def code(self):
        """Selects the code for this holiday"""
        h = self._get_for_day(self.current_day);
        if h:
            return h.code
        else:
            return ''

    def note(self):
        """Selects the note for this holiday"""
        h = self._get_for_day(self.current_day);
        if h:
            return h.note
        else:
            return ''

    def open_time(self):
        """Selects the church open time for this holiday"""
        h = self._get_for_day(self.current_day);
        if h:
            return h.open_time
        else:
            return ''

    def close_time(self):
        """Selects the church close time for this holiday"""
        h = self._get_for_day(self.current_day);
        if h:
            return h.close_time
        else:
            return ''

    def skip_name(self):
        """Selects the skip-name flag for this holiday"""
        h = self._get_for_day(self.current_day);
        if h:
            return h.skip_name
        else:
            return False

    def __repr__(self):
        """Displays the holiday as a string"""
        rep = str(self.name()) + ' <' + str(self.code()) + '>: Church open ' + str(self.open_time()) + ' to ' + str(self.close_time())
        if self.note() is not None:
            lines = self.note().split("\n")
            rep += "\n\t\t(" + "\n\t\t ".join(lines) + ')'
        return rep

