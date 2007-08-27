#!/usr/bin/perl

#######################################################
#                                                     #
# INSTALLATION                                        #
#                                                     #
# (1) Set the two statements below to the full path   #
#     to Yabby library.                               #
# (2) Make sure that this script (yabby.pl) is in the #
#     path searched for executable files.             #
#                                                     #
#######################################################

#use lib "C:\\Documents and Settings\\cr12\\My Documents\\yabby\\lib";
#$LIB_DIR = "C:\\Documents and Settings\\cr12\\My Documents\\yabby\\lib";
use lib "/home/current/proj/yabby/code/yabby/lib";
$LIB_DIR = "/home/current/proj/yabby/code/yabby/lib";

#######################################################
# End of installation section. Statements below this  #
# line normally should not be modified.               #
#######################################################

die "\n You must have Perl 5 to run YABBY\n\n" if $] < 5.000;

$version = 0.10;

use File::Path;
use Switch;
use yabby_sys;
use yabby_utils;

# set $PERL_CALL and $PERL_INCL
perl_init();

# $SYS_DIR is given as an absolute path if it starts
# with a slash; otherwise it is relative to the
# directory in which this script has been started.
$SYS_DIR = ".yabby";
$PROMPT  = "yabby>";
$cmd_hash = load_cmd_hash();
$n_cmd = keys %$cmd_hash;

# determine the OS running Yabby
$OS_NAME = '';
unless ( $OS_NAME = $^O ) {
  require Config;
  $OS_NAME = $Config::Config{'osname'};
}

if ( $OS_NAME=~/Win/i ) { 
  $OS_NAME = 'DOS';
} else { 
  $OS_NAME = 'UNIX'; 
}

print "\n - YABBY version $version - \n";
print "   Copyright (c) 2004-7 Vladimir Likic\n";
printf " [ %d command(s) ready ]\n\n", $n_cmd;

if ( -d $SYS_DIR ) {

  print " Previous session of YABBY was not exited cleanly\n";
  print " or multiple YABBY sessions started.\n";

  do {
    print "\n  1 -- continue previous session [ default ]\n";
    print "  2 -- start new YABBY session\n";
    print "  [ Ctrl-C to abort ] ? ";

    $c = <STDIN>; chomp( $c );
    if ( $c eq "" ) { $c = 1; }
  } until ( ($c eq "1") || ($c eq "2") );

  if ( $c eq "2" ) {
    $status = rmtree( $SYS_DIR );
    if ( $status == 0 ) { 
      print "\n An error occurred while trying to remove\n";
      print "  the directory '$SYS_DIR'\n Make sure that";
      print " you have proper writing permissions\n\n";

      exit_error();
    }
    mksysdir();
  }
} else {
   mksysdir();
}

# parser loop

print "$PROMPT ";

while ( <> ) {
  
  $input_line = $_;
  chomp( $input_line );

  if ( $input_line ne "" ) {

    $input_line = trim_end_blanks( $input_line );
    $c = substr( $input_line, 0, 1 );

    if ( $c eq "%" ) { # skip comments
      print "$input_line\n";
    } else {
      @cmdl = split ' ', $input_line;
      @argl = (); push ( @argl, @cmdl );
      $cmd_root = shift( @argl );
      $narg = $#argl + 1;

      # if a YABBY command
      if ( exists( $cmd_hash->{$cmd_root} ) ) {

        if ( ( $cmd_root eq "quit" ) || ( $cmd_root eq "exit" ) ) {
          exit_yabby();

        } else { # execute a command

          switch ( $OS_NAME ) {

            case ( "UNIX" ) {
              $cmd_script = $LIB_DIR . "/" . $cmd_root . ".pl";
              @cmd = ();
              push @cmd, "-w";
              push @cmd, $cmd_script;
              push @cmd, @argl;
              push @cmd, $LIB_DIR;
              push @cmd, $SYS_DIR;
              push @cmd, $OS_NAME;
              print "\n";
              $status = system $PERL_CALL, $PERL_INCL, @cmd;

            } case ( "DOS" ) {
              my $tmp_sys_str = "\"$SYS_DIR\"";
              my $tmp_lib_str = "\"$LIB_DIR";
              $cmd_script = $tmp_lib_str . "\\" . $cmd_root . ".pl\"";
              $tmp_lib_str = "$tmp_lib_str\"";
              @cmd = ();
              push @cmd, "-w";
              push @cmd, $cmd_script;
              push @cmd, @argl;
              push @cmd, "$tmp_lib_str";
              push @cmd, "$tmp_sys_str";
              push @cmd, $OS_NAME;
              $status = system "perl", $PERL_INCL, @cmd;
            }
          }

          if ( $status != 0 ) {
            print " [ command '$cmd_root' failed ]\n\n";
          } else {
            print "\n";
          }
        }
      } else { # try unix command

        $status = system @cmdl;

        if ( $status != 0 ) {
          print "\n [ $OS_NAME command '@cmdl' failed ]\n\n";
        }
      }
    }
  }
  print "$PROMPT ";
}

# if here, YABBY was run with redirection from an input file.
# Clean up and exit.

exit_yabby();

# subroutines

sub exit_yabby {
  $status = rmtree( $SYS_DIR );
  if ( $status == 0 ) {
    print "ERROR: cannot remove '$SYS_DIR'\n";
  }
  print "\n bye-bye\n\n";
  exit_ok();
}

sub mksysdir {
  $status = system( "mkdir", $SYS_DIR );
  if ($status != 0) {
    print "\n an error occurred while trying to create\n";
    print "  directory $SYS_DIR\n Make sure that you\n";
    print "  have proper writing permissions\n\n";
    exit_error();
  }
}

