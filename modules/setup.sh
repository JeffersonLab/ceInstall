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
export modules_home=$(dirname "$(realpath "${BASH_SOURCE:-$0}")")
export OSRELEASE=$( "$modules_home"/osrelease.py )

# if PHYS_HOME environment variable is not set, set it to the current directory
if [ -z "$PHYS_HOME" ]; then
    export PHYS_HOME=$(realpath $modules_home/../..)
fi

module use "${modules_home}"/modulefiles

echo "Modules loaded for PHYS_HOME=$PHYS_HOME. Use 'module avail' to see available modules."
echo

# adds pinstall to path
export PATH="$PATH":"${modules_home}/../pinstall"
