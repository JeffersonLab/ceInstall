#!/bin/bash

echo hello world

export ROOTSYS=$(root-config --prefix)
export ROOT_LIB=$(root-config --libdir)
export ROOT_INC=$(root-config --incdir)
export ROOT_BIN=$(root-config --bindir)