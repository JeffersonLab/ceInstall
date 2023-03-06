#!/bin/sh

# check that gcc --version gives a version number different than 9
gcc_version=$(gcc --version | head -n 1 | cut -d ' ' -f 3)
gcc_major=$(echo $gcc_version | cut -d '.' -f 1)
if [ $gcc_major -ne 9 ]; then
    echo "ERROR: gcc version must be 9. Use module load gcc/9.2.0 to load the correct version"
    exit 1
fi

# This script is used to as pre-setup the environment at Jefferson Lab (JLab)

export SIM_HOME=/site/12gev_phys

# Use JLab modules
module use /apps/modulefiles

# at JLab the centos7 machines have an old version of modules
# se we need to use a newer version
if [ -f /etc/centos-release ] && grep -q 'CentOS Linux release 7' /etc/centos-release; then
    echo "CentOS 7 detected at JLab. Loading site modules"
    if [ -n "$BASH_VERSION" ]; then
        source /site/12gev_phys/modules/init/bash
    elif [ -n "$ZSH_VERSION" ]; then
        source /site/12gev_phys/modules/init/zsh
    fi
fi

source $SIM_HOME/ceInstall/setup.sh


