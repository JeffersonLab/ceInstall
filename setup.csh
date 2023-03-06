#!/bin/csh

# SIM_HOME environment variable must be set
if ( ! $?SIM_HOME ) then
    echo; echo "Error: SIM_HOME environment variable must be set before sourcing this script. Exiting ceInstall/setup."; echo
    exit 1
endif

# if ${SIM_HOME}"/ceInstall/ does not exist, exit
if ( ! -d ${SIM_HOME}"/ceInstall/" ) then
    echo; echo "Error: Directory ${SIM_HOME}/ceInstall does not exist. Exiting ceInstall/setup."; echo
    exit 1
endif

# if SIM_SUB_DIR environment variable is not set, set it to 'sim'
if ( ! $?SIM_SUB_DIR ) then
    setenv SIM_SUB_DIR sim
endif

module use "${SIM_HOME}"/ceInstall/modulefiles

echo "Use 'module avail' to see available modules for SIM_HOME=$SIM_HOME. "
echo
