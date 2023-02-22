#!/bin/sh





# extract path to this file
export modules_home=$(dirname "$(realpath "${BASH_SOURCE:-$0}")")

# if OSRELEASE environment variable is not set, use osrelease.py
if [ -z "$OSRELEASE" ]; then
    export OSRELEASE=$( "$modules_home"/osrelease.py )
fi

# if SIM_HOME environment variable is not set, set it to the current directory
if [ -z "$SIM_HOME" ]; then
    export SIM_HOME=$(realpath "$modules_home"/../)
fi

# if SIM_SUB_DIR environment variable is not set, set it to 'sim'
if [ -z "$SIM_SUB_DIR" ]; then
    export SIM_SUB_DIR=sim
fi

module use "${modules_home}"/modulefiles

echo "Modules available for SIM_HOME=$SIM_HOME. Use 'module avail' to see available modules."
echo

# adds pinstall to path
export PATH="$PATH":"${modules_home}/install"
