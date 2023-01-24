#!/bin/csh

# extract path to this file
setenv modules_home=$(dirname "$(readlink -f $0)")
setenv OSRELEASE $(modules_home/osrelease.py)

# if SIM_HOME environment variable is not set, set it to the current directory
if ( ! $?SIM_HOME ) then
    setenv SIM_HOME $modules_home
endif

module use "$modules_home"/modulefiles

echo "Modules loaded for SIM_HOME=$SIM_HOME. Use 'module avail' to see available modules."
echo

# adds pinstall to path
setenv PATH "$PATH":"${modules_home}/../pinstall"
