#!/bin/sh

# extract path to this file
export modules_home=$(dirname "$(realpath "${BASH_SOURCE:-$0}")")
export OSRELEASE=$( "$modules_home"/osrelease.py )

# if SIM_HOME environment variable is not set, set it to the current directory
if [ -z "$SIM_HOME" ]; then
    export SIM_HOME=$(realpath "$modules_home"/../..)
fi

module use "${modules_home}"/modulefiles

echo "Modules loaded for SIM_HOME=$SIM_HOME. Use 'module avail' to see available modules."
echo

# adds pinstall to path
export PATH="$PATH":"${modules_home}/../pinstall"
