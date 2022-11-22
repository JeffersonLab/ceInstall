#!/bin/csh

# load module for the current OS
case $(uname -s) in
    Linux)
        source /etc/profile.d/modules.sh
        ;;
    Darwin)
        brewDir = $(brew --prefix)
        source $brewDir/opt/modules/init/sh
        ;;
    *)
        echo "Unsupported OS: $(uname -s)"
        exit 1
        ;;
esac

# extract path to this file
setenv modules_home=$(dirname "$(readlink -f $0)")
setenv OSRELEASE $(modules_home/osrelease.py)

module use "$modules_home"/modulefiles
