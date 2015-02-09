#!/usr/bin/env perl

# Generate a string specific to the current platform for
# purposes of separating and distributing binaries.
#
# The output will have the form:
#
#  OS_flavor##-processor-gcc##
#
# Some examples:
#
# Linux_RHEL5-i686-gcc4.1.2
# Linux_RHEL4-i686-gcc3.4.3
# Linux_FC6-i686-gcc4.1.1
# Linux_Fedora9-i686-gcc4.3.0
# Darwin_macosx10.4-i386-gcc4.0.1
# Linux_Ubuntu6.06-unknown-gcc4.0.3
#
# Errors are printed to stderr and some
# attempt is made to return a reasonable
# string for the system such that the script
# will never fail.
#

# This first section sets the uname and release variables
# which hold the "OS" and "_flavor##" parts of the string.
$uname = `uname`;
chomp $uname;

### Linux Flavors
if ($uname eq 'Linux')
{
  ### Fedora
  if (-e '/etc/fedora-release')
  {
    $release_string = `cat /etc/fedora-release`;
    if    ($release_string =~ /^Fedora release 24.*/)     { $release = '_Fedora24'; }
	elsif ($release_string =~ /^Fedora release 23.*/)     { $release = '_Fedora23'; }
	elsif ($release_string =~ /^Fedora release 22.*/)     { $release = '_Fedora22'; }
	elsif ($release_string =~ /^Fedora release 21.*/)     { $release = '_Fedora21'; }
    elsif ($release_string =~ /^Fedora release 20.*/)     { $release = '_Fedora20'; }
    elsif ($release_string =~ /^Fedora release 19.*/)     { $release = '_Fedora19'; }
    elsif ($release_string =~ /^Fedora release 18.*/)     { $release = '_Fedora18'; }
    elsif ($release_string =~ /^Fedora release 17.*/)     { $release = '_Fedora17'; }
    elsif ($release_string =~ /^Fedora release 16.*/)     { $release = '_Fedora16'; }
    elsif ($release_string =~ /^Fedora release 15.*/)     { $release = '_Fedora15'; }
    elsif ($release_string =~ /^Fedora release 14.*/)     { $release = '_Fedora14'; }
    elsif ($release_string =~ /^Fedora release 13.*/)     { $release = '_Fedora13'; }
    elsif ($release_string =~ /^Fedora release 12.*/)     { $release = '_Fedora12'; }
    elsif ($release_string =~ /^Fedora release 11.*/)     { $release = '_Fedora11'; }
    elsif ($release_string =~ /^Fedora release 10.*/)     { $release = '_Fedora10'; }
    elsif ($release_string =~ /^Fedora release 9.*/)      { $release = '_Fedora9';  }
    elsif ($release_string =~ /^Fedora release 8.*/)      { $release = '_Fedora8';  }
    elsif ($release_string =~ /^Fedora release 7.*/)      { $release = '_Fedora7';  }
    elsif ($release_string =~ /^Fedora Core release 6.*/) { $release = '_FC6';      }
    else
    {
      print STDERR "unrecognized Fedora release\n";
      $release = '_Fedora';
    }
  }
  ### Red-Hat, SL, CentOS
  elsif (-e '/etc/redhat-release')
  {
    $release_string = `cat /etc/redhat-release`;
    if    ($release_string =~ /^Red Hat Enterprise Linux WS release 3.*/)     { $release = '_RHEL3';       }
    elsif ($release_string =~ /^Red Hat Enterprise Linux WS release 4.*/)     { $release = '_RHEL4';       }
    elsif ($release_string =~ /^Red Hat Enterprise Linux Client release 5.*/) { $release = '_RHEL5';       }
    elsif ($release_string =~ /^Red Hat Enterprise Linux Server release 5.*/) { $release = '_RHEL5';       }
    elsif ($release_string =~ /^Red Hat Enterprise Linux Workstation release 6.*/) { $release = '_RHEL6';       }
    elsif ($release_string =~ /^Scientific Linux SL release 4.*/)             { $release = '_Scientific4'; }
    elsif ($release_string =~ /^Scientific Linux SL release 5.*/)             { $release = '_Scientific5'; }
    elsif ($release_string =~ /^Scientific Linux SL release 6.*/)             { $release = '_Scientific6'; }
    elsif ($release_string =~ /^Scientific Linux release 5.*/)                { $release = '_Scientific5'; }
    elsif ($release_string =~ /^Scientific Linux release 6.*/)                { $release = '_Scientific6'; }
    elsif ($release_string =~ /^CentOS release 5.3.*/)                        { $release = '_CentOS5.3';   }
    elsif ($release_string =~ /^CentOS release 5.8.*/)                        { $release = '_CentOS5.8';   }
    elsif ($release_string =~ /^CentOS release 6.2.*/)                        { $release = '_CentOS6.2';   }
	elsif ($release_string =~ /^CentOS release 6.3.*/)                        { $release = '_CentOS6.3';   }
	elsif ($release_string =~ /^CentOS release 6.4.*/)                        { $release = '_CentOS6.4';   }
	elsif ($release_string =~ /^CentOS release 6.5.*/)                        { $release = '_CentOS6.5';   }
	elsif ($release_string =~ /^CentOS release 6.6.*/)                        { $release = '_CentOS6.6';   }
    else
    {
      print STDERR "unrecognized Red Hat release\n";
      $release = '_RH';
    }
  }
  ### Ubuntu
  elsif (-e '/etc/lsb-release') 
  {
    $distrib_id = `cat /etc/lsb-release | grep DISTRIB_ID`;
    $distrib_id =~ s/DISTRIB_ID=//;
    $distrib_release = `cat /etc/lsb-release | grep DISTRIB_RELEASE`;
    $distrib_release =~ s/DISTRIB_RELEASE=//;
    chomp $distrib_id;
    chomp $distrib_release;
    $release = "_${distrib_id}${distrib_release}";	
  }
  ###
  else
  {
    $release = '';
  }
}
### Sun
elsif ($uname eq 'SunOS')
{
  $release = '_' . `uname -r`;
  chomp $release;
  @toks = split(/\s/, `CC -V 2>&1`);
  $CC_version =  $toks[3];
  $compiler_version = "CC${CC_version}";
}

