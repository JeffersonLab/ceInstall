#!/bin/bash

# Wrapper script to set up the JLab SciComp software within bash.
#
# - Brad Sawatky <brads@jlab.org>   Nov 17, 2016

# Set defaults if vars not already defined
export    JLAB_ROOT="${JLAB_ROOT:=/site/12gev_phys}"
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
  # Warning for CentOS2
  if [ -r /etc/centos-release ]; then
    if ` grep -q 'CentOS release 6.2' /etc/centos-release`; then
      echo " > NOTE:  Not all 1.2 packages are supported under CentOS62."
      echo " > Please move to the updated CentOS65 environment using"
      echo " > ifarm65.jlab.org AND "OS: centos65" for farm submissions."
      echo 
    fi
  fi
  echo \ \>\> For documentation and a list of supported architectures please look at https://data.jlab.org
  echo
  ;;
esac
