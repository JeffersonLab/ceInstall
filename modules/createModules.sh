#!/bin/zsh

# Purpose: creates the modules directory structure for 
#
# Arguments: exactly one argument, the name of the new library

if [ "$#" -ne 1 ]; then
	echo " "       >&2
	echo " Usage:" >&2
	echo " "       >&2
	echo  " $0 libraryName"  >&2
	echo " "       >&2
	exit 1
fi


library=$1
echo " "
echo " Creating glibrary" $library
mkdir -p $library


# template files
echo " "
for f in SConstruct SConscript example.cc settings.xcconfig README.md
do
	echo " "copying $f
	cp templateGLibrary/$f $library/
done

echo " "
for f in changelog todo
do
	echo " "touching $f
	rm -f $library/$f
	touch $library/$f
done

# header
cheader=$(echo $library"_h" | tr "[:lower:]" "[:upper:]")
echo " "
echo " "Creating $library header using $cheader

rm -f $library/$library".h" ; touch $library/$library".h"

echo "#ifndef " $cheader      >> $library/$library".h"
echo "#define " $cheader " 1" >> $library/$library".h"
echo                          >> $library/$library".h"
echo                          >> $library/$library".h"
echo "class $library"         >> $library/$library".h"
echo "{"                      >> $library/$library".h"
echo                          >> $library/$library".h"
echo                          >> $library/$library".h"
echo  "};"                    >> $library/$library".h"
echo                          >> $library/$library".h"
echo                          >> $library/$library".h"
echo "#endif"                 >> $library/$library".h"

# doxy main file
rm -f $library/"doxy.h" ;  touch $library/"doxy.h"
echo "#ifndef " $cheader"_DOXY"   >> $library/"doxy.h"
echo "#define " $cheader"_DOXY 1" >> $library/"doxy.h"
cat doxy.h                        >> $library/"doxy.h"
echo "#endif"                     >> $library/"doxy.h"

# convention file
rm -f $library/"conventions.h" ;  touch $library/"conventions.h"
echo "#ifndef " $cheader"_CONVENTIONS"       >> $library/"conventions.h"
echo "#define " $cheader"_CONVENTIONS 1"     >> $library/"conventions.h"
cat doxy.h                                   >> $library/"conventions.h"
echo "#endif"                                >> $library/"conventions.h"



# c++ code
echo " "
echo " "Creating $library cc source
rm -f $library/$library".cc"; touch $library/$library".cc"

echo "// $library "             >> $library/$library".cc"
echo '// doxygen'               >> $library/$library".cc"
echo '#include doxy.h"'         >> $library/$library".cc"
echo ''                         >> $library/$library".cc"
echo '// conventions'           >> $library/$library".cc"
echo '#include conventions.h"'  >> $library/$library".cc"
echo ''                         >> $library/$library".cc"
echo '#include "'$library'.h"'  >> $library/$library".cc"

# changing the name in the template files
echo " "
echo " "Changing template name to $library in:
echo " "
for f in SConstruct SConscript example.cc README.md
do
	echo " "$f
	sed -i '' s/templateGLibrary/$library/g     $library/$f
done

./createDoxyFile $library

echo " "
