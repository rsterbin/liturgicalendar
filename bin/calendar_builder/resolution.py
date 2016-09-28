import copy
import datetime
import sys

from season import YearIterator

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
            sys.stderr.write(cdate + ' // SUNDAY COUNT ' + str(self.season_ticker.sunday_count) + ' // LAST WEEK ' + str(self.season_ticker.is_last_week()) + "\n")
            self.full_year[cdate] = ResolutionDay(self.season_ticker.day, self)
            self.full_year[cdate].set_season(self.season_ticker.current(), self.season_ticker.sunday_count, self.season_ticker.is_last_week())
            self.season_ticker.advance_by_day()

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

    def set_season(self, season, sunday_count, is_last_week):
        self.season = season
        self.sunday_count = sunday_count
        self.is_last_week = is_last_week

    def resolve(self):
        if self.season is not None:
            pattern = self.season.pattern(self.day)
            if pattern.has_vigil(self.day):
                self.base_block = ResolutionBlock(
                    color = self.season.color,
                    name = self.season.day_name(self.day, sunday_count = self.sunday_count, is_last = self.is_last_week),
                    note = self.season.day_note(self.day),
                    schedule = pattern.schedule(self.day, has_vigil = True)
                )
                # Look ahead to the next day and use its info for the vigil
                tomorrow = self.year.after(self.day)
                tpattern = tomorrow.season.pattern(self.day)
                self.vigil_block = ResolutionBlock(
                    color = tomorrow.season.color,
                    name = tomorrow.season.day_name(self.day, is_vigil = True, sunday_count = tomorrow.sunday_count, is_last = tomorrow.is_last_week),
                    schedule = tpattern.schedule(self.day, is_vigil = True)
                )
            else:
                self.base_block = ResolutionBlock(
                    color = self.season.color,
                    name = self.season.day_name(self.day, sunday_count = self.sunday_count, is_last = self.is_last_week),
                    note = self.season.day_note(self.day),
                    schedule = pattern.schedule(self.day)
                )
                self.vigil_block = None

    def weekday(self):
        return self.day.strftime('%A').lower()[:3]

    def precedence(self):
        return self.season.precedence(self.day)

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


