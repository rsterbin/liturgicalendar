import argparse
import datetime
import logging
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.engine.url import URL

from resolution import Resolution
from fetch.overrides import Overrides
from storage import Storage

# Make sure we have a config
try:
    from config import config
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

def primary_calculation(year, logger, session):
    """ Does the initial caclulation (no overrides) """

    # Start up Resolution for this year
    logger.info('Starting resolution for ' + str(year))
    resolution = Resolution(year, session)

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

    return static

def store_calculated(year, logger, static, session):
    """ Stores the calculated year """
    logger.info('Saving the cacluclated year...')
    storage = Storage(year, session)
    storage.save_calculated(static)
    logger.info('done')

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
    fetching_session = Session()
    static = primary_calculation(CALC_YEAR, logger, fetching_session)

    # If this is not a dry run, save to the database as a calculated year
    if not args.dry_run:
        calc_save_session = Session()
        store_calculated(CALC_YEAR, logger, static, calc_save_session)
        calc_save_session.commit()
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

    # TODO: Store to database as a cached year

