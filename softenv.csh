# As of 3/7/2018 this script require explicit argument
# to set the JLAB_VERSION
# An additional argument can be provided to keep certain user setting

setenv JLAB_ROOT /site/12gev_phys

# Making sure we use one of the supported versions:
if($1 != "2.3" && $1 != "2.2" && $1 != "2.1" && $1 != "2.0" && $1 != "devel") then
	echo
	echo "  Usage:  'source $JLAB_ROOT/softenv.csh <version>'"
	echo
	echo "  Supported Versions: "
	echo
	echo "   - 2.3 (production)"
	echo "   - 2.2 "
	echo "   - 2.1 "
	echo "   - 2.0 "
	echo "   - devel "
	echo; echo
	exit
endif

# version is ok, can continue
setenv JLAB_VERSION $1

# using new compiler just for devel for now
# also, using python3
if ($JLAB_VERSION == "devel") then
	alias python python3
	module use /apps/modulefiles
	module load cmake/3.13.4
	module load gcc/9.2.0
endif

set OVERWRITE="yes"  # will overwrite user settings

# version 2.3 at JLAB has the QT_VERSION set to 5.10.1
# notice: on the new ifarm QTDIR is set. So we can't use keepmine
# unless we unsetenv it
# notice: this is effectively rendering the overwrite feature useless for QT
# but it's ok: no one ever used it since the start of this project many years ago
# So now we have an non elegant solution that conceptually is also wrong.
# The use of "module" for the next iteration of these script is more and more appealing.
if( $1 == "2.3" || $1 == "devel") then
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

