import datetime
from dateutil.easter import *
import inflect
from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, Boolean, Time, Date
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship

from config import config
from algorithms import boundary_algorithms, feast_algorithms, holiday_algorithms
import utils
from valid_dates import valid_in_list

DeclarativeBase = declarative_base()

class Service(DeclarativeBase):
    """Sqlalchemy services model"""
    __tablename__ = 'services'

    id = Column('service_id', Integer, primary_key=True)
    name = Column(String)
    start_time = Column(Time, nullable=True)
    is_default = Column(Boolean)

    def __repr__(self):
        return self.name + ' ' + utils.ftime(self.start_time)

class ScheduleServices(DeclarativeBase):
    """Sqlalchemy schedules model"""
    __tablename__ = 'schedule_services'

    service_id = Column(Integer, ForeignKey('services.service_id'), primary_key=True)
    schedule_id = Column(Integer, ForeignKey('schedules.schedule_id'), primary_key=True)

class Schedule(DeclarativeBase):
    """Sqlalchemy schedules model"""
    __tablename__ = 'schedules'

    id = Column('schedule_id', Integer, primary_key=True)
    name = Column(String)
    code = Column(String, nullable=True)
    valid_start = Column(DateTime, nullable=True)
    valid_end = Column(DateTime, nullable=True)
    is_default = Column(Boolean)
    is_custom = Column(Boolean)

    services = relationship('Service', secondary='schedule_services',
        foreign_keys=[ScheduleServices.service_id, ScheduleServices.schedule_id], uselist=True)

    def sort_services(self):
        """Returns the services, sorted by start time"""
        return sorted(self.services, key=lambda service: service.start_time)

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
    all_wed_vigil = relationship(Schedule, primaryjoin="Schedule.code==ServicePattern.schedule_code_wed_vigil", uselist=True)
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
    counting_index = Column(Integer)
    continue_counting = Column(Boolean)
    has_last_sunday = Column(Boolean)
    calculate_from = Column(String)
    algorithm = Column(String)
    distance = Column(Integer)
    sort_order = Column(Integer)
    schedule_pattern = Column(String, ForeignKey('service_patterns.code'))
    name_pattern_mon = Column(String)
    name_pattern_tue = Column(String)
    name_pattern_wed = Column(String)
    name_pattern_thu = Column(String)
    name_pattern_fri = Column(String)
    name_pattern_sat = Column(String)
    name_pattern_sat_vigil = Column(String)
    name_pattern_sun = Column(String)
    default_note_mon = Column(String)
    default_note_tue = Column(String)
    default_note_wed = Column(String)
    default_note_thu = Column(String)
    default_note_fri = Column(String)
    default_note_sat = Column(String)
    default_note_sun = Column(String)

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

    def ordinal(self, number):
        p = inflect.engine()
        return p.number_to_words(p.ordinal(number))

    def day_name(self, day, **kwargs):
        weekday = day.strftime('%A').lower()[:3]
        param = 'name_pattern_' + weekday
        if weekday == 'sat' and 'is_vigil' in kwargs and kwargs['is_vigil']:
            param += '_vigil'
        name = getattr(self, param)
        if 'sunday_count' in kwargs and '%s' in name:
            if self.has_last_sunday and 'is_last' in kwargs and kwargs['is_last']:
                name = name % 'Last'
            else:
                name = name % self.ordinal(kwargs['sunday_count']).title()
        return name

    def day_note(self, day):
        return getattr(self, 'default_note_' + day.strftime('%A').lower()[:3])

class ObservanceType(DeclarativeBase):
    """Sqlalchemy observance types model"""
    __tablename__ = 'observance_types'

    id = Column('otype_id', Integer, primary_key=True)
    name = Column(String)
    precedence = Column(Integer)

