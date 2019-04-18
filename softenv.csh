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

set OVERWRITE="yes"  # will overwrite user settings

# version 2.3 at JLAB has the QT_VERSION set to 5.10.1
if( $1 == "2.3" || $1 == "devel") then
	setenv QT_VERSION 5.10.1
	set OVERWRITE=keepmine
endif

if( "$2" == "keepmine") then
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

