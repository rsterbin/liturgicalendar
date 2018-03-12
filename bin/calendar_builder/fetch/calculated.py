import copy
import datetime
from sqlalchemy import text
from sqlalchemy.orm import eagerload,joinedload
import sys

from ..models import Calculated as ModelCalculated
from ..models import Cached as ModelCached
from ..static import StaticRange
from .. import utils

class Calculated:
    """Class for pulling previously calculated years"""

    def __init__(self, session):
        """Sets up the fetcher"""
        self.session = session
        self.by_date = {}

    def check_year(self, year):
        """Checks whether the base schedule has been calculated for this year"""
        start = datetime.date(year, 1, 1)
        end = datetime.date(year, 12, 31)
        for instance in self.session.query(ModelCalculated).\
                options(joinedload(ModelCalculated.services)).\
                filter(text("target_date BETWEEN :year_start AND :year_end")).\
                params(year_start=start.strftime('%Y-%m-%d'),\
                    year_end=end.strftime('%Y-%m-%d')).\
                order_by(ModelCalculated.target_date, ModelCalculated.target_block, ModelCalculated.id):
            td = utils.day_to_lookup(instance.target_date)
            if td not in self.by_date:
                self.by_date[td] = []
            self.by_date[td].append(instance)
        return self.ok_for_range(start, end)

    def check_window(self, start, end):
        """Checks whether the schedule has been calculated for this window"""
        for instance in self.session.query(ModelCalculated).\
                options(joinedload(ModelCalculated.services)).\
                filter(text("target_date BETWEEN :start_date AND :end_date")).\
                params(start_date=start.strftime('%Y-%m-%d'),\
                    end_date=end.strftime('%Y-%m-%d')).\
                order_by(ModelCalculated.target_date, ModelCalculated.target_block, ModelCalculated.id):
            td = utils.day_to_lookup(instance.target_date)
            if td not in self.by_date:
                self.by_date[td] = []
            self.by_date[td].append(instance)
        return self.ok_for_range(start, end)

    def ok_for_range(self, start, end):
        """Checks that every date in the range has a match in the directory given"""
        check_day = copy.deepcopy(start)
        while check_day <= end:
            cdate = utils.day_to_lookup(check_day)
            if cdate not in self.by_date:
                return False
            check_day = check_day + datetime.timedelta(days=1)
        return True

    def load_static_range(self, start, end):
        """Builds a StaticRange from the data in the calculated table for a given range"""
        static_range = StaticRange(start, end, self.session)
        overrides = []
        for cdate in sorted(self.by_date.iterkeys()):
            objs = self.by_date[cdate]
            for obj in objs:
                overrides.append(self._obj_to_override(obj))
        static_range.override(overrides)
        return static_range

    def _obj_to_override(self, obj):
        """Converts a calculated object (model from lookup) into a dictionary suitable for static overrides"""
        override = {}
        override['day'] = obj.target_date
        override['target_block'] = obj.target_block
        override['color'] = obj.color
        override['name'] = obj.name
        override['note'] = obj.note
        override['services'] = []
        for service in obj.services:
            override['services'].append({ 'name': service.name, 'start_time': service.start_time })
        return override

