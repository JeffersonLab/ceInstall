#!/bin/tcsh -f

echo
set JLAB_VERSION=$1

source ce/versions.env

echo banks:      $DEFAULT_BANKS_VERSION
echo ccdb:       $DEFAULT_CCDB_VERSION
echo clhep:      $DEFAULT_CLHEP_VERSION
echo evio:       $DEFAULT_EVIO_VERSION
echo geant4:     $DEFAULT_GEANT4_VERSION
echo geant4Data: $DEFAULT_G4DATA_VERSION
echo gemc:       $DEFAULT_GEMC_VERSION
echo jana:       $DEFAULT_JANA_VERSION
echo mlibrary:   $DEFAULT_MLIBRARY_VERSION
echo qt:         $DEFAULT_QT_VERSION
echo root:       $DEFAULT_ROOT_VERSION
echo scons bm:   $DEFAULT_SCONS_BM_VERSION
echo xercesc:    $DEFAULT_XERCESC_VERSION
