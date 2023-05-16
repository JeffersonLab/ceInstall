#!/bin/zsh

red=`    tput setaf 1`
green=`  tput setaf 2`
yellow=` tput setaf 3`
blue=`   tput setaf 4`
magenta=`tput setaf 5`
reset=`  tput sgr0`

# needed otherwise cmake could pick up the system cc
export CC=gcc
export CXX=g++

# should be deeprecated soon
repo="https://www.jlab.org/12gev_phys/packages/sources"

n_cpu=$(getconf _NPROCESSORS_ONLN)


whine_and_quit() {
  echo "$red $1 error $reset"
  exit 1
}

log_general() {
	this_package=$1
	version=$2
	filename=$3
	base_dir=$4
	echo
	echo " > Package:                 $this_package version $version"
	echo " > Origin:                  $repo/$filename"
	echo " > Destination:             $base_dir"
	echo " > Release:                 $OSRELEASE"
	echo " > Multithread Compilation: $n_cpu"
	echo
}

dir_remove_and_create() {
	dir=$1
	if [ -d "$dir" ]; then
		rm -rf "$dir"
	fi
	mkdir -p "$dir"
}

unpack_source_in_directory_from_jlab_repo() {
	url=$repo/$1
	dir=$2
	tar_strip=$3
	filename=$(basename "$url")
	
	echo
	echo " > unpack_source_in_directory_from_jlab_repo: "
	echo " > url: $url"
	echo " > dir: $dir"
	echo " > tar_strip: $tar_strip"
	echo " > filename: $filename"
	echo
	
	dir_remove_and_create "$dir"
	cd "$dir" || whine_and_quit "cd $dir"
	
	echo "$magenta > Fetching source from $url onto $filename$reset"
	rm -f "$filename"
	curl -sSL  "$url" --output "$filename"
	
	echo "$magenta > Unpacking $filename in $dir$reset"
	echo
	
	tar -zxpf "$filename" --strip-components="$tar_strip"
	rm -f "$filename"
}

unpack_source_in_directory_from_url() {
	url=$1
	dir=$2
	tar_strip=$3
	filename=$(basename "$url")

	echo
	echo " > unpack_source_in_directory_from_url: "
	echo " > url: $url"
	echo " > dir: $dir"
	echo " > tar_strip: $tar_strip"
	echo " > filename: $filename"
	echo

	dir_remove_and_create "$dir"
	cd "$dir" || whine_and_quit "cd $dir"

	echo "$magenta > Fetching source from $url onto $filename$reset"
	rm -f "$filename"
	curl -sSL "$url" --output "$filename"
	echo "Downloaded file:"
	ls -lrt

	echo "$magenta > Unpacking $filename in $dir$reset"
	echo

	tar -zxpf "$filename" --strip-components="$tar_strip"
	#rm -f "$filename"
}

unpack_data_in_directory() {
	url=$repo/$1
	dir=$2
	
	filename=$(basename "$url")
	
	mkdir -p "$dir"
	cd "$dir" || whine_and_quit "cd $dir"
	
	echo "$magenta > Fetching source from $url onto $filename$reset"
	rm -f "$filename"
	curl -sSL "$url" --output "$filename"
	
	echo "$magenta > Unpacking $filename in $dir$reset"
	echo
	
	tar -zxpf "$filename"
	rm -f "$filename"
}

cmake_build_and_install() {
	source_dir=$1
	build_dir=$2
	install_dir=$3
	cmake_options=$4
	do_not_delete_source=$5
	
	echo " > source_dir:    $source_dir"
	echo " > build_dir:     $build_dir"
	echo " > install_dir:   $install_dir"
	echo " > cmake_options: $cmake_options"
	
	local cmd_start="$SECONDS"

  # install_dir is the base directory containing $build_dir
	dir_remove_and_create "$build_dir"
	cd "$build_dir" || whine_and_quit "cd $build_dir"
	
	echo
	echo "$magenta > Configuring cmake with: $=cmake_options$reset"
	echo
	
	cmake  "$source_dir" -DCMAKE_INSTALL_PREFIX="$install_dir" $=cmake_options  2>"$install_dir/cmake_err.txt" 1>"$install_dir/cmake_log.txt" || whine_and_quit "cmake $source_dir -DCMAKE_INSTALL_PREFIX=$install_dir $=cmake_options"
	
	echo "$magenta > Building$reset"
	make -j "$n_cpu" 2>$install_dir/build_err.txt 1>"$install_dir/build_log.txt" || whine_and_quit "make -j $n_cpu"
	
	echo "$magenta > Installing$reset"
	make install  2>$install_dir/install_err.txt 1>"$install_dir/install_log.txt" || whine_and_quit "make install"

	echo " Content of $install_dir:"
	ls -l "$install_dir"
	if [[ -d "$install_dir/lib" ]]; then
	    echo " Content of $install_dir/lib:"
	    ls -l "$install_dir/lib"
	fi

	# cleanup
	echo "$magenta > Cleaning up...$reset"
	rm -rf "$build_dir"

	# if delete_source is set, do not delete the source directory
  if [ -z "$do_not_delete_source" ]; then
    echo "$magenta > Deleting source directory...$reset"
    rm -rf "$source_dir"
  fi


	local cmd_end="$SECONDS"
	elapsed=$((cmd_end-cmd_start))
	
	echo "$magenta > Compilation and installation completed in $elapsed seconds.$reset"
	echo
}

scons_build_and_install() {

	install_dir=$1

	build_shared=''
	# if a second argument is given to this function, set build_shared to it
	if [ -n "$2" ]; then
        build_shared=$2
        echo " > build_shared:  $build_shared"
    fi

	echo " > install_dir:   $install_dir"
	
	local cmd_start="$SECONDS"
	cd "$install_dir" || whine_and_quit "cd $install_dir"

	scons_options=" -j$n_cpu OPT=1 $build_shared"
	echo "$magenta > Building using scons options: > $=scons_options < $reset"
	rm -f .sconsign.dblite # for some reason this still linger
#	\scons "$scons_options" 2>"$install_dir/build_err.txt" 1>"$install_dir/build_log.txt" || whine_and_quit "\scons $scons_options"
	\scons "$=scons_options"

	# cleanup
	echo "$magenta > Cleaning up...$reset"
	find ./ -name "*.o" -delete
	local cmd_end="$SECONDS"
	elapsed=$((cmd_end-cmd_start))

	echo " Content of this dir:"
    ls -l

	if [[ -d "lib" ]]; then
	    echo " Content of lib:"
	    ls -l lib/
	fi

	echo "$magenta > Compilation and installation completed in $elapsed seconds.$reset"
	echo
}

function moduleTestResult() {
	library=$1
	version=$2

	# we're only interested in the exit status
	module test "$library/$version" &> /dev/null
	echo $?
}
