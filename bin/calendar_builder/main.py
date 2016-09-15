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

    def __init__(self, day, season, sunday_count):
        self.day = copy.deepcopy(day)
        self.season = season
        self.sunday_count = sunday_count
        pattern = self.season.pattern(self.day)
        if pattern.has_vigil(self.day):
            self.base_block = BaseBlock(color = self.season.color,
                name = self.season.day_name(day, sunday_count = self.sunday_count),
                note = self.season.day_note(day),
                schedule = pattern.schedule(self.day, has_vigil = True))
            self.vigil_block = BaseBlock(color = self.season.color,
                name = self.season.day_name(day, is_vigil = True, sunday_count = self.sunday_count),
                note = self.season.day_note(day),
                schedule = pattern.schedule(self.day, is_vigil = True))
        else:
            self.base_block = BaseBlock(color = self.season.color,
                name = self.season.day_name(day, sunday_count = self.sunday_count),
                note = self.season.day_note(day),
                schedule = pattern.schedule(self.day))
            self.vigil_block = None

    def weekday(self):
        return self.day.strftime('%A').lower()[:3]

    def precedence(self):
        return self.season.precedence(self.day)

    def __repr__(self):
        rep = self.day.strftime('%Y-%m-%d') + ':'
        rep += "\n\t" + str(self.base_block)
        if self.vigil_block is not None:
            rep += "\n\t" + str(self.vigil_block)
        return rep

class BaseBlock:
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

# Season ticker
season_ticker = YearIterator(session, CALC_YEAR)

# Walk though the year and lay down our defaults according to the season on that date
current_day = datetime.date(CALC_YEAR, 1, 1)
while current_day.year == CALC_YEAR:

    cdate = current_day.strftime('%Y-%m-%d')
    full_year[cdate] = BaseDay(current_day, season_ticker.current(), season_ticker.sunday_count)
    # print cdate + ': WEEKDAY ' + full_year[cdate]['weekday'] + ' // SEASON ' + full_year[cdate]['season'].code + ' // COLOR ' + full_year[cdate]['color'] + ' // PRECEDENCE ' + str(full_year[cdate]['precedence']) + ' // SCHEDULE ' + full_year[cdate]['season'].pattern(current_day).schedule(current_day).name
    print full_year[cdate]

    current_day = current_day + datetime.timedelta(days=1)
    if current_day.strftime('%A').lower()[:3] == 'sat':
        season_ticker.next_sunday()
    if (current_day > season_ticker.ends):
        season_ticker.advance()

