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


module use "${SIM_HOME}"/ceInstall/modulefiles

# if the optional argument 'install' is given, add the $SIM_HOME/ceInstall/install to PATH
if ( $1 == "install" ) then
	setenv PATH ${SIM_HOME}"/ceInstall/install":$PATH
	echo "Added ${SIM_HOME}/ceInstall/install to PATH."
endif

