#!/bin/bash

# Wrapper script to set up the JLab SciComp software within bash.
#
# - Brad Sawatky <brads@jlab.org>   Nov 17, 2016

# Set defaults if vars not already defined
export    JLAB_ROOT="${JLAB_ROOT:=/site/12gev_phys}"

# modify this so JLAB_VERSION must be set by user
export JLAB_VERSION="${JLAB_VERSION:=2.2}"

if [ -n "$1" ]; then
  export JLAB_VERSION="$1"
fi

config_sh="${JLAB_ROOT}/${JLAB_VERSION}/ce/jlab.sh"

if [ -e  "$config_sh" ]; then
  source "$config_sh"
else
  echo "  Configuration '$1' not available on this machine."
  echo "  Usage:  'source $JLAB_ROOT/production.sh <version>'"
  echo -n "    Versions: "
  for f in $JLAB_ROOT/*; do
    bn=`basename $f`
    if [ $bn == "noarch" ]; then continue; fi
    if [ -d "$f" ]; then echo -n "  $bn"; fi
  done
  echo
  echo
  return
fi

case $- in
	*i*)  # interactive shell
	echo \ \>\> For documentation on the environment please visit https://data.jlab.org
	echo
	;;
esac
