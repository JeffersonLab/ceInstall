#!/bin/zsh

source "$(dirname "$(readlink -f "$0")")"/functions.zsh

filename="evio/evio-$EVIO_VERSION.tar.gz" # includes subdirectory name
tar_strip=1                               # in the tarball, the source is inside version


base_dir=$EVIO

log_general evio "$EVIO_VERSION" "$filename" "$base_dir"

unpack_source_in_directory "$filename" "$base_dir" "$tar_strip"

scons_build_and_install "$base_dir"
