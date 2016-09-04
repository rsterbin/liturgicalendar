# Base class to look up the proper object for a particular date

from random import choice
from string import ascii_lowercase

class ModelEnforcer(type):
    """Enforces model setup"""

    def __init__(cls, name, bases, d):
        """Makes sure that new model classes are set up properly"""
        if 'table' not in d:
            raise ValueError("Class %s doesn't define table attribute" % name)
        if 'primary_key' not in d:
            raise ValueError("Class %s doesn't define primary_key attribute" % name)
        if 'prefix' not in d:
            d['prefix'] = ''.join(choice(ascii_lowercase) for i in range(12))
        if not hasattr(cls, 'prefix_registry'):
            cls.prefix_registry = {}
        else:
            if d['prefix'] not in cls.prefix_registry:
                cls.prefix_registry[d['prefix']] = name
            else:
                raise ValueError("Prefix %s cannot be used by class %s; it is already in use by class %s" % (d.prefix, name, cls.prefix_registry[d.prefix]))
        type.__init__(cls, name, bases, d)

class RowBase(object):
    """Base class for orm objects"""
    __metaclass__ = ModelEnforcer
    table = None
    primary_key = None
    prefix = None

    def load(self, row):
        """Looks up the row"""
        self._raw = row
        self._columns = {k.replace(self.prefix, ''): v for k, v in row.items() if k.find(self.prefix) == 0}
        self._my_pk = self.find_pk(self, row)

    @staticmethod
    def find_pk(self, row):
        """Finds this class's primary key within a row"""
        if isinstance(self.primary_key, list):
            pk = []
            for col in self.primary_key:
                if col in row:
                    pk.append(row[self.prefix + col])
                else:
                    raise ValueError("Primary key column %s is missing", col)
            return pk
        else:
            if self.prefix + self.primary_key in row:
                return row[self.prefix + self.primary_key]
            else:
                raise ValueError("Primary key column %s is missing", self.primary_key)

    def column(self, colname):
        """Returns a column"""
        if colname in self._columns:
            return self._columns[colname]
        else:
            return None

