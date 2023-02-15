#!/usr/bin/python3

import os
import platform

thisPlatform = platform.system()
osreleasVersion = ''
compilerVersion = ''

# Darwin: clang
if thisPlatform == 'Darwin':
    # Getting macos version
    # platform.mac_ver() returns:
    # ('10.15.3', ('', '', ''), 'x86_64')
    version, dummy1, dummy2 = platform.mac_ver()
    # setting the maxsplit parameter to 1, will return a list with 2 elements
    major, minor = version.split('.', 1)
    osreleasVersion = 'macosx' + major

    # Getting clang version
    # This assumes a return from clang --version first line like this one:
    # Apple clang version 14.0.0 (clang-1400.0.29.102)
    clangVersion = os.popen('clang --version').readlines()[0].split()[3]

    compilerVersion = 'clang' + clangVersion.split('.')[0]

# Linux: gcc
elif thisPlatform == 'Linux':

    # fedora line
    if os.path.exists('/etc/redhat-release'):
        with open('/etc/redhat-release') as f:
            columns = f.read().strip().split()
            if columns[0] == 'Fedora':
                # Lowercase first character
                osreleasVersion = columns[0].lower() + columns[2].split('.')[0]
            elif columns[0] == 'Red' and columns[1] == 'Hat' and columns[2] == 'Enterprise':
                osreleasVersion = 'RedHat' + columns[6].split('.')[0]
            else:
                osreleasVersion = columns[0].lower() + columns[3].split('.')[0]
    # ubuntu line
    elif os.path.exists('/etc/os-release'):
        with open('/etc/os-release') as f:
            columns = f.read().strip().split()
            idList = [s for s in columns if "ID=" in s]
            verList = [s for s in columns if "VERSION_ID=" in s]
            ids = idList[0].split("=")
            vers = verList[0].split('="')[1].split('.')[0]
            osreleasVersion = 'ubuntu' + vers
    else:
        raise ValueError('Unsupported Linux Version: no /etc/redhat-release or /etc/os-release')

    # Getting gcc version
    # This assumes a return from gcc --version first line like this one:
    # gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-44)
    gccVersion = os.popen('gcc --version').readlines()[0].split()[2]

    compilerVersion = 'gcc' + gccVersion.split('.')[0]

else:
    raise ValueError(('Unsupported platform: ' + thisPlatform))

osname = osreleasVersion
osname += '-' + compilerVersion

print(osname)
