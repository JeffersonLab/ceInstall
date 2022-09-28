#!/bin/tcsh -f

echo

source ce/versions.env

echo banks:      $DEFAULT_BANKS_VERSION
echo ccdb:       $DEFAULT_CCDB_VERSION
echo clhep:      $DEFAULT_CLHEP_VERSION
echo evio:       $DEFAULT_EVIO_VERSION
echo geant4:     $DEFAULT_GEANT4_VERSION
echo geant4Data: $DEFAULT_G4DATA_VERSION
echo hipo:       $DEFAULT_HIPO_VERSION
echo gemc:       $DEFAULT_GEMC_VERSION
echo mlibrary:   $DEFAULT_MLIBRARY_VERSION
echo qt:         $DEFAULT_QT_VERSION
echo root:       $DEFAULT_ROOT_VERSION
echo scons bm:   $DEFAULT_SCONS_BM_VERSION
echo xercesc:    $DEFAULT_XERCESC_VERSION
echo
echo Geant4 data:
echo
echo setenv G4LEDATA           '$'G4DATA_DIR/`\ls $G4DATA_DIR| grep G4EMLOW`           # Data for low energy electromagnetic processes
echo setenv G4LEVELGAMMADATA   '$'G4DATA_DIR/`\ls $G4DATA_DIR| grep PhotonEvaporation` # Nuclear Photon evaporation data
echo setenv G4NEUTRONHPDATA    '$'G4DATA_DIR/`\ls $G4DATA_DIR| grep G4NDL`             # Data for neutron scattering processes
echo setenv G4NEUTRONXSDATA    '$'G4DATA_DIR/`\ls $G4DATA_DIR| grep G4NEUTRONXS`       # Data for evaluated neutron cross sections on natural composition of elements
echo setenv G4PIIDATA          '$'G4DATA_DIR/`\ls $G4DATA_DIR| grep G4PII`             # Data for shell ionisation cross-sections
echo setenv G4RADIOACTIVEDATA  '$'G4DATA_DIR/`\ls $G4DATA_DIR| grep RadioactiveDecay`  # Data for radioactive decay hadronic processes
echo setenv G4REALSURFACEDATA  '$'G4DATA_DIR/`\ls $G4DATA_DIR| grep RealSurface`       # Data measured optical surface reflectance in optical processes
echo setenv G4SAIDXSDATA       '$'G4DATA_DIR/`\ls $G4DATA_DIR| grep G4SAIDDATA`        # Data for Said Database
echo setenv G4ABLADATA         '$'G4DATA_DIR/`\ls $G4DATA_DIR| grep G4ABLA`            # Data for G4ABLA
echo setenv G4ENSDFSTATEDATA   '$'G4DATA_DIR/`\ls $G4DATA_DIR| grep G4ENSDFSTATE`      # Data for G4ENSDFSTATE
echo
