#!/bin/sh

# This script is used to as pre-setup the environment at Jefferson Lab (JLab)

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

source /site/12gev_phys/ceInstall/setup.sh


