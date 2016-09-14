import datetime
from dateutil.easter import *
from sqlalchemy import Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base

from config import config
from boundary_algorithms import boundary_algorithms

DeclarativeBase = declarative_base()

class Season(DeclarativeBase):
    """Sqlalchemy seasons model"""
    __tablename__ = "seasons"

    id = Column('season_id', Integer, primary_key=True)
    name = Column(String)
    code = Column(String)
    color = Column(String)
    weekday_precedence = Column(Integer)
    calculate_from = Column(String)
    algorithm = Column(String)
    distance = Column(Integer)
    sort_order = Column(Integer)

    def __repr__(self):
        return self.name + ' <' + self.code + '> // COLOR ' + self.color + ' // PRECEDENCE ' + str(self.weekday_precedence)

    def end_date(self, start_date):
        """Gets the end date for this season, given a start date"""
        if self.calculate_from == 'easter':
            holiday = easter(start_date.year)
        elif self.calculate_from == 'christmas':
            holiday = datetime.date(start_date.year, 12, 25)
        else:
            raise ValueError('"{holiday}" is an unknown calculation starting point for seasons; use "christmas" or "easter"'.format(holiday=repr(self.calculate_from)))
        return getattr(boundary_algorithms, self.algorithm)(holiday, self.distance)

    def precedence(self, day):
        """Gets the precedence for a given date, assumed to be within the season"""
        weekday = day.strftime('%A').lower()
        if weekday == 'sunday':
            return config['sunday_precedence']
        else:
            return self.weekday_precedence

