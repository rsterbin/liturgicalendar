import datetime
from sqlalchemy import text
from sqlalchemy.orm import joinedload

from models import Season

class YearIterator:
    """Class for stepping through seasons in a year"""

    def __init__(self, session, year):
        """Sets up the iterator"""
        self.session = session
        self.load_seasons(year)

        # The year starts in the Christmas season of the previous year, so load that up as our current season
        self.current_index = 0
        self.started = datetime.date(year - 1, 12, 25)
        self.ends = self.current().end_date(self.started)

    def load_seasons(self, year):
        """Fetches the seasons from the database needed for a year"""
        # Arbitrary rule: seasons for a year are noted valid for the first of that year,
        # even though the church year properly begins with Advent.
        self.by_code = {}
        self.loop = []
        for instance in self.session.query(Season).\
                options(joinedload(Season.all_patterns)).\
                filter(text("valid_for_date(:jan_first, seasons.valid_start, seasons.valid_end)")).\
                params(jan_first=datetime.date(year, 1, 1).strftime('%Y-%m-%d')).\
                order_by(Season.sort_order):
            code = instance.code
            self.by_code[code] = instance
            self.loop.append(code)

    def current(self):
        """Returns the current season"""
        code = self.loop[self.current_index]
        return self.by_code[code]

    def advance(self):
        """Tick forward by one season"""
        start = self.ends + datetime.timedelta(days=1)
        if (self.current_index + 1 < len(self.loop)):
            self.current_index = self.current_index + 1
        else:
            self.current_index = 0
        self.started = start
        self.ends = self.current().end_date(start)

