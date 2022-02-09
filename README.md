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

01. Change release date in ce/jlab.csh script
02. Change default JLAB_VERSION in jlab.csh and jlab.sh (usually from devel to tag). 
03. Change default JLAB_VERSION in go_reload
04. Make sure versions.env is updated
05. If necessary add the QT_VERSION tag in softenv.csh and jlab.sh for JLAB.
06. Make sure the geant4 data versions are correct, in geant4.env AND in go_geant4
07. Add the logs installation lines in sbsinstall/template alternative installation lines.
08. Use go_tar ceInstall tag local. 
09. Test installation, copy log in sbsInstall/template_install.html
10. Test installation on docker
11. After test add github tag. Notice: deleting a github release is not enough: need to delete the tag also.
12. Tag the libraries below. To tag, use v1.4 and 1.4 as release name. Add notes.

Remember that go_tar supports the "local" third option to create a "debug" tar file instead of using the github tag feature.

- banks
- gemc 
- mlibrary
- scons_bm

Location to copy the tar.gz files:

/u/group/12gev_phys/www/packages/sources

NOTES:

- go_tar ceInstall will generate the _install.html based on the release number

