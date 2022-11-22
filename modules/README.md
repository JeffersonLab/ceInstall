# User Setup

To set up the modules installed in `<path>`:

`source  <path>/setup.sh`

The following environment variables can be used to control the directory structure 
of the installation.

- PHYS_HOME: the base location of the libraries. Default is `$HOME`.
- PHYS_SUB_DIR: sub dir name of the repository. Default is `sim`.

### Installation Tree

```
- PHYS_ROOT
     ⋮
     ∟ OSRELEASE
        ⋮
        ∟ PHYS_SDIR
           ⋮
           ⊢ 2.4
           ⋮     ⊢ library
           ⋮     ⋮    ⊢  lib_version
           ⋮     ⋮    
           ⊢ 2.5
           ⋮     ⊢ library
           ⋮     ⋮    ⊢ lib_version
              
```

# Physlibs

The module `physlibs` provides specific, versioned subset of the avaliable libraries.



### - Version 2.4

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
