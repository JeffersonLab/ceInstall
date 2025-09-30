# Quickstart: @JLAB

```bash
module use /scigroup/cvmfs/geant4/modules
module  load gemc/5.10
```

Note: the above commands are not needed if load the `clas12` module.

# Quickstart: on a supported OS, with CVMFS

We distribute releases of Geant4 on CVMFS for the following platforms:

- Linux: Fedora 36, AlmaLinux 9, Ubuntu24
- MacOS: macOS 14.5 (Sonoma)

If you have access to a CVMFS client and your OS is supported,
you can load Geant4 with the following commands:

```bash
module use /cvmfs/oasis.opensciencegrid.org/jlab/geant4/modules 
module  load gemc/5.10
```

Note: the above commands are not needed if load the `clas12` module.

___

## Modules Utilities

`module avail gemc`: shows available gemc modules

`module load geant4/11.2.2`: loads standalone geant4 libraries 11.2.2

`module switch gemc/dev`: switch to gemc (clas12Tags) dev version

`module show <module>/<version>`: shows what is loaded by a module


---


# Local installation

To download and compile Geant4 and/or Gemc on your local machine, follow these instructions.

Below we''ll use `/opt/software` as the installation location, but it can be any directory of your choice.
Make sure you have write permissions on the directory you choose. You can always change permissions like this:
`chown -R $USER /opt/software`

### Clone the repo:

Do this only once. If you have already cloned the repo, skip this step.

```
cd /opt/software
git clone https://github.com/jeffersonlab/ceInstall
```

### Setup the environment:

We suggest to add this line to your shell login file (`.bashrc`, `.zshrc`, etc):

```
module use /opt/software/ceInstall/modules
```

The command `module load gemc/<version>` will load the environment variables needed for gemc.
We suggest to NOT add this line to your shell login file but to load gemc manually when needed. For example:

```
module load gemc/5.11
```



### Compilation

Make sure the [__requirements__](#requirements) for the libraries / environment installation
listed at the bottom of this page are met.

After the steps above:  `module load sim_system` will load the installation scripts location.

- `install_gemc 5.11` will install clhep, geant4, hipo, ccdb, cmag and gemc. Notice that their versions 
   are fixed to the ones compatible with the gemc version chosen.
- `install_geant4 11.3.2` will install geant4 only. 

Both installation scripts will check for existing installations and will not overwrite them. 

`moule avail geant4` or `module avail gemc` will show the versions available for installation.


___

### Compiling geant4 examples

The source code of the geant4 examples is in `$G4INSTALL/source/examples/`.
To compile one of the examples, create a build directory and run cmake using
the syntax below, where `$G4INSTALL/source/examples/basic/B3` is selected
as an example, in a machine with 4 cores (`-j4`)

```
mkdir build ; cd build
cmake -DGeant4_DIR=$G4INSTALL/lib $G4INSTALL/source/examples/basic/B3
make -j4
```

---

# Installation Tree

**Software based on compiled code** (C++, fortran, etc) is organized in the `SIM_OSRELEASE`
directory. `SIM_OSRELEASE`, set by the modules, is a string is composed by the OS name and the compiler major version.
For example: `macosx14-clang15`, `fedora34-gcc12`.

**Architecture-independent stuff** (python, JAVA, etc) is organized in then `noarch` directory.

```
- /opt/software
     ⋮
     ∟ OSRELEASE (for example: macosx14-clang15)
     ⋮     ⊢ package 1
     ⋮     ⋮    ⊢  package1_version
     ⋮     ⋮    ⋮    ⊢  libraries and includes  
     ⋮     ⊢ package 2
     ⋮     ⋮    ⊢  package2_version
     ⋮     ⋮    ⋮    ⊢  libraries and includes  
     ⋮     ⊢ package 1
     ⋮     ⋮    ⊢  package1_version
     ⋮     ⋮    ⋮    ⊢  libraries and includes  
     ⋮     ⊢ package 2
     ⋮     ⋮    ⊢  package2_version
     ⋮     ⋮    ⋮    ⊢  libraries and includes  
     ∟ noarch
        ⋮
        ⋮     ⊢ noarch library 1
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
- `gnu tar`
- `pkg-config`
- `meson and ninja` (for hipo installation)

The following qt packages must be installed:

- Qt5Core
- Qt5Gui
- Qt5Widgets
- Qt5OpenGL
- Qt5PrintSupport


### Optional:

- `root`: for gemc3 root plugin

Find below the commands to install these requirements. Please email any corrections to
[Maurizio](mailto:ungaro@jlab.org?subject=CeInstall Requirements Corrections).

___

## Mac installation of requirements (brew):

```brew install gnu-tar wget cmake mysql qt@5 scons freeglut modules sqlite meson ninja ```

Note: As of 8/2024: the mysql_native_password authentication plugin has been removed in mysql v9 and CCDB will not work w/o it.
So, for now, we need to install mysql v8.4:

```
brew install mysql-client@8.4
export PATH="/opt/homebrew/opt/mysql-client@8.4/bin:$PATH"
export LD_LIBRARY_PATH="/opt/homebrew/opt/mysql-client@8.4/lib:$LD_LIBRARY_PATH"
```

#### Enable modules in Bash, zsh

```
brewDir=$(brew --prefix)
source $brewDir/opt/modules/init/zsh` or `. $brewDir/opt/modules/init/bash
```

#### Enable modules in Tcsh, csh

```
set brewDir=`brew --prefix`
source $brewDir/opt/modules/init/tcsh
```

---

In order to avoid re-typing them every time, the lines could be added to the files `.tcshrc` or `.cshrc`
in your home directory, so they will be executed every time you open a new terminal.
You can create the file if it does not exist.

---


## Linux Fedora line one-liner installation of requirements[^1]:

```yum install     cmake3 make gcc-c++ gfortran expat-devel         wget git environment-modules mysql-devel      zlib-devel libX11-devel mesa-libGLU-devel libXmu-devel  qt5-qttools-devel scons sqlite-devel```

To enable modules, the following line should be added to your `.bashrc` or `.zshrc`:

`. /usr/share/Modules/init/zsh` or `. /usr/share/Modules/init/bash`

## Linux Ubuntu one-liner installation of requirements[^2]:

```apt-get install cmake  make g++ gfortran expat libexpat1-dev libpython3-dev scons libglu1-mesa-dev   libx11-dev   libxpm-dev   libxft-dev   libxt-dev   libxmu-dev   libxrender-dev bzip2 wget curl nano git bash tcsh zsh hostname gedit environment-modules psmisc procps mailcap net-tools libcpandb-perl xterm qtbase5-dev libqt5widgets5 libqt5opengl5-dev libqt5printsupport5```

To enable modules, the following line should be added to your `.bashrc` or `.zshrc`:

`. /usr/share/Modules/init/zsh` or `. /usr/share/Modules/init/bash`

## compatibility issues:

- mlibrary 1.7 is associated with geant4 10.6.2 and clhep 2.4.1.3
- mlibrary 1.8 is associated with geant4 10.7.4 and clhep 2.4.4.2
- gemc 5.9 is deprecated because of the above reason (cannot mix different mlibrary and geant4 versions)

___

[^1]: tested on fedora36, almalinux9

[^2]: tested on ubuntu22

---

For any questions, feedbacks or comments, please contact [Maurizio Ungaro](mailto:ungaro@jlab.org)
