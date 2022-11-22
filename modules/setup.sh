#!/bin/sh

# load module for the current OS
case $(uname -s) in
    Linux)
        . /etc/profile.d/modules.sh
        ;;
    Darwin)
        brewDir=$(brew --prefix)
        . "$brewDir"/opt/modules/init/sh
        ;;
    *)
        echo "Unsupported OS: $(uname -s)"
        exit 1
        ;;
esac

# extract path to this file
export modules_home=$(dirname $(readlink -f "$0"))
export OSRELEASE=$( $modules_home/osrelease.py )

module use ${modules_home}/modulefiles


