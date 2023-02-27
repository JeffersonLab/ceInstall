#!/bin/csh

# This script is used to as pre-setup the environment at Jefferson Lab (JLab)

# Use JLab modules
module use /apps/modulefiles

# at JLab the centos7 machines have an old version of modules
# se we need to use a newer version
if ( `cat /etc/redhat-release | grep -c 7` > 0 ) then
    echo "CentOS 7 detected at JLab. Loading site modules"
    source /site/12gev_phys/modules/init/tcsh
endif





source /site/12gev_phys/ceInstall/setup.csh