class MoveableFeast(DeclarativeBase):
    """Sqlalchemy moveable feasts model"""
    __tablename__ = 'moveable_feasts'

    id = Column('moveable_id', Integer, primary_key=True)
    name = Column(String)
    code = Column(String)
    otype_id = Column(Integer, ForeignKey('observance_types.otype_id'))
    placement_index = Column(Integer, nullable=True)
    calculate_from = Column(String)
    algorithm = Column(String)
    distance = Column(Integer, nullable=True)
    schedule_pattern = Column(String, ForeignKey('service_patterns.code'), nullable=True)
    has_eve = Column(Boolean)
    eve_schedule_pattern = Column(String, ForeignKey('service_patterns.code'), nullable=True)
    eve_name = Column(String, nullable=True)
    color = Column(String, nullable=True)
    note = Column(String, nullable=True)
    valid_start = Column(DateTime, nullable=True)
    valid_end = Column(DateTime, nullable=True)

    otype = relationship(ObservanceType)
    all_patterns = relationship(ServicePattern, primaryjoin="ServicePattern.code==MoveableFeast.schedule_pattern", uselist=True)
    all_eve_patterns = relationship(ServicePattern, primaryjoin="ServicePattern.code==MoveableFeast.eve_schedule_pattern", uselist=True)

    def __repr__(self):
        return self.name + ' <' + self.code + '>'

    def pattern(self, day):
        return valid_in_list(self.all_patterns, day)

    def eve_pattern(self, day):
        return valid_in_list(self.all_eve_patterns, day)

    def day(self, year):
        """Gets the date of this feast, given a year"""
        if self.calculate_from == 'easter':
            holiday = easter(year)
        elif self.calculate_from == 'christmas':
            holiday = datetime.date(year, 12, 25)
        elif self.calculate_from == 'epiphany':
            holiday = datetime.date(year, 1, 6)
        elif self.calculate_from == 'ash-wednesday':
            # Ash Wednesday is the sixth Wednesday before Easter
            eas = easter(year)
            holiday = eas - datetime.timedelta(days=eas.weekday()) + datetime.timedelta(days=2, weeks=-6)
        elif self.calculate_from == 'pentecost':
            # Pentecost is the seventh Sunday after Easter
            eas = easter(year)
            holiday = eas + datetime.timedelta(weeks=7)
        elif self.calculate_from == '11/1':
            holiday = datetime.date(year, 11, 1)
        else:
            raise ValueError('"{holiday}" is an unknown calculation starting point for moveable feasts; use "christmas" or "easter"'.format(holiday=repr(self.calculate_from)))
        return getattr(feast_algorithms, self.algorithm)(holiday, self.distance)

class FixedFeast(DeclarativeBase):
    """Sqlalchemy fixed feasts model"""
    __tablename__ = 'fixed_feasts'

    id = Column('fixed_id', Integer, primary_key=True)
    name = Column(String)
    code = Column(String)
    otype_id = Column(Integer, ForeignKey('observance_types.otype_id'))
    month = Column(Integer)
    mday = Column('day', Integer)
    schedule_pattern = Column(String, ForeignKey('service_patterns.code'), nullable=True)
    has_eve = Column(Boolean)
    eve_schedule_pattern = Column(String, ForeignKey('service_patterns.code'), nullable=True)
    eve_name = Column(String, nullable=True)
    color = Column(String, nullable=True)
    note = Column(String, nullable=True)
    valid_start = Column(DateTime, nullable=True)
    valid_end = Column(DateTime, nullable=True)

    otype = relationship(ObservanceType)
    all_patterns = relationship(ServicePattern, primaryjoin="ServicePattern.code==FixedFeast.schedule_pattern", uselist=True)
    all_eve_patterns = relationship(ServicePattern, primaryjoin="ServicePattern.code==FixedFeast.eve_schedule_pattern", uselist=True)

    def __repr__(self):
        if self.code:
            return self.name + ' <' + self.code + '>'
        else:
            return self.name

    def pattern(self, day):
        return valid_in_list(self.all_patterns, day)

    def eve_pattern(self, day):
        return valid_in_list(self.all_eve_patterns, day)

    def day(self, year):
        """Gets the date of this feast, given a year"""
        return datetime.date(year, self.month, self.mday)

