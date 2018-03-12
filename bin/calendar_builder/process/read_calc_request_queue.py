import argparse
import boto3
import datetime
import dateutil
import json
import logging
import signal
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.engine.url import URL
import sys
import time

from ..fetch.calculated import Calculated
from ..fetch.overrides import Overrides
from ..resolution import Resolution
from ..storage import Storage

# Make sure we have a config
try:
    from ..config import config
except IOError:
    raise RuntimeError("Cannot find configuration")

def handle_args():
    """ Gathers commmand line options and sets up logging according to the verbose param.  Returns the parsed args """
    parser = argparse.ArgumentParser(description='Checks the queue for new messages and caclulates the calendar as needed')
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

def handle_signal(signal, frame):
    """Finish properly in case of signal"""
    logger.info('Stopped')
    sys.exit(0)

def db_connect():
    """ Performs database connection using database settings from settings.py.  Returns sqlalchemy engine instance """
    return create_engine(URL(**config['database']))

def fetch_message(sqs, queue_url):
    """Fetches a message from the queue and parses it into a dictionary (keys: ok, start, end, handle)"""
    response = sqs.receive_message(
        QueueUrl = queue_url,
        AttributeNames = [ 'SentTimestamp' ],
        MaxNumberOfMessages = 1,
        MessageAttributeNames = [ 'All' ],
        WaitTimeSeconds = 5
    )

    parsed = { 'ok': True }

    if response.get('Messages'):
        m = response.get('Messages')[0]
        body = m['Body']
        receipt_handle = m['ReceiptHandle']

        try:
            query = json.loads(body)
        except ValueError:
            logger.warn('Message recieved was not valid json: ' + body)

        if query and 'start' in query and 'end' in query:
            dts = dateutil.parser.parse(query['start'])
            if dts is None:
                logger.warn('Could not parse start date string ' + query['start'])
                parsed['ok'] = False

            dte = dateutil.parser.parse(query['end'])
            if dte is None:
                logger.warn('Could not parse end date string ' + query['start'])
                parsed['ok'] = False

            if parsed['ok']:
                logger.info('Received message: ' + dts.isoformat() + ' to ' + dte.isoformat())
                parsed['start'] = dts
                parsed['end'] = dte
        else:
            logger.warn('Message recieved was not a valid calc request: ' + body)
            parsed['ok'] = False

        parsed['handle'] = receipt_handle
        return parsed

    else:
        logger.debug('No message')
        return None

def handle_request(message):
    """Looks at the start and end dates and builds as needed"""
    if not message['ok']:
        logger.error('Cannot handle bad request')
        return

    engine = db_connect()
    Session = sessionmaker(bind=engine)

    check_session = Session()
    calc = Calculated(check_session)

    # Static calendar already calculated? Skip the calculation step
    if calc.check_window(message['start'], message['end']):
        logger.info('Date range has been calculated')

    # No? Calculate each year that we need
    else:
        logger.info('Start year: ' + str(message['start'].year))
        logger.info('End year: ' + str(message['end'].year))

        plural = message['start'].year != message['end'].year
        if plural:
            logger.info('Checking years...')
        else:
            logger.info('Checking year...')
        curr = message['start'].year
        found = {}
        while curr <= message['end'].year:
            found[curr] = calc.check_year(curr)
            curr += 1
        logger.info('done')

        for y in found:
            if not found[y]:
                # If we need to calculate this year, do so
                logger.info('Year ' + str(y) + ': calculating base schedule...')
                fetching_session = Session()
                resolution = Resolution(fetching_session)
                static = resolution.calculate_year(y)
                logger.info('done')

                # Save what we did
                logger.info('Saving the cacluclated year...')
                calc_save_session = Session()
                storage = Storage(y, calc_save_session)
                storage.save_calculated(static)
                calc_save_session.commit()
                logger.info('done')

    # Load up the requested window
    static = calc.load_static_range(message['start'], message['end'])
    logger.debug('Loaded the static range')

    # Add overrides
    fetching_session = Session()
    overrides = Overrides(fetching_session)
    static.override(overrides.get_range(message['start'], message['end']))
    logger.debug('Added overrides')

    # Save to the cache
    logger.info('Saving the completed year...')
    cache_save_session = Session()
    storage = Storage(message['start'].year, cache_save_session)
    storage.save_cached(static)
    cache_save_session.commit()
    logger.info('done')


def main():
    """Checks the queue for new messages and caclulates as needed"""

    global logger
    logger = logging.getLogger(__name__)
    logger.info('Reading from the queue...')
    args = handle_args()

    signal.signal(signal.SIGINT, handle_signal)
    sqs = boto3.client('sqs')
    queue_url = config['message_queue']['calc_request_url']

    while True:
        message = fetch_message(sqs, queue_url)
        if message is not None:
            if message['ok']:
                handle_request(message)
            sqs.delete_message(
                QueueUrl = queue_url,
                ReceiptHandle = message['handle']
            )
        time.sleep(1)

