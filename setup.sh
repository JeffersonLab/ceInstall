#!/bin/sh





# extract path to this file
export sim_modules_home=$(dirname "$(realpath "${BASH_SOURCE:-$0}")")

# if SIM_HOME environment variable is not set, set it to the current directory
if [ -z "$SIM_HOME" ]; then
    export SIM_HOME=$(realpath "$sim_modules_home"/../)
fi

# if SIM_SUB_DIR environment variable is not set, set it to 'sim'
if [ -z "$SIM_SUB_DIR" ]; then
    export SIM_SUB_DIR=sim
fi

module use "${sim_modules_home}"/modulefiles

echo "Modules available for SIM_HOME=$SIM_HOME. Use 'module avail' to see available modules."
echo

# adds install to path if requested
if [ "$1" = "install" ]; then
    export PATH="$PATH":"${sim_modules_home}/install"
fi



