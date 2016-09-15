#!/usr/bin/python

import copy
import datetime
import logging
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.engine.url import URL
import sys

from season import YearIterator

# Make sure we have a config
try:
    from config import config
except IOError:
    print "Cannot find database configuration"
    sys.exit(1)

# DB connection function
def db_connect():
    """
    Performs database connection using database settings from settings.py.
    Returns sqlalchemy engine instance
    """
    return create_engine(URL(**config['database']))

logging.basicConfig()
#logging.getLogger('sqlalchemy.engine').setLevel(logging.INFO)

engine = db_connect()
Session = sessionmaker(bind=engine)
session = Session()

# Calculate for 2014
CALC_YEAR = 2014

# Listings we'll be filling in
full_year = {}
base_day = {
    'date': None,
    'weekday': '',
    'precedence': 0,
    'color': '',
    'holiday_day': None,
    'holiday_eve': None,
    'season': None,
}

class BaseDay:
    """Describes a day in the year ticker"""

    def __init__(self, day, season):
        self.day = copy.deepcopy(day)
        self.season = season

    def weekday(self):
        return self.day.strftime('%A').lower()[:3]

    def precedence(self):
        return self.season.precedence(self.day)

    def color(self):
        return self.season.color

    def schedule(self):
        if self.season.pattern(self.day).has_vigil(self.day):
            return [ self.season.pattern(self.day).schedule(self.day, has_vigil = True), self.season.pattern(self.day).schedule(self.day, is_vigil = True) ]
        else:
            return [ self.season.pattern(self.day).schedule(self.day) ]

    def __repr__(self):
        return self.day.strftime('%Y-%m-%d') + ': WEEKDAY ' + self.weekday() +\
                ' // SEASON ' + self.season.code +\
                ' // COLOR ' + self.color() +\
                ' // PRECEDENCE ' + str(self.precedence()) +\
                ' // PATTERN ' + self.season.pattern(self.day).name +\
                ' // SCHEDULE ' + ', '.join([str(x) for x in self.schedule()])

# Season ticker
season_ticker = YearIterator(session, CALC_YEAR)

# Walk though the year and lay down our defaults according to the season on that date
current_day = datetime.date(CALC_YEAR, 1, 1)
while current_day.year == CALC_YEAR:

    cdate = current_day.strftime('%Y-%m-%d')
    full_year[cdate] = BaseDay(current_day, season_ticker.current())
    # print cdate + ': WEEKDAY ' + full_year[cdate]['weekday'] + ' // SEASON ' + full_year[cdate]['season'].code + ' // COLOR ' + full_year[cdate]['color'] + ' // PRECEDENCE ' + str(full_year[cdate]['precedence']) + ' // SCHEDULE ' + full_year[cdate]['season'].pattern(current_day).schedule(current_day).name
    print full_year[cdate]

    current_day = current_day + datetime.timedelta(days=1)
    if (current_day > season_ticker.ends):
        season_ticker.advance()

