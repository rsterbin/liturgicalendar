#!/usr/bin/python

import datetime
import logging
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.engine.url import URL
import sys

from resolution import Resolution

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
# logging.getLogger('sqlalchemy.engine').setLevel(logging.INFO)

engine = db_connect()
Session = sessionmaker(bind=engine)
session = Session()

# Calculate for this year
CALC_YEAR = 2012

# Start up Resolution for this year
resolution = Resolution(CALC_YEAR, session)

# Set up the season framework
resolution.import_seasons()

# Add moveable feasts
resolution.import_moveable_feasts()

# Resolve and show
for cdate in sorted(resolution.full_year.iterkeys()):
    resolution.full_year[cdate].resolve()
    print resolution.full_year[cdate]

