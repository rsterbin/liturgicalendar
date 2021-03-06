import datetime
from sqlalchemy import text
from sqlalchemy.orm import eagerload,joinedload

from ..models import FederalHoliday, ServicePattern

class FederalHolidays:
    """Class for placing federal holidays in a year"""

    def __init__(self, session, year):
        """Sets up the placer"""
        self.session = session
        self.year = year
        self.load_holidays()

    def load_holidays(self):
        """Loads the holidays for this year"""
        self.by_code = {}
        self.holidays = []
        for instance in self.session.query(FederalHoliday).\
                filter(text("valid_for_date(:jan_first, federal_holidays.valid_start, federal_holidays.valid_end)")).\
                params(jan_first=datetime.date(self.year, 1, 1).strftime('%Y-%m-%d')).\
                order_by(FederalHoliday.placement_index):
            code = instance.code
            if code not in self.by_code:
                self.by_code[code] = []
                self.by_code[code].append(instance)
            self.holidays.append(code)

    def holidays_by_date(self):
        """Selects the right holiday for each day"""
        by_date = []
        for code in self.holidays:
            h = self.by_code[code][0]
            d = h.day(self.year)
            by_date.append({ 'day': d, 'holidays': self.by_code[code] })
        # New Years Day is a special case, because it could place a federal
        # holiday in the previous year, so we want to see where next year's New
        # Years Day is going to be placed as well as this year's.
        if 'new-years' in self.by_code:
            h = self.by_code['new-years'][0]
            d = h.day(self.year + 1)
            by_date.append({ 'day': d, 'holidays': self.by_code['new-years'] })
        return by_date

