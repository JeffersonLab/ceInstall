# User Setup

To set up the modules:

`source  <path>/modules/setup.sh`

where `<path>` is the path to ceInstall.

Two optional environment variables controls the directory structure 
of the installation:

- PHYS_HOME: the base location of the libraries. 
Default is `<path>`.
- PHYS_SUB_DIR: sub dir name of the repository. Default is `sim`.

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

- gcc/clang > 8 (for c++17) 
- cmake > 3.2
- qt5 (not qt6)

# Physlibs

The super module `physlibs` collects the libraries in versioned subsets. 
`module avail` will show the available versions of `physlibs` and `module load`
will load the corresponding version. 

For example:

```
module load physlibs/2.6
```

To see the libraries version:

```
module  show physlibs/2.6
```

TODO: make this output from a python script

### External Libraries

| PHYS_VERSION | clhep   | xercesc | qt     | geant4      | root    | 
|--------------|---------|---------|--------|-------------|---------|
| **2.4**      | 2.4.1.3 | 3.2.3   | system | 4.10.06.p02 | 6.20.04 |
| **2.5**      | 2.4.4.2 | 3.2.3   | system | 4.10.07.p04 | 6.24.06 |
| **2.6**      | 2.4.1.3 | 3.2.3   | system | 11.0.3      | 6.26.06 |

### JLAB Libraries

| PHYS_VERSION | scons_bm | ccdb    | evio   | hipo | mlibrary | cmag | glibrary |
|--------------|----------|---------|--------|------|----------|------|----------|
| **2.4**      | 1.10     | 1.07.00 | 5.2    | 1.8  | 1.4      | 1.1  | 1.0      |
| **2.5**      | 1.10     | 1.07.00 | 5.2    | 1.8  | 1.5      | 1.1  | 1.0      |
| **2.6**      | 1.11     | 1.07.00 | 5.2    | 1.8  | 1.6      | 1.1  | 1.0      |

### JLAB Software

| PHYS_VERSION  | clas12Tags | clas12 systems | gemc2 | gemc3 | 
|---------------|------------|----------------|-------|-------|
| **2.4**       | 4.4.2, 5.1 | 1.0            | 2.8   | 1.0   |
| **2.5**       | 5.2        | 1.0            | 2.9   | 1.0   |
| **2.6**       | na         | 1.0            | 2.10  | 1.0   |


## Dependencies

Since the libraries depends on each other (for example geant4 on clhep and xercesc),
only the super modules are shown in `module avail`. This will ensure that the correct
version of the libraries are loaded. 