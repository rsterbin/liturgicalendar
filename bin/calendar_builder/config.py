# Loads the config file and sets some constants

import os
import yaml

CONFIG_PATH = os.path.dirname(os.path.realpath(__file__)) + '/../config.yml'
config = yaml.safe_load(open(CONFIG_PATH))

