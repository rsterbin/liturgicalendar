#!/usr/bin/python

import argparse
import datetime
import logging
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.engine.url import URL
import sys

from resolution import Resolution
from overrides import Overrides

# Make sure we have a config
try:
    from config import config
except IOError:
    print "Cannot find database configuration"
    sys.exit(1)

# Check arguments
parser = argparse.ArgumentParser(description='Calculate the liturgical calendar for a given year')
parser.add_argument('year', type=int, help='the year you want to build')
parser.add_argument('--dry-run', '-d', action='store_true', help='print the calculated year rather than storing it')
parser.add_argument('--rules-only', '-r', action='store_true', help='use regular rules only: do not include any one-time overrides')
parser.add_argument('--show-extras', action='store_true', help='after calculating, print any feasts/holidays that fell outside the year (used only on dry run)')
parser.add_argument('--verbose', '-v', action='count')
args = parser.parse_args()

# DB connection function
def db_connect():
    """
    Performs database connection using database settings from settings.py.
    Returns sqlalchemy engine instance
    """
    return create_engine(URL(**config['database']))

if args.verbose == 1:
    logging.basicConfig(level=logging.INFO)
elif args.verbose == 2:
    logging.basicConfig(level=logging.DEBUG)
elif args.verbose >= 3:
    logging.basicConfig(level=logging.DEBUG)
    logging.getLogger('sqlalchemy.engine').setLevel(logging.INFO)
else:
    logging.basicConfig(level=logging.WARNING)

logger = logging.getLogger(__name__)

engine = db_connect()
Session = sessionmaker(bind=engine)
session = Session()

# Calculate for this year
CALC_YEAR = args.year

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

# Freeze the current state
logger.info('Freezing current state...')
static = resolution.freeze()
logger.info('done')

# TODO: Not a dry run? Store to the database as a calculated year

# Add overrides
overrides = Overrides(session, CALC_YEAR)
static.override(overrides.get_all())
logger.debug('Added overrides')

# If this is a dry run, print out the results
if args.dry_run:
    current_month = 1
    for cdate in sorted(static.full_year.iterkeys()):
        if current_month != static.full_year[cdate].day.month:
            print ""
            current_month = static.full_year[cdate].day.month
        print static.full_year[cdate]
    if args.show_extras:
        print ""
        print "Any extras:"
        for cdate in sorted(resolution.extras.iterkeys()):
            print cdate + ": "
            for f in resolution.extras[cdate]:
                print f
    sys.exit(0)

# TODO: Store to database as a cached year

