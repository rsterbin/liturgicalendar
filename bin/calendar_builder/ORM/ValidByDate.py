# Base class for orm objects that need to look up the right row for a given date

class ValidByDate:
    """Base class for orm objects that need to look up the right row for a given date"""

    def __init__(self, classname):
        """Call this method from your model's init"""
        super(ValidByDate, self).__init__()
        self._date_lookup = ()
        self._options = {}
        self._classname = classname

    def load(self, row):
        """Loads up a row"""
        columns = {k: v for k, v in row.items() if k.find(self.prefix) == 0}
        pk = getattr(self._classname, 'find_pk')(row)
        if isinstance(pk, list):
            pk = pk.join('|')
        if pk not in self._options:
            obj = getattr(self._classname, '__init__')()
            obj.load(row)
            if 'valid_start' not in obj or 'valid_end not in obj':
                raise ValueError('Cannot load a ValidByDate row without the valid_start and valid_end columns selected')
            self._options[pk] = obj
            self._date_lookup.append({
                'start': obj.valid_start,
                'end': obj.valid_end,
                'pk': pk,
            })

    def select(self, date):
        """Chooses an object from its internal list"""
        for lookup in self._date_lookup:
            if lookup['start'] is None and lookup['end'] is None:
                return self._options[lookup['pk']]
            elif lookup['start'] is None and lookup['end'] > date:
                return self._options[lookup['pk']]
            elif lookup['end'] is None and lookup['start'] < date:
                return self._options[lookup['pk']]
            if lookup['start'] is not None and lookup['end'] is not None and lookup['start'] < date and lookup['end'] > date:
                return self._options[lookup['pk']]
        return None

