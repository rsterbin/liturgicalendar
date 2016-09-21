#!/usr/bin/python

import datetime
import logging
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.engine.url import URL
import sys

from season import YearIterator
from resolution import ResolutionDay

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

# Calculate for this year
CALC_YEAR = 2012

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

# Season ticker
season_ticker = YearIterator(session, CALC_YEAR)

# Walk though the year and lay down our defaults according to the season on that date
while season_ticker.day.year == CALC_YEAR:

    cdate = season_ticker.day.strftime('%Y-%m-%d')
    sys.stderr.write(cdate + ' // SUNDAY COUNT ' + str(season_ticker.sunday_count) + ' // LAST WEEK ' + str(season_ticker.is_last_week()) + "\n")
    full_year[cdate] = ResolutionDay(season_ticker.day, season_ticker.current(), season_ticker.sunday_count, season_ticker.is_last_week())
    # print cdate + ': WEEKDAY ' + full_year[cdate]['weekday'] + ' // SEASON ' + full_year[cdate]['season'].code + ' // COLOR ' + full_year[cdate]['color'] + ' // PRECEDENCE ' + str(full_year[cdate]['precedence']) + ' // SCHEDULE ' + full_year[cdate]['season'].pattern(current_day).schedule(current_day).name
    print full_year[cdate]

    season_ticker.advance_by_day()

