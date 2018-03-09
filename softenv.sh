#!/bin/bash

# Wrapper script to set up the JLab SciComp software within bash.
#
# - Brad Sawatky <brads@jlab.org>   Nov 17, 2016

# Set defaults if vars not already defined
export    JLAB_ROOT="${JLAB_ROOT:=/site/12gev_phys}"

# modify this so JLAB_VERSION must be set by user
# please use same formatting help as the csh file to be consistent
export JLAB_VERSION="${JLAB_VERSION:=2.2}"

if [ -n "$1" ]; then
  export JLAB_VERSION="$1"
fi

config_sh="${JLAB_ROOT}/${JLAB_VERSION}/ce/jlab.sh"

if [ -e  "$config_sh" ]; then
	source "$config_sh"
else
	echo
	echo "  Configuration '$1' not available on this machine."
	echo "  For documentation on the environment please visit https://data.jlab.org "
	echo
	exit
fi

case $- in
	*i*)  # interactive shell
	echo \ \>\> For documentation on the environment please visit https://data.jlab.org
	echo
	;;
esac
