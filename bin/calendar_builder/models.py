import datetime
from dateutil.easter import *
from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, Boolean
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship

from config import config
from algorithms import boundary_algorithms
from valid_dates import valid_in_list

DeclarativeBase = declarative_base()

class Schedule(DeclarativeBase):
    """Sqlalchemy service patterns model"""
    __tablename__ = 'schedules'

    id = Column('schedule_id', Integer, primary_key=True)
    name = Column(String)
    code = Column(String, nullable=True)
    valid_start = Column(DateTime, nullable=True)
    valid_end = Column(DateTime, nullable=True)
    is_default = Column(Boolean)
    is_custom = Column(Boolean)

    def __repr__(self):
        return self.name + ' <' + self.code + '>'

class ServicePattern(DeclarativeBase):
    """Sqlalchemy service patterns model"""
    __tablename__ = 'service_patterns'

    id = Column('pattern_id', Integer, primary_key=True)
    name = Column(String)
    code = Column(String)
    schedule_code_mon = Column(String, ForeignKey('schedules.code'), nullable=True)
    schedule_code_mon_with_vigil = Column(String, ForeignKey('schedules.code'), nullable=True)
    schedule_code_mon_vigil = Column(String, ForeignKey('schedules.code'), nullable=True)
    schedule_code_tue = Column(String, ForeignKey('schedules.code'), nullable=True)
    schedule_code_tue_with_vigil = Column(String, ForeignKey('schedules.code'), nullable=True)
    schedule_code_tue_vigil = Column(String, ForeignKey('schedules.code'), nullable=True)
    schedule_code_wed = Column(String, ForeignKey('schedules.code'), nullable=True)
    schedule_code_wed_with_vigil = Column(String, ForeignKey('schedules.code'), nullable=True)
    schedule_code_wed_vigil = Column(String, ForeignKey('schedules.code'), nullable=True)
    schedule_code_thu = Column(String, ForeignKey('schedules.code'), nullable=True)
    schedule_code_thu_with_vigil = Column(String, ForeignKey('schedules.code'), nullable=True)
    schedule_code_thu_vigil = Column(String, ForeignKey('schedules.code'), nullable=True)
    schedule_code_fri = Column(String, ForeignKey('schedules.code'), nullable=True)
    schedule_code_fri_with_vigil = Column(String, ForeignKey('schedules.code'), nullable=True)
    schedule_code_fri_vigil = Column(String, ForeignKey('schedules.code'), nullable=True)
    schedule_code_sat = Column(String, ForeignKey('schedules.code'), nullable=True)
    schedule_code_sat_with_vigil = Column(String, ForeignKey('schedules.code'), nullable=True)
    schedule_code_sat_vigil = Column(String, ForeignKey('schedules.code'), nullable=True)
    schedule_code_sun = Column(String, ForeignKey('schedules.code'), nullable=True)
    schedule_code_sun_with_vigil = Column(String, ForeignKey('schedules.code'), nullable=True)
    schedule_code_sun_vigil = Column(String, ForeignKey('schedules.code'), nullable=True)
    valid_start = Column(DateTime, nullable=True)
    valid_end = Column(DateTime, nullable=True)

    all_mon = relationship(Schedule, primaryjoin="Schedule.code==ServicePattern.schedule_code_mon", uselist=True)
    all_mon_with_vigil = relationship(Schedule, primaryjoin="Schedule.code==ServicePattern.schedule_code_mon_with_vigil", uselist=True)
    all_mon_vigil = relationship(Schedule, primaryjoin="Schedule.code==ServicePattern.schedule_code_mon_vigil", uselist=True)
    all_tue = relationship(Schedule, primaryjoin="Schedule.code==ServicePattern.schedule_code_tue", uselist=True)
    all_tue_with_vigil = relationship(Schedule, primaryjoin="Schedule.code==ServicePattern.schedule_code_tue_with_vigil", uselist=True)
    all_tue_vigil = relationship(Schedule, primaryjoin="Schedule.code==ServicePattern.schedule_code_tue_vigil", uselist=True)
    all_wed = relationship(Schedule, primaryjoin="Schedule.code==ServicePattern.schedule_code_wed", uselist=True)
    all_wed_with_vigil = relationship(Schedule, primaryjoin="Schedule.code==ServicePattern.schedule_code_wed_with_vigil", uselist=True)
    all_wed_vigil = relationship(Schedule, primaryjoin="Schedule.code==ServicePattern.schedule_code_wed_with_vigil", uselist=True)
    all_thu = relationship(Schedule, primaryjoin="Schedule.code==ServicePattern.schedule_code_thu", uselist=True)
    all_thu_with_vigil = relationship(Schedule, primaryjoin="Schedule.code==ServicePattern.schedule_code_thu_with_vigil", uselist=True)
    all_thu_vigil = relationship(Schedule, primaryjoin="Schedule.code==ServicePattern.schedule_code_thu_vigil", uselist=True)
    all_fri = relationship(Schedule, primaryjoin="Schedule.code==ServicePattern.schedule_code_fri", uselist=True)
    all_fri_with_vigil = relationship(Schedule, primaryjoin="Schedule.code==ServicePattern.schedule_code_fri_with_vigil", uselist=True)
    all_fri_vigil = relationship(Schedule, primaryjoin="Schedule.code==ServicePattern.schedule_code_fri_vigil", uselist=True)
    all_sat = relationship(Schedule, primaryjoin="Schedule.code==ServicePattern.schedule_code_sat", uselist=True)
    all_sat_with_vigil = relationship(Schedule, primaryjoin="Schedule.code==ServicePattern.schedule_code_sat_with_vigil", uselist=True)
    all_sat_vigil = relationship(Schedule, primaryjoin="Schedule.code==ServicePattern.schedule_code_sat_vigil", uselist=True)
    all_sun = relationship(Schedule, primaryjoin="Schedule.code==ServicePattern.schedule_code_sun", uselist=True)
    all_sun_with_vigil = relationship(Schedule, primaryjoin="Schedule.code==ServicePattern.schedule_code_sun_with_vigil", uselist=True)
    all_sun_vigil = relationship(Schedule, primaryjoin="Schedule.code==ServicePattern.schedule_code_sun_vigil", uselist=True)

    def __repr__(self):
        return self.name + ' <' + self.code + '>'

    def mon(self, day):
        return valid_in_list(self.all_mon, day)
    def mon_with_vigil(self, day):
        return valid_in_list(self.all_mon_with_vigil, day)
    def mon_vigil(self, day):
        return valid_in_list(self.all_mon_vigil, day)

    def tue(self, day):
        return valid_in_list(self.all_tue, day)
    def tue_with_vigil(self, day):
        return valid_in_list(self.all_tue_with_vigil, day)
    def tue_vigil(self, day):
        return valid_in_list(self.all_tue_vigil, day)

    def wed(self, day):
        return valid_in_list(self.all_wed, day)
    def wed_with_vigil(self, day):
        return valid_in_list(self.all_wed_with_vigil, day)
    def wed_vigil(self, day):
        return valid_in_list(self.all_wed_vigil, day)

    def thu(self, day):
        return valid_in_list(self.all_thu, day)
    def thu_with_vigil(self, day):
        return valid_in_list(self.all_thu_with_vigil, day)
    def thu_vigil(self, day):
        return valid_in_list(self.all_thu_vigil, day)

    def fri(self, day):
        return valid_in_list(self.all_fri, day)
    def fri_with_vigil(self, day):
        return valid_in_list(self.all_fri_with_vigil, day)
    def fri_vigil(self, day):
        return valid_in_list(self.all_fri_vigil, day)

    def sat(self, day):
        return valid_in_list(self.all_sat, day)
    def sat_with_vigil(self, day):
        return valid_in_list(self.all_sat_with_vigil, day)
    def sat_vigil(self, day):
        return valid_in_list(self.all_sat_vigil, day)

    def sun(self, day):
        return valid_in_list(self.all_sun, day)
    def sun_with_vigil(self, day):
        return valid_in_list(self.all_sun_with_vigil, day)
    def sun_vigil(self, day):
        return valid_in_list(self.all_sun_vigil, day)

    def has_vigil(self, day):
        param = 'schedule_code_' + day.strftime('%A').lower()[:3] + '_vigil'
        code = getattr(self, param)
        if code is None:
            return False
        else:
            return True

    def schedule(self, day, **kwargs):
        method = day.strftime('%A').lower()[:3]
        if 'has_vigil' in kwargs and kwargs['has_vigil']:
            method += '_with_vigil'
        elif 'is_vigil' in kwargs and kwargs['is_vigil']:
            method += '_vigil'
        return getattr(self, method)(day)

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
    schedule_pattern = Column(String, ForeignKey('service_patterns.code'))

    all_patterns = relationship(ServicePattern, primaryjoin="ServicePattern.code==Season.schedule_pattern", uselist=True)

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

    def pattern(self, day):
        return valid_in_list(self.all_patterns, day)

