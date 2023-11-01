#!/bin/csh

# Use JLab modules
module use /apps/modulefiles

# need modules veesuib 5 or above
source /apps/modules/5.2.0/init/csh

echo "Loading modules gcc/9.2.0 and scons/4.4.0"
module load gcc/9.2.0
module load scons/4.4.0
module load cmake
setenv CC gcc
setenv CXX g++

setenv SIM_HOME /site/12gev_phys

# at JLab the centos7 machines have an old version of modules
# se we need to use a newer version
if ( `cat /etc/redhat-release | grep -c 7` > 0 ) then
    echo "CentOS 7 detected at JLab. Loading site modules"
    source /site/12gev_phys/modules/init/tcsh
endif





source $SIM_HOME/ceInstall/setup.csh "$@"
