# Classes for handling the seasons of the church year

import datetime
from dateutil.easter import *
import psycopg2
import psycopg2.extras

from config import config

class year_iterator:
    """Class for stepping through seasons in a year"""

    def __init__(self, conn, year):
        """Sets up the iterator"""
        self.conn = conn
        self.load_seasons(year)

        # The year starts in the Christmas season of the previous year, so load that up as our current season
        self.current_index = 0
        self.started = datetime.date(year - 1, 12, 25)
        self.ends = self.current().end_date(self.started)

    def load_seasons(self, year):
        """Fetches the seasons from the database needed for a year"""
        # Arbitrary rule: seasons for a year are noted valid for the first of that year,
        # even though the church year properly begins with Advent.
        cur = self.conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        cur.execute("SELECT name, code, color, weekday_precedence, calculate_from, algorithm, distance " +
            "FROM liturigal_seasons " +
            "WHERE valid_for_date(%(jan_first)s, valid_start, valid_end) " +
            "ORDER BY sort_order",
            { "jan_first": datetime.date(year, 1, 1).strftime('%Y-%m-%d') })
        found = cur.fetchall()
        self.by_code = {}
        self.loop = []
        for row in found:
            self.by_code[row['code']] = season(row)
            self.loop.append(row['code'])

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

class season:
    """A season of the church year"""

    def __init__(self, row):
        """Initializes a season from a database row"""
        self.name = row['name']
        self.code = row['code']
        self.color = row['color']
        self.weekday_precedence = row['weekday_precedence']
        self.calc = {
            'algorithm': row['algorithm'],
            'distance': row['distance'],
            'holiday': row['calculate_from'],
        }

    def end_date(self, start_date):
        """Gets the end date for this season, given a start date"""
        if self.calc['holiday'] == 'easter':
            holiday = easter(start_date.year)
        elif self.calc['holiday'] == 'christmas':
            holiday = datetime.date(start_date.year, 12, 25)
        else:
            raise ValueError('"{holiday}" is an unknown calculation starting point for seasons; use "christmas" or "easter"'.format(holiday=repr(holiday)))
        return getattr(boundary_algorithms, self.calc['algorithm'])(holiday, self.calc['distance'])

    def precedence(self, day):
        """Gets the precedence for a given date, assumed to be within the season"""
        weekday = day.strftime('%A').lower()
        if weekday == 'sunday':
            return config['sunday_precedence']
        else:
            return self.weekday_precedence

class boundary_algorithms:
    """Algorithms for calculating season boundaries"""

    @staticmethod
    def days_before(holiday_date, number):
        """Finds a number of days before the given holiday"""
        return holiday_date - datetime.timedelta(days=number)

    @staticmethod
    def days_after(holiday_date, number):
        """Finds a number of days after the given holiday"""
        return holiday_date + datetime.timedelta(days=number)

    @staticmethod
    def weeks_before(holiday_date, number):
        """Finds a number of weeks before the given holiday"""
        return holiday_date - datetime.timedelta(weeks=number)

    @staticmethod
    def weeks_after(holiday_date, number):
        """Finds a number of weeks after the given holiday"""
        return holiday_date + datetime.timedelta(weeks=number)

    @staticmethod
    def tuesdays_before(holiday_date, number):
        """Finds the nth Tuesday before the holiday"""
        return holiday_date - datetime.timedelta(days=holiday_date.weekday()) + datetime.timedelta(days=1, weeks=-1*number)

    @staticmethod
    def saturdays_before(holiday_date, number):
        """Finds the nth Saturday before the holiday"""
        return holiday_date - datetime.timedelta(days=holiday_date.weekday()) + datetime.timedelta(days=5, weeks=-1*number)

