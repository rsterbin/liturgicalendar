#!/usr/bin/python

import datetime
from dateutil.easter import *
import json
import os
import psycopg2
import psycopg2.extras
import sys

# This is the hacky first version for getting the basic work laid down.  It can
# be broken into reasonably sized modules later.

# Connect to the database
DB_CONFIG_PATH = os.path.dirname(os.path.realpath(__file__)) + '/config.json'
cfg = {}
try:
    with open(DB_CONFIG_PATH) as f:
        config_json = f.read()
        cfg = json.loads(config_json)
except IOError:
    print "Cannot find database configuration"
    sys.exit(1)
DB_DSN = "host='%s' dbname='%s' user='%s' password='%s'" %(cfg.get('host'), cfg.get('database'), cfg.get('user'), cfg.get('password'))
try:
    conn = psycopg2.connect(DB_DSN)
except:
    print "Cannot connect to the database"
    sys.exit(2)

# Calculate for the church year starting with Advent 2014
CALC_YEAR = 2014

# Listings we'll be filling in
full_year = {}
base_day = {
    'season': '',
    'holiday_day': '',
    'holiday_eve': '',
}

# Start by pinning down Easter and Christmas
CHRISTMAS1 = datetime.date(CALC_YEAR, 12, 25)
EASTER = easter(CALC_YEAR + 1)
CHRISTMAS2 = datetime.date(CALC_YEAR + 1, 12, 25)

# Calculate the season boundries
class boundary_algorithms:
    "Algorithms for calculating season boundaries"

    @staticmethod
    def days_before(holiday_date, number):
        "Finds a number of days before the given holiday"
        return holiday_date - datetime.timedelta(days=number)

    @staticmethod
    def days_after(holiday_date, number):
        "Finds a number of days after the given holiday"
        return holiday_date + datetime.timedelta(days=number)

    @staticmethod
    def weeks_before(holiday_date, number):
        "Finds a number of weeks before the given holiday"
        return holiday_date - datetime.timedelta(weeks=number)

    @staticmethod
    def weeks_after(holiday_date, number):
        "Finds a number of weeks after the given holiday"
        return holiday_date + datetime.timedelta(weeks=number)

    @staticmethod
    def tuesdays_before(holiday_date, number):
        "Finds the nth Tuesday before the holiday"
        return holiday_date - datetime.timedelta(days=holiday_date.weekday()) + datetime.timedelta(days=1, weeks=-1*number)

    @staticmethod
    def saturdays_before(holiday_date, number):
        "Finds the nth Saturday before the holiday"
        return holiday_date - datetime.timedelta(days=holiday_date.weekday()) + datetime.timedelta(days=5, weeks=-1*number)

# Arbitrary rule: seasons for a year are noted valid for the Christmas of that
# church year.
#  e.g., to change the summer schedule boundaries starting in 2005, set valid_end
#  to any date between 2003-12-26 and 2004-12-24.
cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
cur.execute("SELECT name, code, color, calculate_from, church_year, algorithm, distance " +
    "FROM liturigal_seasons " +
    "WHERE valid_for_date(%(christmas)s, valid_start, valid_end) " +
    "ORDER BY sort_order",
    { "christmas": CHRISTMAS1.strftime('%Y-%m-%d') })
seasons = cur.fetchall()

seasons_by_code = {}

for row in seasons:
    print row['name'] + ' // ' + row['calculate_from'] + ' // ' + row['algorithm'] + ' // ' + str(row['distance'])
    if row['calculate_from'] == 'easter':
        holiday = EASTER
    elif row['calculate_from'] == 'christmas':
        if row['church_year'] == 0:
            holiday = CHRISTMAS1
        else:
            holiday = CHRISTMAS2
    end_date = getattr(boundary_algorithms, row['algorithm'])(holiday, row['distance'])
    print 'Ends: ' + end_date.strftime('%m/%d/%Y')
    seasons_by_code[row['code']] = {
        'name': row['name'],
        'code': row['code'],
        'color': row['color'],
        'end_date': end_date,
    }

print seasons_by_code

