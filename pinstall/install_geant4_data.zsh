#!/bin/zsh

source "$(dirname "$(readlink -f "$0")")"/functions.zsh

DATAFILES=(
		G4NDL.$g4ndl_version.tar.gz
		G4EMLOW.$g4emlow_version.tar.gz
		G4PhotonEvaporation.$g4photonevaporation_version.tar.gz
		G4RadioactiveDecay.$g4radioactivedecay_version.tar.gz
		G4SAIDDATA.$g4saidata_version.tar.gz
		G4PARTICLEXS.$g4particlexs_version.tar.gz
		G4ABLA.$g4abla_version.tar.gz
		G4INCL.$g4incl_version.tar.gz
		G4PII.$g4pii_version.tar.gz
		G4ENSDFSTATE.$g4ensdfstate_version.tar.gz
		G4RealSurface.$g4real_surface_version.tar.gz
)

# loop over DATAFILES
for file in $DATAFILES; do
  unpack_data_in_directory geant4_data/$G4_VERSION/$file $G4DATA_DIR
done