#!/bin/csh

# This script is used to satisfy the common environment requirements at Jefferson Lab
module use /apps/modulefiles
module load cmake/3.23.2
module load gcc/9.2.0

if ( `cat /etc/redhat-release | grep -c 7` > 0 ) then
    echo "CentOS 7 detected at JLab. Loading site modules"
    source /site/12gev_phys/modules/init/tcsh
endif






source /site/12gev_phys/ceInstall/setup.csh
