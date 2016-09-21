import copy
import datetime

class ResolutionDay:
    """Describes a day in the resolution process"""

    def __init__(self, day, season, sunday_count, is_last_week):
        self.day = copy.deepcopy(day)
        self.season = season
        self.sunday_count = sunday_count
        self.is_last_week = is_last_week
        pattern = self.season.pattern(self.day)
        if pattern.has_vigil(self.day):
            self.base_block = ResolutionBlock(color = self.season.color,
                name = self.season.day_name(day, sunday_count = self.sunday_count, is_last = self.is_last_week),
                note = self.season.day_note(day),
                schedule = pattern.schedule(self.day, has_vigil = True))
            vigil_count = self.sunday_count
            if self.weekday == 'sat':
                vigil_count += 1
            self.vigil_block = ResolutionBlock(color = self.season.color,
                name = self.season.day_name(day, is_vigil = True, sunday_count = vigil_count, is_last = self.is_last_week),
                note = self.season.day_note(day),
                schedule = pattern.schedule(self.day, is_vigil = True))
        else:
            self.base_block = ResolutionBlock(color = self.season.color,
                name = self.season.day_name(day, sunday_count = self.sunday_count, is_last = self.is_last_week),
                note = self.season.day_note(day),
                schedule = pattern.schedule(self.day))
            self.vigil_block = None

    def weekday(self):
        return self.day.strftime('%A').lower()[:3]

    def precedence(self):
        return self.season.precedence(self.day)

    def __repr__(self):
        rep = self.day.strftime('%Y-%m-%d') + ':'
        rep += "\n\t" + str(self.base_block)
        if self.vigil_block is not None:
            rep += "\n\t" + str(self.vigil_block)
        return rep

class ResolutionBlock:
    """Describes a service block on a particular day"""

    def __init__(self, **kwargs):
        if 'color' in kwargs:
            self.color = kwargs['color']
        else:
            self.color = None
        if 'name' in kwargs:
            self.name = kwargs['name']
        else:
            self.name = None
        if 'note' in kwargs:
            self.note = kwargs['note']
        else:
            self.note = None
        if 'schedule' in kwargs:
            self.schedule = kwargs['schedule']
        else:
            self.schedule = None

    def __repr__(self):
        rep = '[' + str(self.color) + '] ' + str(self.name)
        if self.note is not None:
            rep += "\n\t\t(" + str(self.note) + ')'
        rep += "\n\t\t* " + str(self.schedule)
        return rep


