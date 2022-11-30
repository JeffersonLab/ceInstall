# User Setup

To set up the modules:

`source  <path>/modules/setup.sh`

where `<path>` is the path to ceInstall.

Two optional environment variables controls the directory structure 
of the installation:

- PHYS_HOME: the base location of the libraries. 
Default is `<path>`.
- PHYS_SUB_DIR: sub dir name of the repository. Default is `sim`.

### Installation Tree

```
- PHYS_HOME
     ⋮
     ∟ OSRELEASE
        ⋮
        ∟ PHYS_SUB_DIR
           ⋮
           ⊢ 2.4
           ⋮     ⊢ library
           ⋮     ⋮    ⊢  lib_version
           ⋮     ⊢ [..]        
           ⋮         
           ⊢ 2.5
           ⋮     ⊢ library
           ⋮     ⋮    ⊢ lib_version
           ⋮     ⊢ [..]        
              
```

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
module  whatis physlibs
```

### - Physlibs 2.6

- clhep:     2.4.1.3
- xercesc:   3.2.3
- qt:        system
- geant4:    4.10.06.p02
- g4data:    10.6.2
- scons_bm:  1.10
- ccdb:      1.07.00
- evio:      5.1
- hipo:      1.8
- mlibrary:  1.4
- gemc:      2.9
- root:      6.20.04

### - Physlibs 2.5

- clhep:     2.4.1.3
- xercesc:   3.2.3
- qt:        system
- geant4:    4.10.06.p02
- g4data:    10.6.2
- scons_bm:  1.10
- ccdb:      1.07.00
- evio:      5.1
- hipo:      1.8
- mlibrary:  1.4
- gemc:      2.9
- root:      6.20.04

### - Physlibs 2.4

- clhep:     2.4.1.3
- xercesc:   3.2.3
- qt:        system
- geant4:    4.10.06.p02
- g4data:    10.6.2
- scons_bm:  1.10
- ccdb:      1.07.00
- evio:      5.1
- hipo:      1.8
- mlibrary:  1.4
- gemc:      2.9
- root:      6.20.04


## Dependencies

Since the libraries depends on each other (for example geant4 on clhep and xercesc),
only the super modules are shown in `module avail`. This will ensure that the correct
version of the libraries are loaded.