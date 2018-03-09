# As of 3/7/2018 this script require explicit argument
# to set the JLAB_VERSION
# An additional argument can be provided to keep certain user setting

setenv JLAB_ROOT /site/12gev_phys

# Making sure we maintain the supported versions:
## - 2.0
## - 2.1
## - 2.2 (production)
## - devel
if($1 != "2.2" && $1 != "2.1" && $1 != "2.0" && $1 != "devel") then
	echo "$1 is not among the supported versions: 2.0, 2.1, 2.2 or devel"
endif
setenv JLAB_VERSION $1

set OVERWRITE="yes"  # will overwrite user settings
if( "$2" == "keepmine") then
	set OVERWRITE=keepmine
endif

set config_csh="$JLAB_ROOT/$JLAB_VERSION/ce/jlab.csh"

if( -e  "$config_csh") then
	source "$config_csh" $OVERWRITE
else
	echo "  Configuration '$1' not available on this machine."
	echo "  Usage:  'source $JLAB_ROOT/softenv.csh <version>'"
	echo "    Supported Versions: "
	echo "     - 2.0 "
	echo "     - 2.1 "
	echo "     - 2.2 "
	echo "     - devel "
	end
	echo; echo
	exit
endif

alias echo 'if($?prompt) echo \!*  '

echo \ \>\> For documentation on the environment please visit https://data.jlab.org
echo

