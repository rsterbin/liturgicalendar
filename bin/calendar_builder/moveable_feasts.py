import datetime
from sqlalchemy import text
from sqlalchemy.orm import joinedload

from models import MoveableFeast

class MoveableFeasts:
    """Class for placing moveable feasts in a year"""

    def __init__(self, session, year):
        """Sets up the placer"""
        self.session = session
        self.year = year
        self.load_feasts()

    def load_feasts(self):
        """Loads the feasts for this year"""
        self.by_code = {}
        self.feasts = []
        for instance in self.session.query(MoveableFeast).\
                options(joinedload(MoveableFeast.schedule_pattern)).\
                options(joinedload(MoveableFeast.eve_schedule_pattern)).\
                filter(text("valid_for_date(:jan_first, moveable_feasts.valid_start, moveable_feasts.valid_end)")).\
                params(jan_first=datetime.date(self.day.year, 1, 1).strftime('%Y-%m-%d')).\
                order_by(MoveableFeast.placement_index):
            code = instance.code
            if code not in self.by_code:
                self.by_code[code] = []
                self.by_code[code].append(instance)
            self.feasts.append(code)

    def feasts_by_date(self):
        """Selects the right feast for each day"""

