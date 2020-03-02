#!/bin/zsh

# Purpose: creates the module file for clhep
#
# Arguments: exactly two argument, the location of the module dir and the libarary version

f [ "$#" -ne 2 ]; then
    echo " "       >&2
    echo " Usage:" >&2
    echo " "       >&2
    echo  " $0 moduleDirectory, clhep library version"  >&2
    echo " "       >&2
    exit 1
fi

