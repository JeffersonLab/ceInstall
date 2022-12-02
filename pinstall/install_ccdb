#!/bin/zsh

source "$(dirname "$(readlink -f "$0")")"/functions.zsh

filename="ccdb/ccdb-$CCDB_VERSION.tar.gz" # includes subdirectory name
tar_strip=1                               # in the tarball, the source is inside ccdb-version


base_dir=$CCDB_HOME

log_general ccdb "$CCDB_VERSION" "$filename" "$base_dir"

unpack_source_in_directory "$filename" "$base_dir" "$tar_strip"

unset SCONSFLAGS
scons_build_and_install "$base_dir"

