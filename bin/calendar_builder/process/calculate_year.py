import argparse
import datetime
import logging
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.engine.url import URL

from ..resolution import Resolution
from ..fetch.overrides import Overrides
from ..storage import Storage

# Make sure we have a config
try:
    from ..config import config
except IOError:
    raise RuntimeError("Cannot find database configuration")

def handle_args():
    """ Gathers commmand line options and sets up logging according to the verbose param.  Returns the parsed args """
    parser = argparse.ArgumentParser(description='Calculate the liturgical calendar for a given year')
    parser.add_argument('year', type=int, help='the year you want to build')
    parser.add_argument('--dry-run', '-d', action='store_true', help='print the calculated year rather than storing it')
    parser.add_argument('--rules-only', '-r', action='store_true', help='use regular rules only: do not include any one-time overrides')
    parser.add_argument('--show-extras', action='store_true', help='after calculating, print any feasts/holidays that fell outside the year (used only on dry run)')
    parser.add_argument('--verbose', '-v', action='count')
    args = parser.parse_args()

    if args.verbose == 1:
        logging.basicConfig(level=logging.INFO)
    elif args.verbose == 2:
        logging.basicConfig(level=logging.DEBUG)
    elif args.verbose >= 3:
        logging.basicConfig(level=logging.DEBUG)
        logging.getLogger('sqlalchemy.engine').setLevel(logging.INFO)
    else:
        logging.basicConfig(level=logging.WARNING)

    return args

def db_connect():
    """ Performs database connection using database settings from settings.py.  Returns sqlalchemy engine instance """
    return create_engine(URL(**config['database']))

def print_year(static, add_extras=False):
    """ Prints out the full year, with blank lines between months """
    current_month = 1
    for cdate in sorted(static.full_year.iterkeys()):
        if current_month != static.full_year[cdate].day.month:
            print ""
            current_month = static.full_year[cdate].day.month
        print static.full_year[cdate]
    if add_extras:
        print ""
        print "Any extras:"
        for cdate in sorted(resolution.extras.iterkeys()):
            print cdate + ": "
            for f in resolution.extras[cdate]:
                print f

def store_calculated(year, logger, static, session):
    """ Stores the calculated year """

def main():
    """ Runs the whole shebang """
    logger = logging.getLogger(__name__)
    args = handle_args()

    # DB Setup
    engine = db_connect()
    Session = sessionmaker(bind=engine)

    # Calculate for this year
    CALC_YEAR = args.year

    # Primary calculation
    logger.info('Calculating year...')
    fetching_session = Session()
    resolution = Resolution(fetching_session)
    static = resolution.calculate_year(CALC_YEAR)
    logger.info('done')

    # If this is not a dry run, save to the database as a calculated year
    if not args.dry_run:
        logger.info('Saving the cacluclated year...')
        calc_save_session = Session()
        storage = Storage(CALC_YEAR, calc_save_session)
        storage.save_calculated(static)
        calc_save_session.commit()
        logger.info('done')
        pass

    # Rules only: stop here
    if args.rules_only:
        if args.dry_run:
            print_year(static, args.show_extras)
        return

    # Add overrides
    overrides = Overrides(fetching_session, CALC_YEAR)
    static.override(overrides.get_all())
    logger.debug('Added overrides')

    # If this is a dry run, print and stop
    if args.dry_run:
        print_year(static, args.show_extras)
        return

    # Store to database as a cached year
    logger.info('Saving the cacluclated year...')
    cache_save_session = Session()
    storage = Storage(CALC_YEAR, cache_save_session)
    storage.save_cached(static)
    cache_save_session.commit()
    logger.info('done')

