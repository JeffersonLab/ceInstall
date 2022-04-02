# As of 3/7/2018 this script require explicit argument
# to set the JLAB_VERSION
# An additional argument can be provided to keep certain user setting

setenv JLAB_ROOT /site/12gev_phys

setenv JLAB_VERSION $1

# using new compiler just for devel for now
# also, using python3
if ($JLAB_VERSION == "2.6" || $JLAB_VERSION == "2.5" || $JLAB_VERSION == "2.4") then
	alias python python3
	source /etc/profile.d/modules.csh
	module use /apps/modulefiles
	module load cmake
	module load gcc/9.2.0

	# needed otherwise cmake could pick up the system cc
	setenv CC gcc
	setenv CXX g++
else
	echo
	echo "  Usage:  'source $JLAB_ROOT/softenv.csh <version>'"
	echo
	echo "  Supported Versions: "
	echo
	echo "   - 2.6 "
	echo "   - 2.5 "
	echo "   - 2.4 "
	echo; echo
	exit
endif

if ($JLAB_VERSION == "2.6") then
	module unload cmake
	module load cmake/3.18.1
endif

set OVERWRITE="yes"  # will overwrite user settings

# version 2.4 at JLAB uses the system QT_VERSION 5.10.1
# notice: the lines below are effectively rendering the overwrite feature useless for QT
# but it's ok: no one ever used it since the start of this project many years ago
# So now we have an non elegant solution that conceptually is also wrong.
# The use of "module" for the next iteration of these script is more and more appealing.
if( $1 == "2.4") then
	unsetenv QTDIR
	setenv QT_VERSION 5.10.1
	set OVERWRITE=keepmine
endif

if( "$2" == "keepmine") then
	unsetenv QTDIR
	set OVERWRITE=keepmine
endif

set config_csh="$JLAB_ROOT/$JLAB_VERSION/ce/jlab.csh"

if( -e  "$config_csh") then
	source "$config_csh" $OVERWRITE
else
	echo
	echo "  Configuration '$1' not available on this machine."
	echo "  For documentation on the environment please visit https://data.jlab.org "
	echo
	exit
endif

alias echo 'if($?prompt) echo \!*  '

echo \ \>\> For documentation on the environment please visit https://data.jlab.org
echo

