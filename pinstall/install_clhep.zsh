#!/bin/zsh

source "$(dirname "$(readlink -f "$0")")"/functions.zsh

filename="clhep/clhep-$CLHEP_VERSION.tgz" # includes subdirectory name
tar_strip=2                               # in the tarball, the source is inside VERSION/CLHEP

source_dir=$CLHEP_BASE_DIR/../source
build_dir=$CLHEP_BASE_DIR/../build
base_dir=$CLHEP_BASE_DIR
cmake_options="-Wno-dev"


log_general clhep "$CLHEP_VERSION" "$filename" "$base_dir"

unpack_source_in_directory "$filename" "$source_dir" "$tar_strip"

cmake_build_and_install "$source_dir" "$build_dir" "$base_dir" "$cmake_options"

