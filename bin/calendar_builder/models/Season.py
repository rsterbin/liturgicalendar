# Model: seasons table

import datetime
from dateutil.easter import *

from config import config
from ORM import RowBase

class Season(RowBase.RowBase):
    """A season of the church year"""

    table = 'seasons'
    primary_key = 'season_id'
    prefix = 'ssn_'

    def load(self, row):
        """Loads a row from the database"""
        super(self.__class__, self).load(row)
        self.calc = {
            'algorithm': self.column('algorithm'),
            'distance': self.column('distance'),
            'holiday': self.column('calculate_from'),
        }

    def append_services(self, row):
        """Appends a row with service information"""
        if self.pattern is None:
            self.pattern = services.pattern()
        self.pattern.append(row)

    def end_date(self, start_date):
        """Gets the end date for this season, given a start date"""
        if self.calc['holiday'] == 'easter':
            holiday = easter(start_date.year)
        elif self.calc['holiday'] == 'christmas':
            holiday = datetime.date(start_date.year, 12, 25)
        else:
            print self._columns
            raise ValueError('"{holiday}" is an unknown calculation starting point for seasons; use "christmas" or "easter"'.format(holiday=repr(self.calc['holiday'])))
        return getattr(_boundary_algorithms, self.calc['algorithm'])(holiday, self.calc['distance'])

    def precedence(self, day):
        """Gets the precedence for a given date, assumed to be within the season"""
        weekday = day.strftime('%A').lower()
        if weekday == 'sunday':
            return config['sunday_precedence']
        else:
            return self.column('weekday_precedence')

class _boundary_algorithms:
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

