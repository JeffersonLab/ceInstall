#!/usr/bin/python

# arguments:
# 1. name of software env to be set
# 2. default software / version
# 3. option "overwrite" (can be yes or not)

# this script will print a software dir / software version
# two scenarios:
# 1: if the option "overwrite" is set to yes,
#    or if the software env is not already set
#    then the version is set to the default
# 2: otherwise use the already set version

import os
from sys import argv
import sys, traceback

script, versionExist, defaultVersionValue, overwrite = argv

# if the version is not set, or if overwrite is yes,
# return the defaultVersionValue
if not versionExist in os.environ or overwrite == "yes":
	print defaultVersionValue
else:
	print os.environ[versionExist]




