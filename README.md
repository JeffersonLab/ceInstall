#  Installation

Make sure the [__requirements__](#requirements) for the libraries / environment installation 
listed at the bottom of this page are met.

The environment variable SIM_HOME must be set and point at an existing installation location (for example: `/opt/sim` )

```
cd $SIM_HOME
git clone https://github.com/jeffersonlab/ceInstall
```

To set up the enviromnent, run the following command:

`source  $SIM_HOME/ceInstall/setup.[c]sh install`

The (optional) argument `install` adds the installation scripts in your PATH. 

___

# QuickStart

`module avail`: shows available modules

`module load gemc/4.4.2`: loads gemc (clas12Tags) version 4.4.2, that uses geant4 10.6

`module load gemc/2.10`: loads gemc version 2.10, that uses geant4 10.7

`module load gemc3/3.0`: loads gemc3 version 1.0, that uses geant4 11

`module load sim/2.6`: loads standalone geant4 libraries, version 2.6 (geant4 11.0.3)

`module show <module>/<version>`: shows what is loaded by a module

`module test <module>/<version>`: test libraries installation (requires load first)


___


# Libraries installation

The installation scripts will be in your path if you sourced setup with the option `install`. They will test each package for its existence
and will install it if not found.  See also [installation tree](#installation-tree) 
and [advanced environment options](#advanced-environment-options).


- The __clas12 simulation software (gemc)__ can be installed using `install_gemc` script.This will also install the standalone geant4 libraries.
- The __gemc3 simulation software (gemc3)__ can be installed using `install_gemc3` script. This will also install the standalone geant4 libraries.
- __Standalone geant4 libraries__ can be installed using `install_sim` script.

___

### Gemc Installation

Run `install_gemc` with the option `<gemc_version>` to install 
the software needed to run clas12 simulations with gemc.

` <gemc_version>` is the gemc or clas12Tag version. 

- `4.4.2`: uses `geant4 10.6` and clas12Tags `4.4.2` 
- `5.1`: uses `geant4 10.6` and clas12Tags `5.1`
- `2.9`: uses `geant4 10.7`
- `2.10`: uses `geant4 10.7`

`install_gemc` will install, if not present already, the libraries needed for Geant4 simulations. 
In addition, in order to run clas12 simulations using gemc, the following software is installed:

- `evio`
- `hipo`
- `ccdb`
- `scons`
- `cmag`
- `mlibrary`
- `clas12Tags` code, geometry and gcards


___

### Gemc3 Installation

Run `install_gemc3` with the option `<gemc_version>` to install 
the software needed to run clas12 simulations with gemc.

` <gemc_version>` is the clas12Tag containing gemc and the clas12 geometry database.

- `1.0`: uses `geant4 11.0.3`` 

`install_gemc3` will install, if not present already, the libraries needed for Geant4 simulations. 
In addition the following software is installed:


- `scons`
- `glibrary`
- `gemc3` 
- `scig`: python interface to gemc3

___ 

### Standalone Geant4 Simulation Software Installation

Run `install_sim` with the option `<sim_version>` to install the libraries needed by geant4:

- `clhep`
- `xerces-c`
- `qt`
- `geant4 data` files
- `geant4`

` <sim_version>` can be:

- `2.4`: for `geant4` `10.6.02`
- `2.5`: for `geant4` `10.7.03`
- `2.6`: for `geant4` `11.0.3`

The script will first test for the existence of the libraries and 
will not install them if they are already present.

#### Compiling geant4 examples

The source code of the geant4 examples is in `$G4INSTALL/source/examples/`.
To compile one of the examples, create a build directory and run cmake using 
the  syntax below, where `$G4INSTALL/source/examples/basic/B3` is selected 
as an example, in a machine with 4 cores (`-j4`)

```
mkdir build ; cd build
cmake -DGeant4_DIR=$G4INSTALL/lib $G4INSTALL/source/examples/basic/B3
make -j4
```

---


# Installation Tree

Software based on compiled code (C++, fortran, etc) is organized in the `OSRELEASE` directory 
(macosx13-clang14, fedora34-gcc12, etc).
Software architecture independent (python, JAVA, etc) is organized in then `noarch` directory.

```
- SIM_HOME
     ⋮
     ∟ OSRELEASE
     ⋮  ⋮
     ⋮  ∟ SIM_SUB_DIR
     ⋮     ⋮
     ⋮     ⊢ 2.4
     ⋮     ⋮     ⊢ library
     ⋮     ⋮     ⋮    ⊢  lib_version
     ⋮     ⋮     ⊢ [..]        
     ⋮     ⋮         
     ⋮     ⊢ 2.5
     ⋮     ⋮     ⊢ library
     ⋮     ⋮     ⋮    ⊢ lib_version
     ⋮     ⋮     ⊢ [..]        
     ∟ noarch
        ⋮
        ⋮     ⊢ noarch library
        ⋮     ⋮    ⊢  lib_version
            
```

---

## Individual Packages  Installation

Use the following scripts to install the individual packages:

#### For geant4 simulations

- `install_clhep`       
- `install_xercesc`
- `copy_qt`
- `install_geant4_data`
- `install_geant4`

#### For gemc:

- `install_scons_bm`: scons build system
- `install_ccdb`: calibration database
- `install_evio`: event I/O data format        
- `install_hipo`: high performance I/O data format
- `install_cmag`: CLAS12 magnetic field library
- `install_mlibrary`: gemcw libraries

If you need to run clas12 simulations:

- `install_clas12Tags`: clas12 tags of gemc simulation software and geometry
- `install_fields`: clas12 magnetic field maps

Otherwise, if you need to run gemc w/o clas12:

- `install_g2`: gemc v2 simulation code 

#### For gemc3:

- `install_scons_bm`: scons build system
- `install_glibrary`: gemc3 libraries
- `install_g3`: gemc3 simulation software
- `install_scig`: python interface to gemc3

---

## Advanced environment options

The optional environment variable SIM_SUB_DIR_SUB_DIR can be used to specify the sub dir name 
under $SIM_HOME (see Installation Tree).  Its default is `sim`.

---

## Requirements

- `environment modules` > 4.5
- `gcc/clang` >= 8 (for c++17) 
- `cmake` >= 3.16
- `pyton` >= 3.6
- `qt5`
- `scons` >= 4.2
- `modules` >= 4.5 
- `zsh`
- `wget`

The following qt packages must be installed:

- Qt5Core
- Qt5Gui
- Qt5Widgets
- Qt5OpenGL
- Qt5PrintSupport

Unfortunately different Linux distro have different package names for these. 

### Optional:

- `root`: for gemc3 root plugin and gemc2 evio2root converter

Find below the commands to install these requirements. Please email any corrections to
[Maurizio](mailto:ungaro@jlab.org?subject=CeInstall Requirements Corrections).

___


### Mac installation of requirements (brew):

```brew install wget cmake mysql qt@5 scons freeglut modules sqlite```


#### Bash, zsh

To enable modules, the following lines should be added to your `.bashrc` or `.zshrc`:

```
brewDir=$(brew --prefix)
source $brewDir/opt/modules/init/zsh` or `. $brewDir/opt/modules/init/bash
```


#### Tcsh, csh

To enable modules, the following lines should be added to your `.bashrc` or `.zshrc`:

```
set brewDir=`brew --prefix`
source $brewDir/opt/modules/init/tcsh
```

Notice that this will enable the use of modules, but to use the `install_sim` or `install_gemc` scripts you need to add the lines to the `.zshrc`
script as described above.

#### Linux Fedora one-liner installation of requirements[^1]:

```yum install     cmake3 make gcc-c++ gfortran expat-devel         wget git environment-modules mysql-devel      zlib-devel libX11-devel mesa-libGLU-devel libXmu-devel  qt5-qttools-devel scons sqlite-devel```

To enable modules, the following line should be added to your `.bashrc` or `.zshrc`:

`. /usr/share/Modules/init/zsh` or `. /usr/share/Modules/init/bash`

#### Linux Ubuntu one-liner installation of requirements[^2]:

```apt-get install cmake  make g++     gfortran expat libexpat1-dev wget git environment-modules                     mysql-client libmysqlclient-dev scons libx11-dev libxext-dev libglu1-mesa-dev libxt-dev libxmu-dev libxrender-dev libxft-dev libafterimage-dev qtbase5-dev sqlite-devel```

To enable modules, the following line should be added to your `.bashrc` or `.zshrc`:

`. /usr/share/Modules/init/zsh` or `. /usr/share/Modules/init/bash`

#### Linux CentOS one-liner installation of requirements[^2]:

```yum install     cmake3 make gcc-c++ gfortran expat-devel         wget git environment-modules mysql-devel         zlib-devel libX11-devel mesa-libGLU-devel libXmu-devel mariadb-devel qt5-qttools-devel python3-scons sqlite-devel```

To enable modules, the following line should be added to your `.bashrc` or `.zshrc`:

`. /usr/share/Modules/init/zsh` or `. /usr/share/Modules/init/bash`

___


## Installation Troubleshooting

### Check which libraries are installed / not installed
`module test` can be used to check if the libraries are installed. For example:

- `module test sim/2.4`
- `module test gemc/5.1`
- `module test gemc3/1.0`

In the resulting log, `Y` means the library is installed, an `N` means it is not installed.

### Check compilation log files

The log errors of each package is saved in cmake_err.txt / build_err.txt  inside 
its installation path. For example, the build error logs for each package are:

- CLHEP: `$CLHEP_BASE_DIR/build_err.txt`
- XERCESC: `$XERCESCROOT/build_err.txt`
- GEANT4: `$G4INSTALL/build_err.txt`
- GEMC: `$GEMC/build_err.txt`




___

[^1]: tested on
 fedora 36

[^2]: not tested. 
 Please provide feedback if you have tested these commands.

---

For any questions, feedbacks or comments, please contact [Maurizio Ungaro](mailto:ungaro@jlab.org)
