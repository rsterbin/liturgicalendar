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

logging.basicConfig(level=logging.DEBUG)
# logging.getLogger('sqlalchemy.engine').setLevel(logging.INFO)

logger = logging.getLogger(__name__)

engine = db_connect()
Session = sessionmaker(bind=engine)
session = Session()

def usage():
    """Prints the proper usage of this script"""
    print "\n".join((
        "   calendar_builder/main.py <year>",
        "",
        "Pass in the year you want to build as the first argument.",
    ))
    sys.exit(0)

# Calculate for this year
if len(sys.argv) != 2:
    usage()
try:
    CALC_YEAR = int(sys.argv[1])
except ValueError:
    usage()

# Start up Resolution for this year
logger.info('Starting resolution for ' + str(CALC_YEAR))
resolution = Resolution(CALC_YEAR, session)

# Set up the season framework
logger.info('Importing seasons...')
resolution.import_seasons()
logger.info('done')

# Add moveable feasts
logger.info('Adding moveable feasts...')
resolution.import_moveable_feasts()
logger.info('done')

# Add fixed feasts
logger.info('Adding fixed feasts...')
resolution.import_fixed_feasts()
logger.info('done')

# Add federal holidays
logger.info('Adding federal holidays...')
resolution.import_federal_holidays()
logger.info('done')

# Resolve
logger.info('Resolving...')
for cdate in sorted(resolution.full_year.iterkeys()):
    resolution.full_year[cdate].resolve()
logger.info('done')

# Add floating feasts and re-resolve
logger.info('Adding floating feasts...')
resolution.import_floating_feasts()
for cdate in sorted(resolution.full_year.iterkeys()):
    resolution.full_year[cdate].resolve()
logger.info('done')

current_month = 1
for cdate in sorted(resolution.full_year.iterkeys()):
    if current_month != resolution.full_year[cdate].day.month:
        print ""
        current_month = resolution.full_year[cdate].day.month
    print resolution.full_year[cdate]

# print ""
# print "Any extras:"
# for cdate in sorted(resolution.extras.iterkeys()):
#     print cdate + ": "
#     for f in resolution.extras[cdate]:
#         print f

