#!/usr/bin/python3


import os
import platform



sysname, nodename, release, version, machine = os.uname()

osreleasVersion = ""
compilerVersion = ""

# Darwin
if sysname == 'Darwin':
    # Getting macos version
    # platform.mac_ver() returns:
    # ('10.15.3', ('', '', ''), 'x86_64')
    version, dummy1, dummy2 = platform.mac_ver()
    major, minor, tooSmall = version.split(".")
    osreleasVersion = "macosx" + major + "." + minor
   
    # Getting clang version
    # This assumes a return from clang like this:
    #
    # Apple clang version 11.0.0 (clang-1100.0.33.17)
    # Target: x86_64-apple-darwin19.3.0
    # Thread model: posix
    # InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin

    clangVersion = 'clang --version'
    stream = os.popen(clangVersion)
    output = stream.readlines()
    clangVersions = output[0].split(" ")
    compilerVersion = "clang" + clangVersions[3]


osname = sysname + "_" + osreleasVersion + "_" + compilerVersion

print (osname)

