#!/bin/zsh

source "$(dirname "$(readlink -f "$0")")"/functions.zsh

filename="xercesc/xerces-c-$XERCESC_VERSION.tar.gz" # includes subdirectory name
tar_strip=1                                         # in the tarball, the source is inside xerces-c-VERSION

source_dir=$XERCESCROOT/source
build_dir=$XERCESCROOT/build
base_dir=$XERCESCROOT
cmake_options="-Wno-dev"


log_general clhep "$CLHEP_VERSION" "$filename" "$base_dir"

unpack_source_in_directory "$filename" "$source_dir" "$tar_strip"

cmake_build_and_install "$source_dir" "$build_dir" "$base_dir" "$cmake_options"
