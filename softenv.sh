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
  2.[0123] )  ## Match good versions here
    ;;
  devel )    ## Match good versions here
    ;;

  *)
	echo
	echo "  Usage:  'source $JLAB_ROOT/softenv.csh <version>'"
	echo
	echo "  Supported Versions: "
	echo
	echo "   - 2.3 "
	echo "   - 2.2 (production)"
	echo "   - 2.1 "
	echo "   - 2.0 "
	echo "   - devel "
	echo; echo
   return 1
    ;;
esac

if [ "${JLAB_ROOT}" == "2.3" ]; then
	export QT_VERSION=5.10.1
endif

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
