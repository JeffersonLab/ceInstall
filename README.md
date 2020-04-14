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


To release a JLAB_VERSION: 

1. change release date in ce/jlab.csh script
2. change default JLAB_VERSION in jlab.csh and jlab.sh (usually from devel to tag).  Change (production) on softenv.*
3. change default JLAB_VERSION in go_reload
4. make sure versions.env is updated
5. if necessary add the QT_VERSION tag in softenv.csh and jlab.sh for JLAB.
6. make sure the geant4 data versions are correct, in geant4.env AND in go_geant4
7. add the tag in sbsinstall/template alternative installation lines. Notice you need to add that line in devel_install as that one is not overwritten.
8. Use go_tar ceInstall tag local. 
9. test installation, copy log in sbsInstall/template_install.html
10. test installation on docker
11. after test add github tag. Notice: deleting a github release is not enough: need to delete the tag also.
12. tag the libraries below. To tag, use v1.4 and 1.4 as release name. Add notes.

Remember that go_tar supports the "local" third option to create a "debug" tar file instead of using the github tag feature.

- banks
- gemc 
- mlibrary
- scons_bm


Location to copy the tar.gz files:

/u/group/12gev_phys/www/packages/sources

NOTES:

- go_tar ceInstall will generate the _install.html based on the release number

TODO:

- add CERN LIBS if user so requests
