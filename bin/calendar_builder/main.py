#!/usr/bin/python

import copy
import datetime
import psycopg2
import psycopg2.extras
import sys

# Make sure we have a config
try:
    from config import config
except IOError:
    print "Cannot find database configuration"
    sys.exit(1)

# Import internal packages
import season

DB_DSN = "host='%s' dbname='%s' user='%s' password='%s'" %(config['database']['host'], config['database']['database'], config['database']['user'], config['database']['password'])
try:
    conn = psycopg2.connect(DB_DSN)
except:
    print "Cannot connect to the database"
    sys.exit(2)

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

# Season ticker
season_ticker = season.YearIterator(conn, CALC_YEAR)

# Walk though the year and lay down our defaults according to the season on that date
current_day = datetime.date(CALC_YEAR, 1, 1)
while current_day.year == CALC_YEAR:

    cdate = current_day.strftime('%Y-%m-%d')
    full_year[cdate] = copy.deepcopy(base_day)
    full_year[cdate]['date'] = copy.deepcopy(current_day)
    full_year[cdate]['season'] = season_ticker.current()
    full_year[cdate]['weekday'] = current_day.strftime('%A').lower()
    full_year[cdate]['precedence'] = season_ticker.current().precedence(current_day)
    full_year[cdate]['color'] = season_ticker.current().column('color')
    print cdate + ': WEEKDAY ' + full_year[cdate]['weekday'] + ' // SEASON ' + full_year[cdate]['season'].column('code') + ' // COLOR ' + full_year[cdate]['color'] + ' // PRECEDENCE ' + str(full_year[cdate]['precedence'])

    current_day = current_day + datetime.timedelta(days=1)
    if (current_day > season_ticker.ends):
        season_ticker.advance()

