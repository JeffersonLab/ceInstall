#!/bin/csh

# needed otherwise cmake could pick up the system cc
export CC=gcc
export CXX=g++

# extract path to this file
setenv modules_home=$(dirname "$(readlink -f $0)")
setenv OSRELEASE $(modules_home/osrelease.py)

# if PHYS_HOME environment variable is not set, set it to the current directory
if ( ! $?PHYS_HOME ) then
    setenv PHYS_HOME $modules_home
endif

module use "$modules_home"/modulefiles

echo "Modules loaded for PHYS_HOME=$PHYS_HOME. Use 'module avail' to see available modules."
echo

# adds pinstall to path
setenv PATH "$PATH":"${modules_home}/../pinstall"
