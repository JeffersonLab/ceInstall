#!/bin/zsh

# Purpose: creates the modules directory structure using the OSRELEASE from osrelease.py
#
# Destination is $JLAB_ROOT/$JLAB_VERSION/modules/osrelease
#
# Both $JLAB_ROOT and $JLAB_VERSION must be defined (and exported) in the enviroment

if (( ! ${+JLAB_ROOT} )); then
    echo " "           >&2
    echo " Error: JLAB_ROOT must be defined." >&2
    echo " "       >&2
    exit 1
fi

if (( ! ${+JLAB_VERSION} )); then
    echo " "           >&2
    echo " Error: JLAB_VERSION must be defined." >&2
    echo " "       >&2
    exit 1
fi


osrelease=$(../ce/osrelease.py)

modulesDir=$JLAB_ROOT/$JLAB_VERSION/modules/$osrelease


echo " "
echo " Creating modules inside dir "$modulesDir
mkdir -p $modulesDir
cp versions.env $modulesDir

source versions.env

