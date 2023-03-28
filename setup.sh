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

# if the optional argument 'install' is given, add the $SIM_HOME/ceInstall/install to PATH
if [ "$1" = "install" ]; then
    export PATH=$PATH:"${SIM_HOME}"/ceInstall/install
    echo "Added ${SIM_HOME}/ceInstall/install to PATH."
fi



echo

