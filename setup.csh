#!/bin/csh

# in csh there's no clean way to determine the path to the current script
# using lsof of the current process id PID (which is $$)
set this_script=`lsof +p $$ |& grep -oE /.\*setup.csh`

# extract path to this file
set modules_home = `echo $this_script | xargs dirname`

# if OSRELEASE environment variable is not set, use osrelease.py
if ( ! $?OSRELEASE ) then
    setenv OSRELEASE `$modules_home/osrelease.py`
endif

# if SIM_HOME environment variable is not set, set it to the current directory
if ( ! $?SIM_HOME ) then
    setenv SIM_HOME "$modules_home/.."
endif

# if SIM_SUB_DIR environment variable is not set, set it to 'sim'
if ( ! $?SIM_SUB_DIR ) then
    setenv SIM_SUB_DIR sim
endif

module use "$modules_home"/modulefiles

echo "Modules available for SIM_HOME=$SIM_HOME. Use 'module avail' to see available modules."
echo

# adds pinstall to path
setenv PATH "$PATH":"${modules_home}/install"
