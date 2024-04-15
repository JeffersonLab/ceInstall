#  QuickStart


The environment variable SIM_HOME must be set and point at an existing installation location (for example: `/opt/sim` )

#### First time only: clone ceInstall
```
cd $SIM_HOME
git clone https://github.com/jeffersonlab/ceInstall
```


#### To set up the environment, run the following command:
```
export SIM_HOME=<your_installation_path>
module use "${SIM_HOME}"/ceInstall/modulefiles
```

___

## Modules Utilities

`module avail`: shows available modules

`module load sim/1.2`: loads standalone geant4 libraries, version 1.2 (geant4 11.2.1)

`module load gemc/5.6`: loads gemc (clas12Tags) version 5.6, that uses geant4 10.7.4

`module load gemc/2.12`: loads gemc version 2.10, that uses geant4 10.7.4

`module load gemc3/1.1`: loads gemc3 version 1.1, that uses geant4 11.2.1

`module show <module>/<version>`: shows what is loaded by a module



___


# Libraries installation

Make sure the [__requirements__](#requirements) for the libraries / environment installation 
listed at the bottom of this page are met.

The installation scripts below are found in `"${SIM_HOME}"/ceInstall/install`. 

### Standalone Geant4 Simulation Software Installation

Run `install_sim`  to install the libraries needed by geant4.
Example:

```install_sim 1.2```

The argument, that specifies the versions of geant4 and the dependencies, 
can be:

- `1.0`: for `geant4` `10.6.2`
- `1.1`: for `geant4` `10.7.4`
- `1.2`: for `geant4` `11.2.1`

The script will test for the existence of the libraries and 
will not install what is already present.




___

### Gemc Installation

Run `install_gemc` with the option `<gemc_version>` to install 
the software needed to run clas12 simulations with gemc.

` <gemc_version>` is the gemc or clas12Tag version. 

- `4.4.2`: uses `geant4 10.6.2` and clas12Tags `4.4.2` 
- `5.7`: uses `geant4 10.6.2` and clas12Tags `5.7`
- `5.8`: uses `geant4 10.7.4` and clas12Tags `5.8`
- `2.12`: uses `geant4 10.7.4` and gemc `2.12`

`install_gemc` will install, if not present already, the libraries needed for Geant4 simulations. 


___

### Gemc3 Installation

Run `install_gemc3` with the option `<gemc_version>` to install 
the software needed to run clas12 simulations with gemc.

` <gemc_version>` is the clas12Tag containing gemc and the clas12 geometry database.

- `1.1`: uses `geant4 11.2`` 

`install_gemc3` will install, if not present already, the libraries needed for Geant4 simulations. 

___ 



### Compiling geant4 examples

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

**Software based on compiled code** (C++, fortran, etc) is organized in the `SIM_OSRELEASE` 
directory. `SIM_OSRELEASE`, set by the modules, is a  string is composed by the OS name and the compiler major version. 
For example: `macosx14-clang15`, `fedora34-gcc12`.

**Architecture-independent stuff** (python, JAVA, etc) is organized in then `noarch` directory.

```
- SIM_HOME
     ⋮
     ∟ OSRELEASE
     ⋮     ∟ 1.0
     ⋮     ⋮     ⊢ package 1
     ⋮     ⋮     ⋮    ⊢  package1_version
     ⋮     ⋮     ⋮    ⋮    ⊢  libraries and includes  
     ⋮     ⋮     ⊢ package 2
     ⋮     ⋮     ⋮    ⊢  package2_version
     ⋮    ⋮     ⋮    ⋮    ⊢  libraries and includes  
     ⋮     ⊢ 1.1
     ⋮     ⋮     ⊢ package 1
     ⋮     ⋮     ⋮    ⊢  package1_version
     ⋮     ⋮     ⋮    ⋮    ⊢  libraries and includes  
     ⋮     ⋮     ⊢ package 2
     ⋮     ⋮     ⋮    ⊢  package2_version
     ⋮     ⋮     ⋮    ⋮    ⊢  libraries and includes  
     ∟ noarch
        ⋮
        ⋮     ⊢ noarch library
        ⋮     ⋮    ⊢  lib_version
            
```

---




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


## Mac installation of requirements (brew):

```brew install wget cmake mysql qt@5 scons freeglut modules sqlite```


#### Bash, zsh

To enable modules, the following lines should be added to your `.bashrc` or `.zshrc`:

```
brewDir=$(brew --prefix)
source $brewDir/opt/modules/init/zsh` or `. $brewDir/opt/modules/init/bash
```


#### Tcsh, csh

To enable modules, the following lines should be added to your `.tcshrc` or `.cshrc`:

```
set brewDir=`brew --prefix`
source $brewDir/opt/modules/init/tcsh
```

Notice that this will enable the use of modules, but to use the `install_sim` or `install_gemc` scripts you need to add the lines to the `.zshrc`
script as described above.

## Linux Fedora line one-liner installation of requirements[^1]:

```yum install     cmake3 make gcc-c++ gfortran expat-devel         wget git environment-modules mysql-devel      zlib-devel libX11-devel mesa-libGLU-devel libXmu-devel  qt5-qttools-devel scons sqlite-devel```

To enable modules, the following line should be added to your `.bashrc` or `.zshrc`:

`. /usr/share/Modules/init/zsh` or `. /usr/share/Modules/init/bash`

## Linux Ubuntu one-liner installation of requirements[^2]:

```apt-get install cmake  make g++     gfortran expat libexpat1-dev libpython3-dev scons libglu1-mesa-dev   libx11-dev   libxpm-dev   libxft-dev   libxt-dev   libxmu-dev   libxrender-dev bzip2 wget curl nano git bash tcsh zsh hostname gedit environment-modules psmisc procps mailcap net-tools libcpandb-perl xterm qtbase5-dev libqt5widgets5 libqt5opengl5-dev libqt5printsupport5```

To enable modules, the following line should be added to your `.bashrc` or `.zshrc`:

`. /usr/share/Modules/init/zsh` or `. /usr/share/Modules/init/bash`



___

[^1]: tested on fedora36, almalinux9

[^2]: tested on ubuntu22

---

For any questions, feedbacks or comments, please contact [Maurizio Ungaro](mailto:ungaro@jlab.org)
