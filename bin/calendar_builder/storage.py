import logging
from sqlalchemy import text

from models import Calculated, CalculatedService, Cached, CachedService

class Storage:
    """Handles storing a static year to the appropriate table"""

    def __init__(self, year, session):
        """Constructor"""
        self.year = year
        self.session = session
        self.logger = logging.getLogger(__name__)

    def save_calculated(self, static):
        """Saves a static year to the calculated table"""
        self.session.query(Calculated).\
            filter(text("extract(year from target_date) = :year")).\
            params(year=self.year).\
            delete(synchronize_session=False)
        for cdate in static.full_year:
            static_day = static.full_year[cdate]
            if static_day.base_block is not None:
                self.session.add(self.new_calc_target(static_day, static_day.base_block, 'base'))
            if static_day.vigil_block is not None:
                self.session.add(self.new_calc_target(static_day, static_day.vigil_block, 'vigil'))
        self.session.commit()

    def new_calc_target(self, day, block, which):
        """Creates a Calculated target from a static block"""
        calc = Calculated(
            target_date=day.day,
            target_block=which,
            name=block.name,
            color=block.color,
            note=block.note
        )
        for service in block.services:
            calc.services.append(CalculatedService(
                name=service.name,
                start_time=service.start_time
            ))
        return calc

    def save_cached(self, static):
        """Saves a static year to the cached table"""
        self.session.query(Cached).\
            filter(text("extract(year from target_date) = :year")).\
            params(year=self.year).\
            delete(synchronize_session=False)
        for cdate in static.full_year:
            static_day = static.full_year[cdate]
            if static_day.base_block is not None:
                self.session.add(self.new_cache_target(static_day, static_day.base_block, 'base'))
            if static_day.vigil_block is not None:
                self.session.add(self.new_cache_target(static_day, static_day.vigil_block, 'vigil'))
        self.session.commit()

    def new_cache_target(self, day, block, which):
        """Creates a Cached target from a static block"""
        cache = Cached(
            target_date=day.day,
            target_block=which,
            name=block.name,
            color=block.color,
            note=block.note
        )
        for service in block.services:
            cache.services.append(CachedService(
                name=service.name,
                start_time=service.start_time
            ))
        return cache