class FloatingFeast(DeclarativeBase):
    """Sqlalchemy floating feasts model"""
    __tablename__ = 'floating_feasts'

    id = Column('floating_id', Integer, primary_key=True)
    name = Column(String)
    code = Column(String)
    otype_id = Column(Integer, ForeignKey('observance_types.otype_id'))
    placement_index = Column(Integer, nullable=True)
    algorithm = Column(String)
    schedule_pattern = Column(String, ForeignKey('service_patterns.code'), nullable=True)
    has_eve = Column(Boolean)
    eve_schedule_pattern = Column(String, ForeignKey('service_patterns.code'), nullable=True)
    eve_name = Column(String, nullable=True)
    color = Column(String, nullable=True)
    note = Column(String, nullable=True)
    valid_start = Column(DateTime, nullable=True)
    valid_end = Column(DateTime, nullable=True)

    otype = relationship(ObservanceType)
    all_patterns = relationship(ServicePattern, primaryjoin="ServicePattern.code==FloatingFeast.schedule_pattern", uselist=True)
    all_eve_patterns = relationship(ServicePattern, primaryjoin="ServicePattern.code==FloatingFeast.eve_schedule_pattern", uselist=True)

    def __repr__(self):
        return self.name + ' <' + self.code + '>'

    def pattern(self, day):
        return valid_in_list(self.all_patterns, day)

    def eve_pattern(self, day):
        return valid_in_list(self.all_eve_patterns, day)

class FederalHoliday(DeclarativeBase):
    """Sqlalchemy federal holidays model"""
    __tablename__ = 'federal_holidays'

    id = Column('holiday_id', Integer, primary_key=True)
    name = Column(String)
    code = Column(String)
    calculate_from = Column(String)
    algorithm = Column(String)
    distance = Column(Integer, nullable=True)
    placement_index = Column(Integer, nullable=True)
    open_time = Column(Time, nullable=True)
    close_time = Column(Time, nullable=True)
    note = Column(String, nullable=True)
    skip_name = Column(Boolean)
    valid_start = Column(DateTime, nullable=True)
    valid_end = Column(DateTime, nullable=True)

    def __repr__(self):
        return self.name + ' <' + self.code + '>'

    def _get_calc_from(self, year):
        """Converts the calculate_from column into a day to calculate from, given a year"""
        parts = self.calculate_from.split('/')
        if len(parts) != 2:
            return None
        try:
            month = int(parts[0])
            day = int(parts[1])
        except ValueError:
            return None
        if month < 1 or month > 12:
            return None
        if day < 1 or day > 31:
            return None
        calc_from = datetime.date(year, month, day)
        if calc_from.year != year or calc_from.month != month or calc_from.day != day:
            return None
        return calc_from

    def day(self, year):
        """Gets the date of this holiday, given a year"""
        calc_from = self._get_calc_from(year)
        if calc_from is None:
            raise ValueError('"{calc_from}" is an unknown calculation starting point for federal holidays; use "MM-DD"'.format(calc_from=repr(self.calculate_from)))
        return getattr(holiday_algorithms, self.algorithm)(calc_from, self.distance)

class OverrideService(DeclarativeBase):
    """Sqlalchemy override services model"""
    __tablename__ = 'override_services'

    id = Column('override_service_id', Integer, primary_key=True)
    override_id = Column(Integer, ForeignKey('overrides.override_id'))
    name = Column(String)
    start_time = Column(Time, nullable=True)

    def __repr__(self):
        return self.name + ' ' + str(self.startTime)

class Override(DeclarativeBase):
    """Sqlalchemy overrides model"""
    __tablename__ = 'overrides'

    id = Column('override_id', Integer, primary_key=True)
    target_date = Column(Date)
    target_block = Column(String)
    name = Column(String, nullable=True)
    color = Column(String, nullable=True)
    note = Column(String, nullable=True)

    services = relationship(OverrideService, primaryjoin="OverrideService.override_id==Override.id", uselist=True)

    def __repr__(self):
        return self.name + ' [' + self.color + '] ' + self.note

class CalculatedService(DeclarativeBase):
    """Sqlalchemy calculated services model"""
    __tablename__ = 'calculated_services'

    id = Column('calculated_service_id', Integer, primary_key=True)
    calculated_id = Column(Integer, ForeignKey('calculated.calculated_id'))
    name = Column(String)
    start_time = Column(Time, nullable=True)

    def __repr__(self):
        return self.name + ' ' + str(self.startTime)

class Calculated(DeclarativeBase):
    """Sqlalchemy calculateds model"""
    __tablename__ = 'calculated'

    id = Column('calculated_id', Integer, primary_key=True)
    target_date = Column(Date)
    target_block = Column(String)
    name = Column(String, nullable=True)
    color = Column(String, nullable=True)
    note = Column(String, nullable=True)

    services = relationship(CalculatedService, primaryjoin="CalculatedService.calculated_id==Calculated.id", uselist=True)

    def __repr__(self):
        return self.name + ' [' + self.color + '] ' + self.note

