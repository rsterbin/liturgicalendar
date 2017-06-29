import datetime
from sqlalchemy import text
from sqlalchemy.orm import eagerload,joinedload
import sys

from ..models import Calculated

class Calculated:
    """Class for pulling previously calculated years"""

    def __init__(self, session):
        """Sets up the fetcher"""
        self.session = session

    def check_year(self, year):
        """Checks whether the base schedule has been calculated for this year"""

        # TODO: START HERE
        for instance in self.session.query(Calculated).\
                options(joinedload(Override.services)).\
                filter(text("target_date BETWEEN :year_start AND :year_end")).\
                params(year_start=datetime.date(self.year, 1, 1).strftime('%Y-%m-%d'),\
                    year_end=datetime.date(self.year, 12, 31).strftime('%Y-%m-%d')).\
                order_by(Override.target_date, Override.target_block, Override.id):
            self.for_year.append(instance)


