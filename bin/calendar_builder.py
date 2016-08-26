#!/usr/bin/python

import copy
import datetime
from dateutil.easter import *
import json
import os
import psycopg2
import psycopg2.extras
import sys

# This is the hacky first version for getting the basic work laid down.  It can
# be broken into reasonably sized modules later.

# Class describing a season
class Season:
    "A season of the church year"

    def __init__(self, row):
        "Initializes a season from a database row"
        self.name = row['name']
        self.code = row['code']
        self.color = row['color']
        self.weekday_precedence = row['weekday_precedence']
        self.calc = {
            'algorithm': row['algorithm'],
            'distance': row['distance'],
            'holiday': row['calculate_from'],
        }

    def end_date(self, start_date):
        "Gets the end date for this season, given a start date"
        if self.calc['holiday'] == 'easter':
            holiday = easter(start_date.year)
        elif self.calc['holiday'] == 'christmas':
            holiday = datetime.date(start_date.year, 12, 25)
        else:
            raise ValueError('"{holiday}" is an unknown calculation starting point for seasons; use "christmas" or "easter"'.format(holiday=repr(holiday)))
        return getattr(boundary_algorithms, self.calc['algorithm'])(holiday, self.calc['distance'])

    def precedence(self, day):
        "Gets the precedence for a given date, assumed to be within the season"
        weekday = day.strftime('%A').lower()
        if weekday == 'sunday':
            return SUNDAY_PRECEDENCE
        else:
            return self.weekday_precedence


class SeasonIterator:
    "Class for stepping through seasons in a year"

    def __init__(self, conn, year):
        "Sets up the iterator"
        self.conn = conn
        self.load_seasons(year)

        # The year starts in the Christmas season of the previous year, so load that up as our current season
        self.current_index = 0
        self.started = datetime.date(CALC_YEAR - 1, 12, 25)
        self.ends = self.current().end_date(self.started)

    def load_seasons(self, year):
        "Fetches the seasons from the database needed for a year"
        # Arbitrary rule: seasons for a year are noted valid for the first of that year,
        # even though the church year properly begins with Advent.
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        cur.execute("SELECT name, code, color, weekday_precedence, calculate_from, algorithm, distance " +
            "FROM liturigal_seasons " +
            "WHERE valid_for_date(%(jan_first)s, valid_start, valid_end) " +
            "ORDER BY sort_order",
            { "jan_first": datetime.date(year, 1, 1).strftime('%Y-%m-%d') })
        found = cur.fetchall()
        self.by_code = {}
        self.loop = []
        for row in found:
            self.by_code[row['code']] = Season(row)
            self.loop.append(row['code'])

    def current(self):
        "Returns the current season"
        code = self.loop[self.current_index]
        return self.by_code[code]

    def advance(self):
        "Tick forward by one season"
        start = self.ends + datetime.timedelta(days=1)
        if (self.current_index + 1 < len(self.loop)):
            self.current_index = self.current_index + 1
        else:
            self.current_index = 0
        self.started = start
        self.ends = self.current().end_date(start)


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

# Config-type stuff
SUNDAY_PRECEDENCE = 35

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
season_ticker = SeasonIterator(conn, CALC_YEAR)

# Walk though the year and lay down our defaults according to the season on that date
current_day = datetime.date(CALC_YEAR, 1, 1)
while current_day.year == CALC_YEAR:

    cdate = current_day.strftime('%Y-%m-%d')
    full_year[cdate] = copy.deepcopy(base_day)
    full_year[cdate]['date'] = copy.deepcopy(current_day)
    full_year[cdate]['season'] = season_ticker.current()
    full_year[cdate]['weekday'] = current_day.strftime('%A').lower()
    full_year[cdate]['precedence'] = season_ticker.current().precedence(current_day)
    full_year[cdate]['color'] = season_ticker.current().color
    print cdate + ': WEEKDAY ' + full_year[cdate]['weekday'] + ' // SEASON ' + full_year[cdate]['season'].code + ' // COLOR ' + full_year[cdate]['color'] + ' // PRECEDENCE ' + str(full_year[cdate]['precedence'])

    current_day = current_day + datetime.timedelta(days=1)
    if (current_day > season_ticker.ends):
        season_ticker.advance()

