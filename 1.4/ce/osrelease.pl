#!/usr/bin/env perl

use warnings;
use strict;

# Generate a string specific to the current posix platform for
# purposes of separating and distributing binaries.
#
# The output will have the form:
#
#  PosixType_OSVersion##-architecture-compilerType##
#
# Some examples:
#
# Linux_CentOS6.5-x86_64-gcc4.4.7
# Darwin__macosx10.11-x86_64-clang7.0.2
# Linux_Fedora9-i686-gcc4.3.0
#
# Errors are printed to stderr and some attempt is made to return
# a reasonable string for the system such that the script
# will never fail.
#

my $uname = `uname`;
chomp $uname;

my $compilerVersion = 'unknown';
my $release = 'unknown';


### Linux ########################
# Assuming gcc as default compiler
# --------------------------------
if ($uname eq 'Linux')
{
	### Fedora
    # time to make these general
	if (-e '/etc/fedora-release')
	{
		my     $release_string = `cat /etc/fedora-release`;
		if    ($release_string =~ /^Fedora release 28.*/)     { $release = '_Fedora28'; }
		elsif ($release_string =~ /^Fedora release 27.*/)     { $release = '_Fedora27'; }
		elsif ($release_string =~ /^Fedora release 26.*/)     { $release = '_Fedora26'; }
		elsif ($release_string =~ /^Fedora release 25.*/)     { $release = '_Fedora25'; }
		elsif ($release_string =~ /^Fedora release 24.*/)     { $release = '_Fedora24'; }
		elsif ($release_string =~ /^Fedora release 23.*/)     { $release = '_Fedora23'; }
		elsif ($release_string =~ /^Fedora release 22.*/)     { $release = '_Fedora22'; }
		elsif ($release_string =~ /^Fedora release 21.*/)     { $release = '_Fedora21'; }
		else
		{
			print STDERR "unrecognized Fedora release\n";
			$release = '_Fedora';
		}
	}
	### Red-Hat, SL, CentOS
	elsif (-e '/etc/redhat-release')
	{
		my $releaseString = `cat /etc/redhat-release`;
		if    ($releaseString =~ /^CentOS.*/)     { $release = 'CentOS'; }
		elsif ($releaseString =~ /^Red.*/)        { $release = 'RedHat'; }
		elsif ($releaseString =~ /^Scientific.*/) { $release = 'SL'; }
		
		# get everything after release
		my @releaseN = split /release/, $releaseString;
		# there may be a version in parenthesis
		my @releaseNs = split /\(/, $releaseN[1];
		# getting just the number
		my $relVersion = $releaseNs[0];
		# remove spaces at the beginning and end
		$relVersion =~ s/^\s+|\s+$//g;
		$release = $release.$relVersion;
	}
	### Ubuntu
	elsif (-e '/etc/lsb-release')
	{
		my $distrib_id = `cat /etc/lsb-release | grep DISTRIB_ID`;
		$distrib_id =~ s/DISTRIB_ID=//;
		my $distrib_release = `cat /etc/lsb-release | grep DISTRIB_RELEASE`;
		$distrib_release =~ s/DISTRIB_RELEASE=//;
		chomp $distrib_id;
		chomp $distrib_release;
		$release = "_${distrib_id}${distrib_release}";
	}
	###
	else
	{
		print STDERR "unrecognized Linux release\n";
		$release = 'linuxUnknown';
	}
    my $compV = qx(gcc -dumpversion);
    # chomp it to remove carriage return
    chomp $compV;
    $compilerVersion = "gcc".$compV;
}

### Mac ###################
# Clang is default compiler
# -------------------------
elsif ($uname eq 'Darwin')
{
	my $release_string = `uname -r`;
	if    ($release_string =~ /^13.*/) { $release = 'macosx10.9'; }
	elsif ($release_string =~ /^14.*/) { $release = 'macosx10.10'; }
	elsif ($release_string =~ /^15.*/) { $release = 'macosx10.11'; }
	else
	{
		print STDERR "unrecognized Mac OS release: $release_string\n";
		$release = 'macosxUnknown';
	}

    
    # the output of clang -v is to stderr so redirecting output to stdout
    my $clangV = qx( clang -v 2>&1 | head -1);
    # removing first words from outout
    $clangV =~ s/Apple LLVM version//;
    # getting just the version number
    my @clangN = split " ", $clangV;
    $compilerVersion = "clang".$clangN[0];
}

# This part sets the processor type and compiler version number
my $processor = qx(uname -m);
# chomp it to remove carriage return
chomp $processor;


print "${uname}_${release}-${processor}-${compilerVersion}\n";
exit;












