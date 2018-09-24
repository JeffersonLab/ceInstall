# ceInstall

Installation and environment settings of the following libraries:

- banks
- ccdb
- clhep
- evio
- geant4
- geant4Data
- gemc
- jana
- mlibrary
- qt
- root
- scons
- xercesc


Both installation and system environment are independent of the location and OS of the software, provided it is recent enough.


To release a JLAB_VERSION: 

- change release date in ce/jlab scripts
- change default JLAB_VERSION in jlab.csh and jlab.sh
- make sure versions.env is updated
- make new tag as needed, remember to update changelog. Notice, deleting a github release is not enough: need to delete the tag also.
- test installation, copy log in sbsInstall/template_install.html
- tag the libraries below. To tag, use v1.4 and 1.4 as release name. Add notes.

Remember that go_tar supports the "local" third option to create a "debug" tar file instead of using the github tag feature.

- banks
- gemc 
- mlibrary
- scons_bm


NOTES:

- go_tar ceInstall will generate the _install.html based on the release number
- for JLAB interactive farm. Usually it cannot access the outside web, but setting these bypass this:

a. setenv http_proxy http://jprox.jlab.org:8082
b. setenv https_proxy http://jprox.jlab.org:8082

For ROOT in particular one can also download these "src" and put them in the "dst".

a. src1='http://lcgpackages.web.cern.ch/lcgpackages/tarFiles/sources/lz4-v1.7.5.tar.gz' to: dst1='/group/halla/analysis/rootbuild/ifarm1402/root-6.12.06/build/LZ4-prefix/src/lz4-v1.7.5.tar.gz'
b. src2='http://lcgpackages.web.cern.ch/lcgpackages/tarFiles/sources/tbb2017_U5.tar.gz' to: dst2='/group/halla/analysis/rootbuild/ifarm1402/root-6.12.06/build/TBB-prefix/src/tbb2017_U5.tar.gz'



TODO:

- additional options to choose individual libraries
- add CERN LIBS if user so requests
