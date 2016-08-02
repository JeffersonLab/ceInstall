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
