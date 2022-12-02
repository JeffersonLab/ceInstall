#!/bin/zsh

source "$(dirname "$(readlink -f "$0")")"/functions.zsh

filename="mlibrary/mlibrary_$MLIBRARY_VERSION.tar.gz" # includes subdirectory name
tar_strip=1                                           # in the tarball, the source is inside mlibrary-version


base_dir=$MLIBRARY


log_general mlibrary "$MLIBRARY_VERSION" "$filename" "$base_dir"

unpack_source_in_directory "$filename" "$base_dir" "$tar_strip"

cd $MLIBRARY
./compileCmesh

scons_build_and_install "$base_dir"

