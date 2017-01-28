import datetime
from dateutil import relativedelta

class boundary_algorithms:
    """Algorithms for calculating season boundaries"""

    @staticmethod
    def days_before(holiday_date, number):
        """Finds a number of days before the given holiday"""
        return holiday_date - datetime.timedelta(days=number)

    @staticmethod
    def days_after(holiday_date, number):
        """Finds a number of days after the given holiday"""
        return holiday_date + datetime.timedelta(days=number)

    @staticmethod
    def weeks_before(holiday_date, number):
        """Finds a number of weeks before the given holiday"""
        return holiday_date - datetime.timedelta(weeks=number)

    @staticmethod
    def weeks_after(holiday_date, number):
        """Finds a number of weeks after the given holiday"""
        return holiday_date + datetime.timedelta(weeks=number)

    @staticmethod
    def tuesdays_before(holiday_date, number):
        """Finds the nth Tuesday before the holiday"""
        return holiday_date - datetime.timedelta(days=holiday_date.weekday()) + datetime.timedelta(days=1, weeks=-1*number)

    @staticmethod
    def saturdays_before(holiday_date, number):
        """Finds the nth Saturday before the holiday"""
        return holiday_date - datetime.timedelta(days=holiday_date.weekday()) + datetime.timedelta(days=5, weeks=-1*number)

class feast_algorithms:
    """Algorithms for calculating moveable feasts"""

    @staticmethod
    def days_before(holiday_date, number):
        """Finds a number of days before the given holiday"""
        return holiday_date - datetime.timedelta(days=number)

    @staticmethod
    def days_after(holiday_date, number):
        """Finds a number of days after the given holiday"""
        return holiday_date + datetime.timedelta(days=number)

    @staticmethod
    def wednesdays_before(holiday_date, number):
        """Finds the nth Wednesday before the holiday"""
        return holiday_date - datetime.timedelta(days=holiday_date.weekday()) + datetime.timedelta(days=2, weeks=-1*number)

    @staticmethod
    def thursdays_after(holiday_date, number):
        """Finds the nth Thursday after the holiday"""
        return holiday_date - datetime.timedelta(days=holiday_date.weekday()) + datetime.timedelta(days=3, weeks=number)

    @staticmethod
    def sundays_before(holiday_date, number):
        """Finds the nth Sunday before the holiday"""
        return holiday_date - datetime.timedelta(days=holiday_date.weekday()) + datetime.timedelta(days=6, weeks=-1*number)

    @staticmethod
    def sundays_after(holiday_date, number):
        """Finds the nth Sunday after the holiday"""
        return holiday_date - datetime.timedelta(days=holiday_date.weekday()) + datetime.timedelta(days=6, weeks=number)

    @staticmethod
    def nth_thursday(holiday_date, number):
        """Finds the nth Thursday of the calc-from day's month"""
        return helpers.nth_weekday_of_month(holiday_date, 3, number)

    @staticmethod
    def exact(holiday_date, number):
        """Exactly on the given holiday"""
        return holiday_date

class holiday_algorithms:
    """Algorithms for calculating federal holidays"""

    @staticmethod
    def nth_monday(calc_from, number):
        """Finds the nth Monday of the calc-from day's month"""
        return helpers.nth_weekday_of_month(calc_from, 0, number)

    @staticmethod
    def last_monday(calc_from, number):
        """Finds the last Monday of the calc-from day's month"""
        return calc_from + relativedelta.relativedelta(day=31, weekday=relativedelta.MO(-1))

    @staticmethod
    def nth_thursday(calc_from, number):
        """Finds the nth Thursday of the calc-from day's month"""
        return helpers.nth_weekday_of_month(calc_from, 3, number)

    @staticmethod
    def closest_weekday(calc_from, number):
        """Finds the closest weekday to the calc-from day"""
        if calc_from.weekday() == 6:
            return calc_from + datetime.timedelta(days=1)
        if calc_from.weekday() == 5:
            return calc_from - datetime.timedelta(days=1)
        return calc_from

    @staticmethod
    def not_sunday(calc_from, number):
        """Finds the closest non-Sunday to the calc-from day"""
        if calc_from.weekday() == 6:
            return calc_from + datetime.timedelta(days=1)
        return calc_from

    @staticmethod
    def exact(calc_from, number):
        """Exactly on the given calc-from day"""
        return calc_from


class helpers:
    """Helper methods for calculating dates"""

    @staticmethod
    def nth_weekday_of_month(calc_from, target_weekday, number):
        """Finds the nth target weekday of the month (e.g., 3rd Monday in January)"""
        start = datetime.date(calc_from.year, calc_from.month, 1)
        days_ahead = target_weekday - start.weekday()
        if days_ahead <= 0:
            days_ahead += 7
        return start + datetime.timedelta(days=days_ahead, weeks=(number - 1))

