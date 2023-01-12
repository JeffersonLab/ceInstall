# Installation

Make sure the requirements for the libraries / environment installation 
listed at the bottom of this page are met.

### Environment Installation

After choosing an installation location (from here on referred to as ```<ipath>```):

```
cd <ipath>
git clone https://github.com/jeffersonlab/ceInstall
```

To set up the modules (this could go in your `.zshrc`,  `.bashrc` or `.cshrc`):

`source  <ipath>/modules/setup.sh` or `source  <ipath>/modules/setup.csh`

Two optional environment variables (make sure to set them before the source command) 
control the top level directory structure of the installation:

- PHYS_HOME: the base location of the libraries. 
Default is `<ipath>`.
- PHYS_SUB_DIR: sub dir name of the repository. Default is `sim`.

After the source command, `module avail` will show the available modules. 
The installation scripts below are included in your $PATH.

### Geant4 Software Installation

Run `install_geant4_base` with the option `<physlibs_version>` to install the libraries needed by geant4:

- `clhep`
- `xerces-c`
- `qt`
- `geant4 data` files
- `geant4`

` <physlibs_version>` can be:

- `2.4`: for `geant4` `10.6.02`
- `2.5`: for `geant4` `10.7.03`
- `2.6`: for `geant4` `11.0.3`

The script will first test for the existence of the libraries and 
will not install them if they are already present.

### Clas12Tags Installation

Run `install_all_clas12` with the option `<physlibs_version>` to install, in addition to the above libraries, 
the software needed to run clas12 simulations. 

` <physlibs_version>` can be:

- `2.4`: `clas12Tags` `4.4.2` and `5.1`

The software installed is:

- `evio`
- `hipo`
- `ccdb`
- `scons`
- `cmag`
- `mlibrary`

The script will first test for the existence of the libraries and 
will not install them if they are already present.

### Individual Packages  Installation

Use the following scripts to install the individual packages:

#### For geant4:

- `install_clhep`       
- `install_xercesc`
- `copy_qt`
- `install_geant4_data`
- `install_geant4`

#### For clas12:

- `install_scons_bm`: scons build system
- `install_ccdb`: calibration database
- `install_evio`: event I/O data format        
- `install_hipo`: high performance I/O data format
- `install_cmag`: CLAS12 magnetic field library
- `install_mlibrary`: gemc linraries
- `install_clas12Tags`: clas12 tags of gemc simulation software and geometry


# Usage

The uber module `physlibs` controls the subset of libraries to load. 
`module avail` will show the available versions of `physlibs` and `module load`
will load the corresponding version. 

For example:

```
module load physlibs/2.4
```

To see the libraries version:

```
module show physlibs/2.4
```

To test the installation:

```
module test physlibs/2.4
```

## clas12Tags uber module

Each physlibs version come with one or more clas12Tags. The command `module switch` can 
be used to switch from one to another. For example

```
module switch clas12Tags/4.4.2
```

The list of clas12Tags installed are:

- `physlibs/2.4`: `clas12Tags/5.1` (default), `clas12Tags/4.4.2`


## Installation Tree


Software based on compiled code (C++, fortran, etc) is organized under the `OSRELEASE` directory.
Software architecture independent (python, JAVA, etc) is organized under `noarch` directory.

```
- PHYS_HOME
     ⋮
     ∟ OSRELEASE
     ⋮  ⋮
     ⋮  ∟ PHYS_SUB_DIR
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



## Dependencies

Only the uber modules are shown in `module avail`. This ensures that the correct
version of the libraries are loaded along with their dependencies. 

### Requirements:

- `environment modules`
- `gcc/clang` > 8 (for c++17) 
- `cmake` > 3.16
- `qt5`
- `scons`

Find below the commands to install these requirements. Please email any corrections to
[Maurizio](mailto:ungaro@jlab.org?subject=CeInstall Requirements Corrections).


#### Mac installation of requirements:

```brew install wget cmake mysql qt@5 scons freeglut modules```

#### Linux Fedora line installation of requirements:

```yum install  environment-modules gcc-c++ expat-devel zlib-devel libx11-devel mesa-libGLU-devel libXmu-devel mariadb-devel qt5-qttools-devel scons```

#### Linux Ubuntu line installation of requirements:

```apt-get install environment-modules g++ mysql-client libmysqlclient-dev libexpat1-dev cmake scons libx11-dev libxext-dev libglu1-mesa-dev libxt-dev libxmu-dev libxrender-dev libxft-dev libafterimage-dev```
