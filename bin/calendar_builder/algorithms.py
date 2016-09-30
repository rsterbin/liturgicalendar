import datetime

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
    def exact(holiday_date, number):
        """Exactly on the given holiday"""
        return holiday_date

