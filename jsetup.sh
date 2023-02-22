#!/bin/sh

# This script is used to satisfy the common environment requirements at Jefferson Lab
module use /apps/modulefiles
module load cmake/3.23.2
module load gcc/9.2.0

# at jlab the centos7 machines have an old version of modules
if [ -f /etc/centos-release ] && grep -q 'CentOS Linux release 7' /etc/centos-release; then
    echo "CentOS 7 detected at JLab. Loading site modules"
    if [ -n "$BASH_VERSION" ]; then
        source /site/12gev_phys/modules/init/bash
    elif [ -n "$ZSH_VERSION" ]; then
        source /site/12gev_phys/modules/init/zsh
    fi
fi

source /site/12gev_phys/setup.csh


