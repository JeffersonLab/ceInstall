#!/bin/sh

# Use JLab modules
module use /apps/modulefiles

# need modules veesuib 5 or above
source /apps/modules/5.2.0/init/sh

# check that gcc --version gives a version number different than 9
#gcc_version=$(gcc --version | head -n 1 | cut -d ' ' -f 3)
#gcc_major=$(echo $gcc_version | cut -d '.' -f 1)
#if [ $gcc_major -ne 9 ]; then
#    echo "ERROR: gcc version must be 9. Use module load gcc/9.2.0 to load the correct version before sourcing this file"
#    return 1
#fi

echo "Loading modules gcc/9.2.0 and scons/4.4.0"
module load gcc/9.2.0
module load scons/4.4.0

export SIM_HOME=/site/12gev_phys

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

