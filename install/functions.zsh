#!/bin/zsh

red=$(   tput setaf 1)
green=$( tput setaf 2)
yellow=$(tput setaf 3)
blue=$(  tput setaf 4)
magenta=$(tput setaf 5)
reset=$( tput sgr0)

# needed otherwise cmake could pick up the system cc
export CC=gcc
export CXX=g++

# should be deprecated soon
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
	echo " > Origin:                  $filename"
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
	curl -sSL "$url" --output "$filename"

	echo "$magenta > Unpacking $filename in $dir$reset"
	echo

	tar -zxpf "$filename" --strip-components="$tar_strip"
	rm -f "$filename"
}

unpack_source_in_directory_from_url() {
	url=$1
	dir=$2
	tar_strip=$3
	# if the fourth argument 'no_remove' is given, do not remove the tarball
	if [ "$#" -eq 4 ]; then
		no_remove=$4
	else
		no_remove=0
	fi

	filename=$(basename "$url")

	echo
	echo " > url: $url"
	echo " > dir: $dir"
	echo " > tar_strip: $tar_strip"
	echo " > filename: $filename"
	echo

	# if no_remove is 1, do not remove the tarball
	if [ "$no_remove" -eq 0 ]; then
		dir_remove_and_create "$dir"
	else
		mkdir -p "$dir"
	fi

	cd "$dir" || whine_and_quit "cd $dir"

	echo "$magenta > Fetching source from $url onto $filename$reset"
	rm -f "$filename"
	#	wget "$url" || whine_and_quit "wget $url"
	curl -S --location-trusted --progress-bar --retry 4 "$url" -O || whine_and_quit "wget $url"
	echo "$magenta > GTar Unpacking $filename in $dir$reset"
	gtar -zxpf "$filename" --strip-components="$tar_strip"
	rm -f "$filename"
	echo " > Done with $filename"
	echo
}

clone_tag() {
	url=$1
	version=$2
	source_dir=$3

	echo
	echo " > url: $url"
	echo " > clone_tag: " $version
	echo " > in directory: $install_dir"

	git clone -c advice.detachedHead=false --recurse-submodules --single-branch -b $version "$url" "$source_dir"
	echo
}

meson_install() {
	meson_options=$1
	install_dir=$2

	meson setup build "$meson_options" --wipe
	cd build
	meson configure -Dprefix="$install_dir"
	meson install
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
	echo "$magenta > Configuring cmake...$reset"
	cmake "$source_dir" -DCMAKE_INSTALL_PREFIX="$install_dir" $=cmake_options 2>"$install_dir/cmake_err.txt" 1>"$install_dir/cmake_log.txt" || whine_and_quit "cmake $source_dir -DCMAKE_INSTALL_PREFIX=$install_dir $=cmake_options"

	echo "$magenta > Done, now building...$reset"
	make -j "$n_cpu" 2>$install_dir/build_err.txt 1>"$install_dir/build_log.txt" || whine_and_quit "make -j $n_cpu"

	echo "$magenta > Done, now installing...$reset"
	make install 2>$install_dir/install_err.txt 1>"$install_dir/install_log.txt" || whine_and_quit "make install"

	echo " Content of $install_dir after installation:"
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
	elapsed=$((cmd_end - cmd_start))

	echo "$magenta > Compilation and installation completed in $elapsed seconds.$reset"
}



function moduleTestResult() {
	library=$1
	version=$2

	# we're only interested in the exit status
	module test "$library/$version" &>/dev/null
	echo $?
}
