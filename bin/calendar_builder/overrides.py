import datetime
from sqlalchemy import text
from sqlalchemy.orm import eagerload,joinedload
import sys

from models import Override

class Overrides:
    """Class for placing overrides in a year"""

    def __init__(self, session, year):
        """Sets up the placer"""
        self.session = session
        self.year = year
        self.load_overrides()

    def load_overrides(self):
        """Loads the overrides for this year"""
        self.for_year = []
        for instance in self.session.query(Override).\
                options(joinedload(Override.services)).\
                filter(text("target_date BETWEEN :year_start AND :year_end")).\
                params(year_start=datetime.date(self.year, 1, 1).strftime('%Y-%m-%d'),\
                    year_end=datetime.date(self.year, 12, 31).strftime('%Y-%m-%d')).\
                order_by(Override.target_date, Override.target_block, Override.id):
            self.for_year.append(instance)

    def get_all(self):
        """Gets all the overrides as dictionaries suitable for overriding the static calendar"""
        all_overrides = []
        for o in self.for_year:
            override = {}
            override['day'] = o.target_date
            override['target_block'] = o.target_block
            override['color'] = o.color
            override['name'] = o.name
            override['services'] = []
            for s in o.services:
                override['services'].append({ 'name': s.name, 'start_time': s.start_time })
            all_overrides.append(override)
        return all_overrides

