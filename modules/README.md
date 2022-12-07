# User Setup

To set up the modules:

`source  <path>/modules/setup.sh` or `source  <path>/modules/setup.csh`

where `<path>` is the path to ceInstall.

Two optional environment variables controls the directory structure 
of the installation:

- PHYS_HOME: the base location of the libraries. 
Default is `<path>`.
- PHYS_SUB_DIR: sub dir name of the repository. Default is `sim`.


# Usage

The super module `physlibs` controls the subset of libraries to load. 
`module avail` will show the available versions of `physlibs` and `module load`
will load the corresponding version. 

For example:

```
module load physlibs/2.6
```

To see the libraries version:

```
module show physlibs/2.6
```

To test the installation:

```
module test physlibs
```

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

# Requirements:

- `module` command
- gcc/clang > 8 (for c++17) 
- cmake > 3.2
- qt5 (not qt6)

Notice: on JLAB cue machines these requirements are satisfied in the `setup` scripts.


## Dependencies

Since the libraries depends on each other (for example geant4 on clhep and xercesc),
only the super modules are shown in `module avail`. This will ensure that the correct
version of the libraries are loaded. 