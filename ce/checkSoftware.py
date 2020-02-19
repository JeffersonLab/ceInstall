#!/usr/bin/python3

# arguments:
# 1. software name
# 2. software location
# 3. proposed software location
# 4. software version
# 5. default software version
# 6. directory/file that verifies installation

# this script will check the existence of
# a software location and print a warning if the location is not found
# if the location is found, it will either:
# a. print the custom software version if the location was not set by user (different than proposed by the software)
# a. print the custom software location if it was set by the user

import os
from sys import argv
import sys, traceback

script, name, softwareLocation, proposedSoftwareLocation, softwareVersion, defaultSoftwareVersion, fileOrDirerify = argv

# first check that the directory exist - if not print error and exit
if not os.path.exists(fileOrDirerify):
	print (" !! Attention: ", name, " installation check", fileOrDirerify, " not found")
	sys.exit(0)

# if the location was not set by user (softwareLocation different than proposedSoftwareLocation)
# prints software version
# adds "custom version" if the version was different than the defaultVersion
if softwareLocation == proposedSoftwareLocation:
	if softwareVersion == 'notUsed':
		print (" >", name, "\t installed in ", softwareLocation)
	elif softwareVersion == softwareVersion:
		# checking if this is a system installation
		if os.path.islink(fileOrDirerify):
			print (" >", name, "\t using system installation in ", fileOrDirerify)
		else:
			print (" >", name, "\t version: ", softwareVersion)
	else:
		print (" >", name, "\t custom version: ", softwareVersion)
else:
	print (" >", name, "\t custom location: ", softwareLocation)

