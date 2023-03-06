#!/bin/sh

# SIM_HOME environment variable must be set
if [ -z "$SIM_HOME" ]; then
    echo "\nError: SIM_HOME environment variable must be set before sourcing this script. Exiting ceInstall/setup.\n"
    return 1
fi

# if ${SIM_HOME}"/ceInstall/ does not exist, exit
if [ ! -d "${SIM_HOME}"/ceInstall ]; then
    echo "\nError: Directory ${SIM_HOME}/ceInstall does not exist. Exiting ceInstall/setup.\n"
    return 1
fi

# if SIM_SUB_DIR environment variable is not set, set it to 'sim'
if [ -z "$SIM_SUB_DIR" ]; then
    export SIM_SUB_DIR=sim
fi

module use "${SIM_HOME}"/ceInstall/modulefiles

echo "Use 'module avail' to see available modules for SIM_HOME=$SIM_HOME. "
echo