### Mac Flavors
elsif ($uname eq 'Darwin')
{
	$release_string = `uname -r`;
	if    ($release_string =~ /^6.*/)  { $release = '_macosx10.2'; }
	elsif ($release_string =~ /^7.*/)  { $release = '_macosx10.3'; }
	elsif ($release_string =~ /^8.*/)  { $release = '_macosx10.4'; }
	elsif ($release_string =~ /^9.*/)  { $release = '_macosx10.5'; }
	elsif ($release_string =~ /^10.*/) { $release = '_macosx10.6'; }
	elsif ($release_string =~ /^11.*/) { $release = '_macosx10.7'; }
	elsif ($release_string =~ /^12.*/) { $release = '_macosx10.8'; }
	elsif ($release_string =~ /^13.*/) { $release = '_macosx10.9'; }
	else
	{
		print STDERR "unrecognized Mac OS X (Darwin) release\n";
		$release = '_macosx';
	}
}
else
{
  $release = '';
}

# This part sets the processor type and GCC version number
$processor = `uname -p`;
# For some Linux flavor the above might return "unknown"
# In that case, trying the machine architecture.
# Warning: The machine arch might not be the architecture of the running kernel
if($processor == "unknown") { $processor = `uname -m`; }
# Temporary path added to avoind hangs if gcc is not found
$gccversion = `gcc -dumpversion`;
chomp $processor;
chomp $gccversion;

# If the compiler_version variable is not set, use the gcc version
if ($compiler_version eq '') 
{
  $compiler_version = "gcc${gccversion}";
}
#
print "${uname}${release}-${processor}-${compiler_version}\n";
exit;












