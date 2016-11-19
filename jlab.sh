#
# You must source this script. At your bash prompt type: ". <path>/jlab.sh"
#
# Get the JLAB environment variables by parsing the script in tcsh and then
# printing the  environment.  We need to filter out the spaces, since that
# confuses the for loop. We also need to drop some tcsh specific environment
# variables from the export list.
#
# Author: Maurik Holtop, maurik@physics.unh.edu
# Date:   August, 2016
#
# - Brad Sawatky <brads@jlab.org>  (Nov 17, 2016)
#   - rewrote script to fix a few issues


TMPF=`mktemp`
tcsh ${TCSH_ARG} -c "source ${JLAB_ROOT}/${JLAB_VERSION}/ce/jlab.csh ${JLAB_VERSION}; printenv" | perl -e '
  my %IGNORE;
  ## Add variables to ignore to the space-delimited list below
  foreach( qw(
    HISTTIMEFORMAT SHELL PS1 overwrite _ BASH_FUNC_module\(\)
  )){ $IGNORE{$_}="yes"; }

  while(<>) {
    chomp;

    ## Look for and treat variables from printenv here
    if(/(.*?)=(.*)/) {
      my $var = $1;
      my $arg = $2;

      next if( exists($IGNORE{$var}) );

      if( $ENV{OSTYPE} eq "darwin" ) {
        if( $var =~ /(DY)?LD_LIBRARY_PATH/ ) {
          $arg =~ s/:$//;   # strip trailing colon
          print "export ${var}=\"${arg}:$ENV{$var}\"\n";
        }
        next;
      }

      ## DEFAULT is to re-export the variable list into the bash environment
      print "export ${var}=\"${arg}\"\n";
      next;
    }

    ## Dump information messages (and everything else) to STDERR where it should not hurt anyone
    print STDERR "$_\n";
  }
' >> $TMPF

source "$TMPF"
rm -f "$TMPF"
