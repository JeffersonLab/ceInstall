# As of 2/10/2015 the production version 
# is a link to 1.2

setenv JLAB_ROOT /site/12gev_phys
setenv JLAB_VERSION 1.2

if( "$1" != "" ) setenv JLAB_VERSION $1

set config_csh="$JLAB_ROOT/$JLAB_VERSION/ce/jlab.csh"

if( -e  "$config_csh") then
  source "$config_csh"
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

# Warning for CentOS2
if (-r /etc/centos-release) then
  if { ( grep -q 'CentOS release 6.2' /etc/centos-release ) } then
    echo " > NOTE:  Not all 1.2 packages are supported under CentOS62."
    echo " > Please move to the updated CentOS65 environment using"
    echo " > ifarm65.jlab.org AND "OS: centos65" for farm submissions."
    echo 
  endif
endif
echo \ \>\> For documentation and a list of supported architectures please look at https://data.jlab.org
echo

