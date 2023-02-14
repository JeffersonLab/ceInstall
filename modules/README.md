# Installation

Make sure the [__requirements__](#requirements) for the libraries / environment installation 
listed at the bottom of this page are met.

### Environment Installation

After choosing an installation location (from here on referred to as ```<ipath>```):

```
cd <ipath>
git clone https://github.com/jeffersonlab/ceInstall
```

To set up the modules (this could go in your `.zshrc`,  `.bashrc` or `.cshrc`):

`source  <ipath>/ceInstall/modules/setup.sh` or `source  <ipath>/modules/setup.csh`

[Advanced environment options](#advanced-environment-options) are shown at the bottom of this page.

### Libraries installation

Standalone geant4 libraries can be installed using the `install_sim` script, 
see [Geant4 Simulation Software Installation](#geant4-simulation-software-installation) below.

The clas12 simulation software (gemc) can be installed using the `install_gemc` script,
see [Gemc Installation](#gemc-installation) below. This will also install the standalone geant4 libraries.

#### Geant4 Simulation Software Installation

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

#### Gemc Installation

Run `install_gemc` with the option `<gemc_version>` to install 
the software needed to run clas12 simulations with gemc.

` <gemc_version>` is the clas12Tag containing gemc and the clas12 geometry database.

- `4.4.2`: uses `geant4 10.6` 
- `5.1`: uses `geant4 10.6` 

`install_gemc` will install, if not present already, the libraries needed for Geant4 simulations. 
In addition, in order to run clas12 simulations using gemc, the following software is installed:

- `evio`
- `hipo`
- `ccdb`
- `scons`
- `cmag`
- `mlibrary`
- `gemc`
- `clas12Tags` geometry and gcards



---

# Usage

## sim module

The uber module `sim` controls the subset of geant4 libraries to load. 
`module avail` will show the available versions of `sim` and `module load sim/version`
will load the corresponding version. 

Usage examples:

`module load sim/2.4`: loads sim module version 2.4

`module show sim/2.6`: shows what is loaded by sim/2.6

`module test sim/2.5`: shows which libraries are installed (requires load of sim/2.5)

## gemc module

The uber module `gemc` controls the subset of geant4 / clas12 libraries necessary 
to run clas12 simulations. 
`module avail` will show the available versions of `gemc` and `module load gemc/version`
will load the corresponding version. 

Usage examples:

`module load gemc/4.4.2`: loads gemc module version 4.4.2

`module show gemc/5.1`: shows what is loaded by gemc/5.1

`module switch gemc/5.1`: unload gemc / loads gemc module version 5.1

`module test gemc/5.1`: shows which libraries are installed (requires load of gemc/5.1)

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
- `install_mlibrary`: gemc linraries
- `install_clas12Tags`: clas12 tags of gemc simulation software and geometry

---

## Advanced environment options

Two optional environment variables (make sure to set them before the source command) 
control the top level directory structure of the installation:

- SIM_HOME: the base location of the libraries. 
Default is `<ipath>`.
- SIM_SUB_DIR_SUB_DIR: sub dir name under $SIM_HOME (see Installation Tree below). 
Default is `sim`.

After the source command, `module avail` will show the available modules and 
the libraries installation scripts below will be in your $PATH.

---

## Requirements

- `environment modules`
- `gcc/clang` > 8 (for c++17) 
- `cmake` > 3.16
- `pyton` > 3.6
- `qt5`
- `scons`
- `modules` > 4.5 

Find below the commands to install these requirements. Please email any corrections to
[Maurizio](mailto:ungaro@jlab.org?subject=CeInstall Requirements Corrections).


#### Mac installation of requirements:

```brew install wget cmake mysql qt@5 scons freeglut modules```

To enable modules, the following line should be added to your `.bashrc` or `.zshrc`:

`. $brewDir/opt/modules/init/zsh` or `. $brewDir/opt/modules/init/bash`

where 

`brewDir=$(brew --prefix)`

#### Linux Fedora line installation of requirements[^1]:

```yum install  environment-modules gcc-c++ expat-devel zlib-devel libX11-devel mesa-libGLU-devel libXmu-devel mariadb-devel qt5-qttools-devel scons```

#### Linux Ubuntu line installation of requirements[^2]:

```apt-get install environment-modules g++ mysql-client libmysqlclient-dev libexpat1-dev cmake scons libx11-dev libxext-dev libglu1-mesa-dev libxt-dev libxmu-dev libxrender-dev libxft-dev libafterimage-dev```

#### Linux CentOS line installation of requirements[^2]:

```yum install  environment-modules gcc-c++ expat-devel zlib-devel libX11-devel mesa-libGLU-devel libXmu-devel mariadb-devel qt5-qttools-devel python3-scons```


[^1]: tested on
 fedora 36

[^2]: not tested. 
 Please provide feedback if you have tested these commands.

---

For any questions, feedbacks or comments, please contact [Maurizio Ungaro](mailto:ungaro@jlab.org)
