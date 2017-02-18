import copy
import logging

import utils

class StaticYear:
    """Describes a resolved year"""

    def __init__(self, res_year):
        """Constructor"""
        self.year = res_year.year
        self.session = res_year.session
        self.full_year = {}
        self.logger = logging.getLogger(__name__)
        for cdate in sorted(res_year.full_year.iterkeys()):
            self.full_year[cdate] = StaticDay(self, res_year.full_year[cdate])

    def save(self):
        """Saves everything to the database"""
        pass

class StaticDay:
    """Describes a resolved day"""

    def __init__(self, year, res_day):
        """Constructor"""
        self.day = copy.deepcopy(res_day.day)
        self.year = year
        if res_day.base_block is not None:
            self.base_block = StaticBlock(res_day.base_block, False)
        else:
            self.base_block = None
        if res_day.vigil_block is not None:
            self.vigil_block = StaticBlock(res_day.vigil_block, True)
        else:
            self.vigil_block = None
        self.logger = self.year.logger

    def has_vigil(self):
        """Returns whether the day has a vigil"""
        return self.vigil_block is not None

    def override(self, overrides):
        """Sets overrides on this day"""
        for ovr in overrides:
            if ovr.target_block == 'vigil':
                self.vigil_block.override(ovr)
            elif ovr.target_block == 'base':
                self.base_block.override(ovr)
            else:
                self.logger.warn('Trying to override on target block {block}'.format(block=ovr.target_block))

    def __repr__(self):
        """Displays the day as a string"""
        rep = self.day.strftime('%Y-%m-%d') + ' (' + utils.weekday(self.day) + '):'
        rep += "\n\t" + str(self.base_block)
        if self.vigil_block is not None:
            rep += "\n\t" + str(self.vigil_block)
        return rep

class StaticBlock:
    """Describes a resolved block"""

    def __init__(self, res_block, is_vigil):
        """Constructor"""
        self.color = res_block.color
        self.name = res_block.name
        self.note = res_block.note
        self.is_vigil = is_vigil
        self.services = []
        for res_service in res_block.services:
            self.services.append(StaticService(res_service))

    def override(self, override):
        """Sets an override on this block"""
        if override.color is not None:
            self.color = override.color
        if override.name is not None:
            self.name = override.name
        if override.note is not None:
            self.note = override.note
        if len(override.services) > 0:
            self.services = []
            for ovr_service in override.services:
                self.services.append(StaticService(ovr_service))

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

    def __init__(self, res_service):
        """Constructor"""
        self.name = res_service.name
        self.start_time = res_service.start_time

    def __repr__(self):
        return self.name + ' ' + utils.ftime(self.start_time)

