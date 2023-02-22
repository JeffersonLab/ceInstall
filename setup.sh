#!/bin/sh

# at jlab the centos7 machines have an old version of modules
hostname=$(hostname)
if hostname | grep -q .jlab.org; then
    # if on centos7, echo yes
    if [ -f /etc/centos-release ] && grep -q 'CentOS Linux release 7' /etc/centos-release; then
        echo "CentOS 7 detected at JLab. Loading site modules"
        # if we are in bash, source the site modules
        if [ -n "$BASH_VERSION" ]; then
            source /site/12gev_phys/modules/init/bash
         elif [ -n "$ZSH_VERSION" ]; then
            source /site/12gev_phys/modules/init/zsh
        fi
    fi
fi

# extract path to this file
export modules_home=$(dirname "$(realpath "${BASH_SOURCE:-$0}")")

# if OSRELEASE environment variable is not set, use osrelease.py
if [ -z "$OSRELEASE" ]; then
    export OSRELEASE=$( "$modules_home"/osrelease.py )
fi

# if SIM_HOME environment variable is not set, set it to the current directory
if [ -z "$SIM_HOME" ]; then
    export SIM_HOME=$(realpath "$modules_home"/../)
fi

# if SIM_SUB_DIR environment variable is not set, set it to 'sim'
if [ -z "$SIM_SUB_DIR" ]; then
    export SIM_SUB_DIR=sim
fi

module use "${modules_home}"/modulefiles

echo "Modules loaded for SIM_HOME=$SIM_HOME. Use 'module avail' to see available modules."
echo

# adds pinstall to path
export PATH="$PATH":"${modules_home}/install"
