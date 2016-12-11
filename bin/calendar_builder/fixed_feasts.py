import datetime
from sqlalchemy import text
from sqlalchemy.orm import eagerload,joinedload
import sys

from models import FixedFeast, ServicePattern

class FixedFeasts:
    """Class for placing fixed feasts in a year"""

    def __init__(self, session, year):
        """Sets up the placer"""
        self.session = session
        self.year = year
        self.load_feasts()

    def load_feasts(self):
        """Loads the feasts for this year"""
        self.by_day = {}
        for instance in self.session.query(FixedFeast).\
                options(joinedload(FixedFeast.otype)).\
                options(joinedload(FixedFeast.all_patterns)).\
                options(joinedload(FixedFeast.all_eve_patterns)).\
                filter(text("valid_for_date(:jan_first, fixed_feasts.valid_start, fixed_feasts.valid_end)")).\
                params(jan_first=datetime.date(self.year, 1, 1).strftime('%Y-%m-%d')).\
                order_by(FixedFeast.month, FixedFeast.mday):
            day = instance.day(self.year).strftime('%Y-%m-%d')
            if day not in self.by_day:
                self.by_day[day] = []
                self.by_day[day].append(instance)

    def feasts_by_date(self):
        """Selects the right feast for each day"""
        by_date = []
        for day in self.by_day:
            f = self.by_day[day][0]
            by_date.append({ 'day': f.day(self.year), 'feasts': self.by_day[day] })
        return by_date

