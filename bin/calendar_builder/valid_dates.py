import datetime

def valid_in_list(collection, date):
    """For each item in the collection, check its valid start and end dates against the date given"""
    for elem in collection:
        if elem.valid_start is None and elem.valid_end is None:
            return elem
        elif elem.valid_start is None and date < elem.valid_end.date():
            return elem
        elif elem.valid_end is None and date > elem.valid_start.date():
            return elem
        elif date > elem.valid_start.date() and date < elem.valid_end.date():
            return elem
    return None

