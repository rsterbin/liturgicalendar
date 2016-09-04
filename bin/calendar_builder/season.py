# Classes for handling the seasons of the church year

import datetime
import psycopg2
import psycopg2.extras

from models.Season import Season

class YearIterator:
    """Class for stepping through seasons in a year"""

    def __init__(self, conn, year):
        """Sets up the iterator"""
        self.conn = conn
        self.load_seasons(year)

        # The year starts in the Christmas season of the previous year, so load that up as our current season
        self.current_index = 0
        self.started = datetime.date(year - 1, 12, 25)
        self.ends = self.current().end_date(self.started)

    def load_seasons(self, year):
        """Fetches the seasons from the database needed for a year"""
        # Arbitrary rule: seasons for a year are noted valid for the first of that year,
        # even though the church year properly begins with Advent.
        cur = self.conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        cur.execute("""SELECT
                season_id AS ssn_season_id,
                name AS ssn_name,
                code AS ssn_code,
                color AS ssn_color,
                weekday_precedence AS ssn_weekday_precedence,
                calculate_from AS ssn_calculate_from,
                algorithm AS ssn_algorithm,
                distance AS ssn_distance
            FROM liturigal_seasons
            WHERE valid_for_date(%(jan_first)s, valid_start, valid_end)
            ORDER BY sort_order""", {
                "jan_first": datetime.date(year, 1, 1).strftime('%Y-%m-%d'),
                "dec_last": datetime.date(year, 12, 31).strftime('%Y-%m-%d'),
            })
        found = cur.fetchall()
        self.by_code = {}
        self.loop = []
        for row in found:
            if (row['ssn_code'] not in self.by_code):
                model = Season()
                model.load(row)
                code = model.column('code')
                self.by_code[code] = model
                self.loop.append(code)

    def current(self):
        """Returns the current season"""
        code = self.loop[self.current_index]
        return self.by_code[code]

    def advance(self):
        """Tick forward by one season"""
        start = self.ends + datetime.timedelta(days=1)
        if (self.current_index + 1 < len(self.loop)):
            self.current_index = self.current_index + 1
        else:
            self.current_index = 0
        self.started = start
        self.ends = self.current().end_date(start)

