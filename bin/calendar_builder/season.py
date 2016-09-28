import copy
import datetime
from sqlalchemy import text
from sqlalchemy.orm import joinedload

from models import Season

class YearIterator:
    """Class for stepping through seasons in a year"""

    def __init__(self, session, year):
        """Sets up the iterator"""
        self.session = session
        self.day = datetime.date(year, 1, 1)
        self.load_seasons()

        # The year starts in the Christmas season of the previous year, so load that up as our current season
        self.current_index = 0
        self.started = datetime.date(year - 1, 12, 25)
        self.ends = self.current().end_date(self.started)
        self.sunday_count = 0
        check_day = copy.deepcopy(self.started)
        while check_day < self.day:
            if check_day.strftime('%A').lower()[:3] == 'sun':
                self.sunday_count += 1
            check_day = check_day + datetime.timedelta(days=1)

    def load_seasons(self):
        """Fetches the seasons from the database needed for this year"""
        # Arbitrary rule: seasons for a year are noted valid for the first of that year,
        # even though the church year properly begins with Advent.
        self.by_code = {}
        self.loop = []
        for instance in self.session.query(Season).\
                options(joinedload(Season.all_patterns)).\
                filter(text("valid_for_date(:jan_first, seasons.valid_start, seasons.valid_end)")).\
                params(jan_first=datetime.date(self.day.year, 1, 1).strftime('%Y-%m-%d')).\
                order_by(Season.sort_order):
            code = instance.code
            self.by_code[code] = instance
            self.loop.append(code)

    def current(self):
        """Returns the current season"""
        code = self.loop[self.current_index]
        return self.by_code[code]

    def is_last_week(self):
        return (self.ends - self.day).days < 7

    def advance_by_day(self):
        """Pushes the day up by one"""
        self.day = self.day + datetime.timedelta(days=1)
        if self.day.strftime('%A').lower()[:3] == 'sun':
            self.sunday_count += 1
        if (self.day > self.ends):
            self.next_season()

    def next_season(self):
        """Tick forward by one season"""
        start = self.ends + datetime.timedelta(days=1)
        if (self.current_index + 1 < len(self.loop)):
            self.current_index = self.current_index + 1
        else:
            self.current_index = 0
        self.started = start
        self.ends = self.current().end_date(start)
        if not self.current().continue_counting:
            self.sunday_count = 0
            if self.day.strftime('%A').lower()[:3] == 'sun' and self.current().counting_index:
                self.sunday_count += 1

