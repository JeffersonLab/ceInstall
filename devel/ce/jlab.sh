#
# You must source this script. At your bash prompt type: ". <path>/jlab.sh"
#
# Get the JLAB environment variables by parsing the script in tcsh and then printing the  environment. 
# We need to filter out the spaces, since that confuses the for loop. We also need to drop some
# tcsh specific environment variables from the export list.
#
# Author: Maurik Holtop, maurik@physics.unh.edu
# Date:   August, 2016
#
if [ -z $JLAB_ROOT ]; then
    echo "Please set JLAB_ROOT first."
    return
fi

while [ -z $JLAB_VERSION ]; do
    echo "Please choose a version:"
    select vers in 1.1 1.2 1.3 1.3.1 devel; do
       export JLAB_VERSION=${vers}
       break
    done
    if [ ! -d ${JLAB_ROOT}/${JLAB_VERSION} ]; then
	echo "Directory ${JLAB_ROOT}/${JLAB_VERSION} does not exist, please set JLAB_ROOT correctly. "
	unset JLAB_VERSION
	unset JLAB_ROOT
	return
    fi

done



for i in `tcsh -c "source ${JLAB_ROOT}/${JLAB_VERSION}/ce/jlab.csh ${JLAB_VERSION}; printenv" | grep "=" |  sed 's/ //g' `;  do 
    var=$(echo $i | cut -d= -f 1)
#
# Filter out some variables.
#
    if [ "$var" = "HISTTIMEFORMAT" ];     then continue; fi
    if [ "$var" = "SHELL" ];              then continue; fi
    if [ "$var" = "PS1" ];                then continue; fi
    if [ "$var" = "overwrite" ];          then continue; fi
    if [ "$var" = "_" ];                  then continue; fi
    if [ "$var" = "BASH_FUNC_module()" ]; then continue; fi

 # ON Mac, the DYLD_LIBRARY_PATH is not passed to tcsh, so preserve explicitly.
    if   [ "${OSTYPE}" = "darwin" ] && [ "$var" = "LD_LIBRARY_PATH" ];  then 
	export ${i%:}:${LD_LIBRARY_PATH}  # Remove trailing : if it is there.
    elif [ "${OSTYPE}" = "darwin" ] && [ "$var" = "DYLD_LIBRARY_PATH" ]; then 
	export ${i%:}:${DYLD_LIBRARY_PATH}
    else
	export ${i}
    fi
done

if [ ! -z $PS1 ]; then 
    echo
    echo " > Common Environment Version: <"$JLAB_VERSION">  "$CE_DATE
    echo " > Running as "`whoami` on `hostname`
    echo " > OS Release:    "$OSRELEASE
    echo " > JLAB_ROOT set to:     "$JLAB_ROOT
    echo " > JLAB_SOFTWARE set to: "$JLAB_SOFTWARE
    echo 
    if [ ! -d $CLHEP_BASE_DIR/lib ]; then
	echo " ? Attention: No CLHEP installation found for version ${CLHEP_VERSION}"
    else
	echo " > CLHEP    version: ${CLHEP_VERSION} "
    fi
    if [ ! -d $QTDIR/lib ]; then
	echo " ? Attention: No QT   installation found for version ${QT_VERSION}"
    else
	echo " > QT       version: ${CLHEP_VERSION} "
    fi
    if [ ! -d ${XERCESCROOT}/lib ]; then
	echo " ? Attention: No XERCESC installation found for version ${XERCESC_VERSION}"
    else
	echo " > XERCES    version:  ${XERCESC_VERSION}"
    fi
    if [ ! -d ${MYSQLIB} ]; then
	echo " ? Attention: No MYSQL installation found."
    else
	echo " > MYSQL     version from:  ${MYSQLIB}"
    fi
    if [ ! -d $G4INSTALL/bin ]; then
	echo " ? Attention: No GEANT4 installation found for version ${G4VERSION}"
    else
	echo " > GEANT4   version: ${G4VERSION} "
    fi
    if [ ! -d $ROOTSYS/lib ]; then
	echo " ? Attention: No ROOT installation found for version ${ROOT_VERSION}"
    else
	echo " > ROOT     version: ${ROOT_VERSION} "
    fi
    if [ ! -d $MLIBRARY ]; then
	echo " ? Attention: No MLIBRAY installation found for version ${MLIBRARY_VERSION}"
    else
	echo " > MLIBRARY    version: ${MLIBRARY_VERSION} "
    fi
    if [ ! -d $GEMC ]; then
	echo " ? Attention: No GEMC installation found."
    elif [ ! -z $GEMC_VERSION ]; then
	echo " > GEMC     version: "$GEMC_VERSION
    else
	echo " > Custom GEMC : "$GEMC
    fi
    if [ ! -d $JANA_HOME ]; then
	echo " ? Attention: No JANA installation found."
    else
	echo " > JANA     version: "$JANA_VERSION
    fi
    if [ ! -d $JLAB_ROOT/$JLAB_VERSION/scons_bm/$SCONS_BM_VERSION ]; then
	echo " ? Attention: No Scons Script installation found."
    else
	echo " > S Build  version: "$SCONS_BM_VERSION
    fi
    if [ ! -d $EVIO/lib ]; then
	echo " ? Attention: No EVIO installation found."
    else
	echo " > EVIO     version: "$EVIO_VERSION
    fi
    if [ ! -d $CCDB_HOME/lib ]; then
	echo " ? Attention: No CCDB installation found."
    else
	echo " > CCDB     version: "$CCDB_VERSION
    fi
    if [ ! -d $BANKS/lib ]; then
	echo " ? Attention: No BANKS installation found."
    else
	echo " > Banks    version: "$BANKS_VERSION
    fi

fi
