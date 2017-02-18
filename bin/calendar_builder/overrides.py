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
        self.by_day = {}
        for instance in self.session.query(Override).\
                options(joinedload(Override.services)).\
                filter(text("target_date BETWEEN :year_start AND :year_end")).\
                params(year_start=datetime.date(self.year, 1, 1).strftime('%Y-%m-%d'),\
                    year_end=datetime.date(self.year, 12, 31).strftime('%Y-%m-%d')).\
                order_by('target_date'):
            day = instance.target_date.strftime('%Y-%m-%d')
            if day not in self.by_day:
                self.by_day[day] = []
                self.by_day[day].append(instance)

    def overrides_by_date(self):
        """Selects the right override for each day"""
        by_date = []
        for day in self.by_day:
            o = self.by_day[day][0]
            by_date.append({ 'day': o.day(self.year), 'overrides': self.by_day[day] })
        return by_date


