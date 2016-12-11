import copy
import datetime
import sys

from season import YearIterator
from moveable_feasts import MoveableFeasts
from fixed_feasts import FixedFeasts
from valid_dates import valid_in_list
from config import config

class Resolution:
    """Describes a year in the resolution process"""

    def __init__(self, year, session):
        self.year = year
        self.session = session
        self.full_year = {}

    def _day_to_lookup(self, day):
        """Turns a day into its lookup key in the full year hash"""
        return day.strftime('%Y-%m-%d')

    def import_seasons(self):
        """Walk though the year and lay down our defaults according to the season on that date"""
        self.season_ticker = YearIterator(self.session, self.year)
        while self.season_ticker.day.year == self.year:
            cdate = self._day_to_lookup(self.season_ticker.day)
            self.full_year[cdate] = ResolutionDay(self.season_ticker.day, self)
            self.full_year[cdate].set_season(self.season_ticker.current(), self.season_ticker.sunday_count, self.season_ticker.is_last_week())
            self.season_ticker.advance_by_day()

    def import_moveable_feasts(self):
        self.moveable = MoveableFeasts(self.session, self.year)
        for info in self.moveable.feasts_by_date():
            cdate = self._day_to_lookup(info['day'])
            self.full_year[cdate].add_feast(ResolutionFeast(info['feasts'], info['day']))

    def import_fixed_feasts(self):
        self.fixed = FixedFeasts(self.session, self.year)
        for info in self.fixed.feasts_by_date():
            cdate = self._day_to_lookup(info['day'])
            self.full_year[cdate].add_feast(ResolutionFeast(info['feasts'], info['day']))

    def before(self, day):
        """Returns the day before the day given"""
        target = copy.deepcopy(day)
        target = target - datetime.timedelta(days=1)
        return self.full_year[self._day_to_lookup(target)]

    def after(self, day):
        """Returns the day after the day given"""
        target = copy.deepcopy(day)
        target = target + datetime.timedelta(days=1)
        return self.full_year[self._day_to_lookup(target)]

class ResolutionDay:
    """Describes a day in the resolution process"""

    def __init__(self, day, year):
        """Sets up a day within a year"""
        self.day = copy.deepcopy(day)
        self.year = year
        self.season = None
        self.current_feast = None
        self.has_vigil = False
        self.feasts = []
        self.base_block = None
        self.vigil_block = None

    def set_season(self, season, sunday_count, is_last_week):
        self.season = season
        self.sunday_count = sunday_count
        self.is_last_week = is_last_week

    def add_feast(self, feast):
        feast.change_day(self.day)
        self.feasts.append(feast)

    def set_vigil_for_feast(self, feast):
        self.has_vigil = True
        pattern = feast.eve_pattern()
        vigil_name = feast.eve_name()
        if vigil_name is None:
            vigil_name = 'Eve of ' + feast.name()
        self.vigil_block = ResolutionBlock(
            color = feast.color(),
            name = vigil_name,
            schedule = pattern.schedule(self.day, is_vigil = True)
        )
        if self.current_feast:
            self._make_block_from_feast()
        else:
            self._make_block_from_season()

    def set_vigil_for_season(self):
        self.has_vigil = True
        # Look ahead to the next day and use its info for the vigil
        tomorrow = self.year.after(self.day)
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

    def resolve(self):
        current_precedence = self.season.precedence(self.day)
        current_feast = None

        for feast in self.feasts:
            if feast.precedence() <= current_precedence:
                current_precedence = feast.precedence()
                current_feast = feast
            elif feast.precedence() <= config['transfer_precedence']:
                tomorrow = self.year.after(self.day)
                tomorrow.add_feast(feast)

        if current_feast is not None:
            self.current_feast = current_feast
            self._make_block_from_feast()
            if self.current_feast.has_eve():
                # Look back to yesterday and set the vigil
                yesterday = self.year.before(self.day)
                yesterday.set_vigil_for_feast(self.current_feast)

        elif self.season is not None:
            pattern = self.season.pattern(self.day)
            if pattern.has_vigil(self.day):
                self.set_vigil_for_season()
            else:
                self._make_block_from_season()

    def _make_block_from_feast(self):
        if self.current_feast is None:
            return
        pattern = self.current_feast.pattern()
        if pattern is None:
            pattern = self.season.pattern(self.day)
        self.base_block = ResolutionBlock(
            color = self.current_feast.color(),
            name = self.current_feast.name(),
            note = self.current_feast.note(),
            schedule = pattern.schedule(self.day, has_vigil = self.has_vigil)
        )

    def _make_block_from_season(self):
        if self.season is None:
            return
        pattern = self.season.pattern(self.day)
        self.base_block = ResolutionBlock(
            color = self.season.color,
            name = self.season.day_name(self.day, sunday_count = self.sunday_count, is_last = self.is_last_week),
            note = self.season.day_note(self.day),
            schedule = pattern.schedule(self.day, has_vigil = self.has_vigil)
        )

    def weekday(self):
        return self.day.strftime('%A').lower()[:3]

    def __repr__(self):
        rep = self.day.strftime('%Y-%m-%d') + ' (' + self.weekday() + '):'
        rep += "\n\t" + str(self.base_block)
        if self.vigil_block is not None:
            rep += "\n\t" + str(self.vigil_block)
        return rep

class ResolutionBlock:
    """Describes a service block on a particular day"""

    def __init__(self, **kwargs):
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
        else:
            self.schedule = None

    def __repr__(self):
        rep = '[' + str(self.color) + '] ' + str(self.name)
        if self.note is not None:
            rep += "\n\t\t(" + str(self.note) + ')'
        rep += "\n\t\t* " + str(self.schedule)
        return rep

class ResolutionFeast:
    """Describes a feast we're putting on the calendar"""

    def __init__(self, feasts, day):
        self.feasts = feasts
        self.original_day = day
        self.current_day = day

    def _get_for_day(self, day):
        return valid_in_list(self.feasts, day)

    def change_day(self, day):
        self.current_day = day

    def precedence(self):
        f = self._get_for_day(self.current_day);
        if f:
            return f.otype.precedence
        else:
            return -1

    def color(self):
        f = self._get_for_day(self.current_day);
        if f:
            return f.color
        else:
            return ''

    def name(self):
        f = self._get_for_day(self.current_day);
        if f:
            return f.name
        else:
            return ''

    def note(self):
        f = self._get_for_day(self.current_day);
        if f:
            return f.note
        else:
            return ''

    def pattern(self):
        f = self._get_for_day(self.current_day);
        if f:
            return f.pattern(self.current_day)
        else:
            return ''

    def has_eve(self):
        f = self._get_for_day(self.current_day);
        if f:
            return f.has_eve
        else:
            return ''

    def eve_name(self):
        f = self._get_for_day(self.current_day);
        if f:
            return f.eve_name
        else:
            return ''

    def eve_pattern(self):
        f = self._get_for_day(self.current_day);
        if f:
            return f.eve_pattern(self.current_day)
        else:
            return ''

    def __repr__(self):
        rep = '[' + str(self.color()) + '] ' + str(self.name())
        if self.note() is not None:
            rep += "\n\t\t(" + str(self.note()) + ')'
        if self.pattern():
            rep += "\n\t\t* " + str(self.pattern().schedule(self.current_day))
        return rep

