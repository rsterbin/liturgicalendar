import copy
import datetime
from dateutil.easter import *
from sqlalchemy import text
from sqlalchemy.orm import eagerload,joinedload

from models import FloatingFeast, ServicePattern
import utils
from valid_dates import valid_in_list

class FloatingFeasts:
    """Class for placing floating feasts in a year"""

    def __init__(self, session, year):
        """Sets up the placer"""
        self.session = session
        self.year = year
        self.load_feasts()

    def load_feasts(self):
        """Loads the feasts for this year"""
        self.by_code = {}
        self.feasts = []
        for instance in self.session.query(FloatingFeast).\
                options(joinedload(FloatingFeast.otype)).\
                options(joinedload(FloatingFeast.all_patterns)).\
                options(joinedload(FloatingFeast.all_eve_patterns)).\
                filter(text("valid_for_date(:jan_first, floating_feasts.valid_start, floating_feasts.valid_end)")).\
                params(jan_first=datetime.date(self.year, 1, 1).strftime('%Y-%m-%d')).\
                order_by(FloatingFeast.placement_index):
            code = instance.code
            if code not in self.by_code:
                self.by_code[code] = []
                self.by_code[code].append(instance)
            self.feasts.append(code)

    def get_for_year(self, year, full_year):
        """Given the current calendar, find the days the floating feasts should be placed"""
        by_date = {}
        for code in self.feasts:
            for feast in self.by_code[code]:
                if feast.algorithm == 'of_our_lady':
                    by_date = self.of_our_lady(feast, year, full_year, by_date)
                elif feast.algorithm == 'of_our_lady_old':
                    by_date = self.of_our_lady_old(feast, year, full_year, by_date)
                elif feast.algorithm == 'first_bcp':
                    by_date = self.first_bcp(feast, year, full_year, by_date)
                elif feast.algorithm == 'parish_requiem':
                    by_date = self.parish_requiem(feast, year, full_year, by_date)
                elif feast.algorithm == 'parish_requiem_5_skip':
                    by_date = self.parish_requiem_5_skip(feast, year, full_year, by_date)
                elif feast.algorithm == 'parish_requiem_4_skip':
                    by_date = self.parish_requiem_4_skip(feast, year, full_year, by_date)
                else:
                    raise ValueError('"{algorithm}" is an unknown algorithm for floating feasts'.format(algorithm=repr(feast.algorithm)))
        return by_date.values()

    def of_our_lady(self, feast, year, full_year, by_date):
        """Saturdays in a green season without another commemoration are Of Our Lady"""
        return self._internal_of_our_lady(feast, year, full_year, by_date, False)

    def of_our_lady_old(self, feast, year, full_year, by_date):
        """Year-round, Saturdays without another commemoration were Of Our Lady"""
        return self._internal_of_our_lady(feast, year, full_year, by_date, True)

    def _internal_of_our_lady(self, feast, year, full_year, by_date, is_old_style):
        """Handles both the old and new versions of Of Our Lady"""
        current_day = datetime.date(year, 1, 1)
        while current_day.year == year:
            # only Saturdays
            if utils.weekday(current_day) != 'sat':
                current_day = current_day + datetime.timedelta(days=1)
                continue
            # only if the feast is valid for this day
            ok = valid_in_list([feast], current_day)
            if ok is None:
                current_day = current_day + datetime.timedelta(days=1)
                continue
            # (new style) only if the season is green
            cdate = utils.day_to_lookup(current_day)
            if not is_old_style and full_year[cdate].season.color != 'green':
                current_day = current_day + datetime.timedelta(days=1)
                continue
            # only if another feast is not scheduled for that day
            if len(full_year[cdate].feasts) == 0:
                if cdate not in by_date:
                    by_date[cdate] = { 'day': copy.deepcopy(current_day) , 'feasts': [] }
                by_date[cdate]['feasts'].append(feast)
            current_day = current_day + datetime.timedelta(days=1)
        return by_date

    def first_bcp(self, feast, year, full_year, by_date):
        """First free weekday after Pentecost for which there's no other commemoration"""
        current_day = easter(year) + datetime.timedelta(weeks=7)
        while current_day.year == year:
            # only weekdays
            if utils.weekday(current_day) == 'sun':
                current_day = current_day + datetime.timedelta(days=1)
                continue
            # only if the feast is valid for this day
            ok = valid_in_list([feast], current_day)
            if ok is None:
                current_day = current_day + datetime.timedelta(days=1)
                continue
            # only if another feast is not scheduled for that day
            cdate = utils.day_to_lookup(current_day)
            if len(full_year[cdate].feasts) == 0:
                if cdate not in by_date:
                    by_date[cdate] = { 'day': copy.deepcopy(current_day) , 'feasts': [] }
                by_date[cdate]['feasts'].append(feast)
                break
            current_day = current_day + datetime.timedelta(days=1)
        return by_date

    def parish_requiem(self, feast, year, full_year, by_date):
        """First five days available after All Souls, demoting commemorations to notes"""
        return self._internal_parish_requiem(feast, year, full_year, by_date, 5, False)

    def parish_requiem_5_skip(self, feast, year, full_year, by_date):
        """First five days available after All Souls, skipping commemorations"""
        return self._internal_parish_requiem(feast, year, full_year, by_date, 5, True)

    def parish_requiem_4_skip(self, feast, year, full_year, by_date):
        """First four days available after All Souls, skipping commemorations"""
        return self._internal_parish_requiem(feast, year, full_year, by_date, 4, True)

    def _internal_parish_requiem(self, feast, year, full_year, by_date, count_days, skip_comms):
        """Handles the old and new versions of the Parish Requiem"""
        current_day = datetime.date(year, 11, 2)
        all_souls = None
        if count_days == 5:
            names = [' (A-E)', ' (F-K)', ' (L-M)', ' (O-Q)', ' (R-Z)']
        else:
            names = ['', '', '', '']
        index = 0
        while current_day.year == year:
            cdate = utils.day_to_lookup(current_day)
            if all_souls is None:
                for f in full_year[cdate].feasts:
                    if f.code() == 'all-souls':
                        all_souls = full_year[cdate].day
                        break
            else:
                ok = True
                cname = None
                if skip_comms:
                    if full_year[cdate].current_precedence < 60:
                        ok = False
                else:
                    if full_year[cdate].current_precedence < 50:
                        ok = False
                    else:
                        if full_year[cdate].current_feast is not None:
                            cname = '(' + full_year[cdate].current_feast.name() + ')'
                if ok:
                    if index < len(names):
                        f = copy.deepcopy(feast)
                        f.name = feast.name + names[index]
                        f.note = cname
                        if cdate not in by_date:
                            by_date[cdate] = { 'day': copy.deepcopy(current_day) , 'feasts': [] }
                        by_date[cdate]['feasts'].append(f)
                        index += 1
                    else:
                        break
            current_day = current_day + datetime.timedelta(days=1)
        return by_date

