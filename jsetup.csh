#!/bin/csh

# Use JLab modules
module use /apps/modulefiles

# check that gcc --version gives a version number different than 9
set gcc_version = `gcc --version | grep -o -E '[0-9]+' | head -1`

if ( $gcc_version == 9 ) then
    echo "ERROR: gcc version must be 9. Use module load gcc/9.2.0 to load the correct version before sourcing this file"
    exit 1
endif

# This script is used to as pre-setup the environment at Jefferson Lab (JLab)

setenv SIM_HOME /site/12gev_phys

# at JLab the centos7 machines have an old version of modules
# se we need to use a newer version
if ( `cat /etc/redhat-release | grep -c 7` > 0 ) then
    echo "CentOS 7 detected at JLab. Loading site modules"
    source /site/12gev_phys/modules/init/tcsh
endif





source $SIM_HOME/ceInstall/setup.sh
