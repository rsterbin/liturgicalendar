import datetime
from sqlalchemy import text
from sqlalchemy.orm import eagerload,joinedload
import sys

from ..models import Override

class Overrides:
    """Class for fetching custom overrides to be placed over the static calendar"""

    def __init__(self, session):
        """Sets up the placer"""
        self.session = session

    def get_year(self, year):
        """Gets the overrides for a year as dictionaries suitable for overriding the static calendar"""
        for_year = []
        for instance in self.session.query(Override).\
                options(joinedload(Override.services)).\
                filter(text("target_date BETWEEN :year_start AND :year_end")).\
                params(year_start=datetime.date(year, 1, 1).strftime('%Y-%m-%d'),\
                    year_end=datetime.date(year, 12, 31).strftime('%Y-%m-%d')).\
                order_by(Override.target_date, Override.target_block, Override.id):
            for_year.append(instance)
        all_overrides = []
        for o in for_year:
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

    def get_range(self, start, end):
        """Gets the overrides for a time range as dictionaries suitable for overriding the static calendar"""
        for_range = []
        for instance in self.session.query(Override).\
                options(joinedload(Override.services)).\
                filter(text("target_date BETWEEN :range_start AND :range_end")).\
                params(range_start=start.strftime('%Y-%m-%d'),\
                    range_end=end.strftime('%Y-%m-%d')).\
                order_by(Override.target_date, Override.target_block, Override.id):
            for_range.append(instance)
        all_overrides = []
        for o in for_range:
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

