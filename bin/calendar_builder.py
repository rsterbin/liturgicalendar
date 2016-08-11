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

CALC_YEAR = 2014

# Start by pinning down Easter and Christmas
EASTER = easter(CALC_YEAR)
CHRISTMAS = datetime.date(CALC_YEAR, 12, 25)

# Calculate the season boundries
class boundary_algorithms:
    "Algorithms for calculating season boundaries"

    @staticmethod
    def days_before():
        "Finds a number of days before the given holiday"
        return 'Testing days_before'

    @staticmethod
    def days_after():
        "Finds a number of days after the given holiday"
        return 'Testing days_after'

    @staticmethod
    def weeks_before():
        "Finds a number of weeks before the given holiday"
        return 'Testing weeks_before'

    @staticmethod
    def weeks_after():
        "Finds a number of weeks after the given holiday"
        return 'Testing weeks_after'

cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
cur.execute("select name, code, color, calculate_from, algorithm, distance from liturigal_seasons order by sort_order")
seasons = cur.fetchall()

for row in seasons:
    print row['name']
    print getattr(boundary_algorithms, row['algorithm'])()

