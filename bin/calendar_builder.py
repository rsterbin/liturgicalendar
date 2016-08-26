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

# Class for calculating the season boundries
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

# Function to determine a season's end date
def get_season_end(season, year):
    "Gets the end date for a season and a year"
    if season['calculate_from'] == 'easter':
        holiday = easter(year + season['holiday_year'])
    elif season['calculate_from'] == 'christmas':
        holiday = datetime.date(year + season['holiday_year'], 12, 25)
    return getattr(boundary_algorithms, season['algorithm'])(holiday, season['distance'])

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

# Calculate for 2014
CALC_YEAR = 2014

# Listings we'll be filling in
full_year = {}
base_day = {
    'season': '',
    'holiday_day': '',
    'holiday_eve': '',
}

# Arbitrary rule: seasons for a year are noted valid for the first of that year,
# even though the church year properly begins with Advent.
cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
cur.execute("SELECT name, code, color, calculate_from, holiday_year, algorithm, distance " +
    "FROM liturigal_seasons " +
    "WHERE valid_for_date(%(jan_first)s, valid_start, valid_end) " +
    "ORDER BY sort_order",
    { "jan_first": datetime.date(CALC_YEAR, 1, 1).strftime('%Y-%m-%d') })
all_seasons = cur.fetchall()

seasons_by_code = {}
season_loop = []

for row in all_seasons:
    seasons_by_code[row['code']] = row
    season_loop.append(row['code'])

# The year starts in the Christmas season of the previous year.
current_season = {
    'index': 0,
    'started': datetime.date(CALC_YEAR - 1, 12, 25),
    'ends': get_season_end(seasons_by_code['christmas'], CALC_YEAR),
    'code': 'christmas',
    'color': seasons_by_code['christmas']['color'],
}
current_day = datetime.date(CALC_YEAR, 1, 1)
current_year = CALC_YEAR

while current_day.year == CALC_YEAR:
    print current_day.strftime('%m/%d/%Y') + ': SEASON ' + current_season['code'] + ' // COLOR ' + current_season['color']
    current_day = current_day + datetime.timedelta(days=1)
    if (current_day > current_season['ends']):
        if (current_season['index'] + 1 < len(season_loop)):
            current_season['index'] = current_season['index'] + 1
        else:
            current_season['index'] = 0
            current_year += 1
        print '----------- season boundary -----------'
        code = season_loop[current_season['index']]
        current_season['started'] = current_day
        current_season['ends'] = get_season_end(seasons_by_code[code], current_year)
        current_season['code'] = code
        current_season['color'] = seasons_by_code[code]['color']

