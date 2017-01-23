import datetime

def day_to_lookup(day):
    """Turns a day into its lookup key in the full year hash"""
    return day.strftime('%Y-%m-%d')

def weekday(day):
    """Returns the day of the week as a lowercase three-character abbreviation (e.g., sun)"""
    return day.strftime('%A').lower()[:3]

