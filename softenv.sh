#!/bin/bash

# Wrapper script to set up the JLab SciComp software within bash.
#
# - Brad Sawatky <brads@jlab.org>   Nov 17, 2016

# Set defaults if vars not already defined
export    JLAB_ROOT="${JLAB_ROOT:=/site/12gev_phys}"
export JLAB_VERSION="${JLAB_VERSION:="unset"}"

if [ -n "$1" ]; then
  export JLAB_VERSION="$1"
fi

## Mechanism to allow users to overwrite/keep own settings
OVERWRITE="yes"
if [ "${2:-NA}" == "keepmine" ]; then
  OVERWRITE="$2"
fi

## Make sure we use one of the supported versions
case "$JLAB_VERSION" in
  2.[456] )  ## Match good versions here

	export QT_VERSION=5.10.1
	# also, using python3
	alias python=python3
	# using new compiler
	source /etc/profile.d/modules.sh
	module use /apps/modulefiles
	module load cmake
	module load gcc/9.2.0

	# needed otherwise cmake could pick up the system cc
	export CC=gcc
	export CXX=g++
    ;;

  *)
	echo
	echo "  Usage:  'source $JLAB_ROOT/softenv.csh <version>'"
	echo
	echo "  Supported Versions: "
	echo
	echo "   - 2.6 "
	echo "   - 2.5 "
	echo "   - 2.4 "
	echo; echo
   return 1
    ;;
esac

config_sh="${JLAB_ROOT}/${JLAB_VERSION}/ce/jlab.sh"

if [ -e  "$config_sh" ]; then
  source "$config_sh" $OVERWRITE
else
  echo
  echo "  Configuration '$1' not available on this machine."
  echo "  For documentation on the environment please visit https://data.jlab.org "
  echo
  return 1
fi

case $- in
  *i*)  # interactive shell
  echo ' >> For documentation on the environment please visit https://data.jlab.org'
  echo
  ;;
esac
