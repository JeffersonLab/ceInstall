# As of 3/7/2018 this script require explicit argument
# to set the JLAB_VERSION
# An additional argument can be provided to keep certain user setting

setenv JLAB_ROOT /site/12gev_phys


# Making sure we maintain the supported versions:
## - 2.0
## - 2.1
## - 2.2 (production)
## - devel
if($1 != "2.2" && $1 != "2.1" && $1 != "2.0") then
	echo "$1 is not among the supported versions: 2.0, 2.1, 2.2 or devel"
endif
setenv JLAB_VERSION $1

set OVERWRITE=""
if( "$2" == "keepmine" || "$2" == "overwrite") then
	set OVERWRITE=keepmine
endif

set config_csh="$JLAB_ROOT/$JLAB_VERSION/ce/jlab.csh"

if( -e  "$config_csh") then
	source "$config_csh" $OVERWRITE
else
	echo "  Configuration '$1' not available on this machine."
	echo "  Usage:  'source $JLAB_ROOT/production.csh <version>'"
	echo -n "    Versions: "
	foreach f ($JLAB_ROOT/*)
		set bn=`basename $f`
		if( $bn == "noarch" ) continue
		if( -d "$f" )         echo -n "  $bn"
	end
	echo; echo
	exit
endif

alias echo 'if($?prompt) echo \!*  '

echo \ \>\> For documentation and a list of supported architectures please look at https://data.jlab.org
echo

