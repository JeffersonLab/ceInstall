# Installation

### Requirements:

- `module` command
- `gcc/clang` > 8 (for c++17) 
- `cmake` > 3.2
- `qt5` (not qt6)


### Environment Installation

After choosing an installation location (from here on referred to as ```<path>```):

```
cd <path>
git clone https://github.com/jeffersonlab/ceInstall
```

To set up the modules:

`source  <path>/modules/setup.sh` or `source  <path>/modules/setup.csh`

Two optional environment variables (make sure to set them before the source command) 
control the top level directory structure of the installation:

- PHYS_HOME: the base location of the libraries. 
Default is `<path>`.
- PHYS_SUB_DIR: sub dir name of the repository. Default is `sim`.

### Geant4 Software Installation

Run ```install_clas12Tags``` to install the libraries needed by geant4:

- clhep
- xerces-c
- qt
- geant4 data files
- geant4


### Clas12Tags Installation

Run ```install_all_clas12 <version>``` to install, in addition to the above libraries, 
the software needed to run clas12 simulations. <version> can be:

- 2.4 (installs clas12Tags 4.4.2 and 5.1)

The software installed is:

- evio
- hipo
- ccdb
- scons
- cmag
- mlibrary



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

- physlibs/2.4: clas12Tags/5.1 (default), clas12Tags/4.4.2


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