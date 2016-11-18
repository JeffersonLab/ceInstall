# As of 2/10/2015 the production version 
# is a link to 1.2

setenv JLAB_ROOT /site/12gev_phys
setenv JLAB_VERSION 1.2

if($1 == "1.0" || $1 == "1.1" || $1 == "1.2" || $1 == "1.3" || $1 == "1.3.1" || $1 == "1.4" || $1 == "2.0" || $1 == "devel") then
	setenv JLAB_VERSION $1
else
	echo Configuration $1 not recognized. Please use devel or a version between 1.0 and 2.0
	exit
endif

source $JLAB_ROOT/$JLAB_VERSION/ce/jlab.csh


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
echo \ \>\> For documentation and a list of supported architectures please look at data.jlab.org
echo

