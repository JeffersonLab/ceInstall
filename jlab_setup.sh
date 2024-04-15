#!/bin/sh

# Use JLab modules
module use /apps/modulefiles

# need modules veesuib 5 or above
. /apps/modules/5.2.0/init/sh

echo "Loading modules gcc/9.2.0 and scons/4.4.0"
module load gcc/9.2.0
module load scons/4.4.0
module load cmake/3.23.2
export CC=gcc
export CXX=g++

export SIM_HOME=/site/12gev_phys

# at JLab the centos7 machines have an old version of modules
# se we need to use a newer version
#if [ -f /etc/centos-release ] && grep -q 'CentOS Linux release 7' /etc/centos-release; then
#    echo "CentOS 7 detected at JLab. Loading site modules"
#    if [ -n "$BASH_VERSION" ]; then
#        . /site/12gev_phys/modules/init/bash
#    elif [ -n "$ZSH_VERSION" ]; then
#        . /site/12gev_phys/modules/init/zsh
#    fi
#fi

source $SIM_HOME/ceInstall/setup.sh "$@"

