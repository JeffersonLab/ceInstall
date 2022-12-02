#!/bin/zsh

source "$(dirname "$(readlink -f "$0")")"/functions.zsh

filename="scons_bm/scons_bm_$SCONS_BM_VERSION.tar.gz" # includes subdirectory name
tar_strip=1                                           # in the tarball, the source is inside scons_bm

base_dir="$SCONS_BM"


log_general scons_bm "$SCONS_BM_VERSION" "$filename" "$base_dir"

unpack_source_in_directory "$filename" "$base_dir" "$tar_strip"

echo "$magenta > scons_bm installation completed.$reset"
 echo
