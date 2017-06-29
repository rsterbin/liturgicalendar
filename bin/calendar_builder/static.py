import copy
import datetime
import logging

from . import utils

class StaticRange:
    """Describes a resolved date range"""

    def __init__(self, start, end, session):
        """Constructor"""
        self.start = start
        self.end = end
        self.session = session
        self.logger = logging.getLogger(__name__)

        self.all_days = {}
        c = datetime.date(year, 1, 1)
        c = copy.deepcopy(self.start)
        while c <= self.end:
            cdate = utils.day_to_lookup(c)
            sday = StaticDay(c, self.logger)
            self.all_days[cdate] = sday
            c = c + datetime.timedelta(days=1)

    def override(self, overrides):
        """Sets overrides on this range"""
        for ovr in overrides:
            cdate = utils.day_to_lookup(ovr['day'])
            if cdate in self.all_days:
                self.all_days[cdate].override(ovr)
            else:
                self.logger.warn('Trying to override on wrong date {date}'.format(date=str(ovr['day'])))

class StaticYear(StaticRange):
    """Describes a resolved year"""

    def __init__(self, year, session):
        """Constructor"""
        self.year = year
        start = datetime.date(year, 1, 1)
        end = datetime.date(year, 12, 31)
        super(StaticYear, self).__init__(start, end, session)

class StaticDay:
    """Describes a resolved day"""

    def __init__(self, day, logger):
        """Constructor"""
        self.day = copy.deepcopy(day)
        self.base_block = None
        self.vigil_block = None
        self.logger = logger

    def has_vigil(self):
        """Returns whether the day has a vigil"""
        return self.vigil_block is not None

    def override(self, ovr):
        """Sets overrides on this day"""
        if ovr['target_block'] == 'vigil':
            if self.vigil_block is None:
                self.vigil_block = StaticBlock(self.logger)
            self.vigil_block.override(ovr)
        elif ovr['target_block'] == 'base':
            if self.base_block is None:
                self.base_block = StaticBlock(self.logger)
            self.base_block.override(ovr)
        else:
            self.logger.warn('Trying to override on target block {block}'.format(block=ovr['target_block']))

    def __repr__(self):
        """Displays the day as a string"""
        rep = self.day.strftime('%Y-%m-%d') + ' (' + utils.weekday(self.day) + '):'
        rep += "\n\t" + str(self.base_block)
        if self.vigil_block is not None:
            rep += "\n\t" + str(self.vigil_block)
        return rep

class StaticBlock:
    """Describes a resolved block"""

    def __init__(self, logger):
        """Constructor"""
        self.color = None
        self.name = None
        self.note = None
        self.services = []
        self.logger = logger

    def override(self, override):
        """Sets an override on this block"""
        if 'color' in override:
            self.color = override['color']
        if 'name' in override:
            self.name = override['name']
        if 'note' in override:
            self.note = override['note']
        if 'services' in override:
            self.services = []
            for ovr_service in override['services']:
                self.services.append(StaticService(ovr_service['name'], ovr_service['start_time']))

    def __repr__(self):
        """Displays the block as a string"""
        rep = '[' + str(self.color) + '] ' + str(self.name)
        if self.note is not None:
            lines = self.note.split("\n")
            rep += "\n\t\t(" + "\n\t\t ".join(lines) + ')'
        for service in self.services:
            rep += "\n\t\t* " + str(service)
        return rep

class StaticService:
    """Describes a resolved service"""

    def __init__(self, name, start_time):
        """Constructor"""
        self.name = name
        self.start_time = start_time

    def __repr__(self):
        return self.name + ' ' + utils.ftime(self.start_time)

