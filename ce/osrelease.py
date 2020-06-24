#!/usr/bin/python3

import os
import platform

osreleasVersion = ''
compilerVersion = ''

# Darwin
if platform.system() == 'Darwin':
    # Getting macos version
    # platform.mac_ver() returns:
    # ('10.15.3', ('', '', ''), 'x86_64')
    version, dummy1, dummy2 = platform.mac_ver()
    major, minor, tooSmall = version.split('.')
    osreleasVersion = 'macosx' + major + '.' + minor

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
    clangVersions = output[0].split(' ')
    compilerVersion = 'clang' + clangVersions[3]

elif platform.system() == 'Linux':

# deprecated in 3.8:
#    flavor,version,variant = platform.linux_distribution()
#    osreleasVersion = flavor.replace('Linux','').strip() + version

    if os.path.exists('/etc/redhat-release'):
        with open('/etc/redhat-release') as f:
          columns = f.read().strip().split()
          osreleasVersion = columns[0]+columns[3]
    else:
      raise ValueError('Unsupported Linux Version')

    compilerVersion = os.popen('gcc --version').readlines()
    compilerVersion = 'gcc'+compilerVersion[0].split()[2]

else:
    raise ValueError(('Unsupported platform: '+platform.system()))

osname = platform.system() + '_' + osreleasVersion
osname += '-' + compilerVersion

print (osname)

