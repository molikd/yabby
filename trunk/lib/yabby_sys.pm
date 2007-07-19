# yabby_sys.pm

use File::Path;

$WARN_OVERW = 1;
$NOWARN_OVERW = 0;

# --------------
# INITIALISATION
# --------------

sub perl_init {
  $PERL_CALL = "/usr/bin/perl";
  $PERL_INCL = "-I$LIB_DIR";
}

sub sys_init {
  my ( @args ) = @_;
  $| = 1; # disable output buffering
  $SYS_DIR = pop( @args );
  $LIB_DIR = pop( @args );
  $PROG_NAME = set_prog_name();
  perl_init();
  return @args;
}

sub set_prog_name {
  my ( $script_name, @name_split, $root_name );
  # $0 is the name of the script, as a full path
  $script_name = ( split /\//, $0 )[-1];
  @name_split = split /\./, $script_name; # remove ".pl"
  pop( @name_split );
  $root_name = join ".", @name_split;
  return $root_name;
}

# --------------
# ERROR HANDLING
# --------------

sub error {
  my ( $message, $sub_name ) = @_;
  my ( @msg_array, $msg_string );
  @msg_array = ();
  push @msg_array, " ERROR: $message";
  if ( defined($PROG_NAME) ) {
    unshift @msg_array, " $PROG_NAME\::";
  }
  if ( defined($sub_name) ) {
    push @msg_array,
      "\n [ error occurred in the subroutine $sub_name() ]\n";
  } else {
    push @msg_array, "\n";
  }
  $msg_string = join "", @msg_array;
  print "$msg_string";
  exit_error();
}

# option error: avoid reference to $PROG_NAME
sub option_error {
  my ( $message ) = @_;
  print "\n option error: $message\n";
  exit_error();
}

sub error_trace {
  my ( $message ) = @_;
  my ( $depth, @caller_info, $ii );
  print " $PROG_NAME\:: ERROR: $message\n";
  $depth = -1;
  do {
    $depth++;
    @caller_info = caller( $depth );
    } while ( defined($caller_info[0]) );
  $depth--;
  if ( $depth > 0 ) {
     print "\n -> Printing traceback:\n";
     for $ii ( 1 .. $depth ) {
       @caller_info = caller( $ii );
       print "\n   file: $caller_info[1]"; 
       print "\n   line number: $caller_info[2]"; 
       print "\n   subroutine: $caller_info[3]\n"; 
     }
  }
  print "\n";
  exit_error();
}

sub exit_ok { exit(0); }

sub exit_error { exit(1); }

# ---------
# BASIC I/O
# ---------

sub open_for_reading {
  my ( $file_name ) = @_;
  my ( $status );
  local ( *FILE );
  $status = open( FILE, $file_name );
  if ( ! defined( $status ) ) {
     error( "can't open file '$file_name' for reading" );
  }
  if ( sysread( FILE, $_, 2**16 ) == 0 ) {
    close_file( FILE );
    error( "'$file_name' is an empty file!" );
  }
  # undo sysread() call
  close FILE;
  $status = open( FILE, $file_name );
  return *FILE;
}

sub open_for_writing {
  my ( $file_name ) = @_;
  my ( $status );
  local( *FILE );
  $status = open( FILE, ">$file_name" );
  if ( ! defined( $status ) ) {
    error( "can't open file '$file_name' for writing" );
  }
  return *FILE;
}

sub close_file {
  local ( *FILE ) = @_;
  close FILE;
}

# -----------------
# YABBY OBJECTS I/O 
# -----------------

# flat files
sub load_ip {
  my ( $obj_name, $property ) = @_;
  my ( $sys_file, $data, $file );
  if ( exists_ip( $obj_name, $property ) ) {
     $sys_file = sys_path( $obj_name, $property );
  } else {
     error( "item '$obj_name' does not have the property '$property'" );
  }
  $data = [];
  $file = open_for_reading( $sys_file );
  while ( <$file> ) { push @$data, [ split ] }
  close_file( $file );
  return $data;
}

sub save_ip {
  my ( $data, $obj_name, $property, $warn_overw ) = @_;
  my ( $sys_file, $file );
  if ( exists_ip( $obj_name, $property ) ) {
     if ( $warn_overw ) {
        print " [ $PROG_NAME: '$obj_name.$property' exists, overwritten ]\n";
     }
  delete_ip( $obj_name, $property );
  }
  $sys_file = sys_path( $obj_name, $property );
  $file = open_for_writing( $sys_file );
  foreach ( @$data ) { print $file "@$_\n"; }
  close_file( $file );
}

# XML
sub load_ip_xml {
  my ( $obj_name, $property ) = @_;
  my ( $sys_file, $file, $xmldoc );
  if ( exists_ip( $obj_name, $property ) ) {
     $sys_file = sys_path( $obj_name, $property );
  } else {
     error( "item '$obj_name' does not have the property '$property'" );
  }
  $file = open_for_reading( $sys_file );
  $xmldoc = <$file>;
  close_file( $file );
  return $xmldoc;
}

sub save_ip_xml {
  my ( $xmldoc, $obj_name, $property, $warn_overw ) = @_;
  my ( $sys_file, $file );
  if ( exists_ip( $obj_name, $property ) ) {
     if ( $warn_overw ) {
        print " [ $PROG_NAME: '$obj_name.$property' exists, overwritten ]\n";
     }
  delete_ip( $obj_name, $property );
  }
  $sys_file = sys_path( $obj_name, $property );
  $file = open_for_writing( $sys_file );
  print $file "$xmldoc";
  close_file( $file );
}

sub sys_path {
  my ( $obj_name, $property ) = @_;
  my ( $sys_file );
  $sys_file = $SYS_DIR . "/" . $obj_name . "." . $property;
  return $sys_file;
}

# ------------------
# YABBY OBJECTS MISC
# ------------------

sub exists_ip {
  my ( $obj_name, $property ) = @_;
  my ( $ip_hash, $match, $key, $value, $message );
  $ip_hash = load_ip_hash();
  $match = 0;
  for $key ( keys %$ip_hash ) {
    if ( $key eq $obj_name ) {
      for $value ( @{ $ip_hash->{$key} } ) {
        if ( $value eq $property ) { $match++; }
      }
    }
  }
  if ( $match > 1 ) {
     $value = $obj_name . "." . $property;
     $message = sprintf( "exists_ip: %d matches for '%s'", $match, $value );
     error_trace( $message );
  }
  return $match;
}

sub delete_ip {
  my ( $obj_name, $property ) = @_;
  my ( $sys_file, $status );
  if ( exists_ip( $obj_name, $property ) ) { 
    $sys_file = sys_path( $obj_name, $property );
    #$status = system( "rm", $sys_file );
    #if ( $status != 0 ) {
    $status = rmtree( $sys_file );
    if ( $status == 0 ) {
        error_trace( "failed to remove '$sys_file'" );
    }
  } else {
    error( "delete_ip: '$obj_name.$property' does not exist" );
  }
}

# returns a hash of items and their properties
sub load_ip_hash {
  my ( $file_list, $ip_hash, $obj_name, $property );
  $file_list = dir_files( $SYS_DIR );
  $ip_hash = {};
  foreach ( @$file_list ) {
    ( $obj_name, $property ) = split_ip_string( $_ );
    push @{ $ip_hash->{$obj_name} }, $property;
  }
  return $ip_hash;
}

sub split_ip_string {
  my ( $ip_string ) = @_;
  my ( @dotsplit, $property, $obj_name );
  @dotsplit = split /\./, $ip_string;
  # guard against names which do not contain
  # a dot, or which start or end with a dot
  if ( ($#dotsplit > 0) && ($dotsplit[0] ne "") ) {
    $property = pop @dotsplit;
    $obj_name = join ".", @dotsplit;
  }
  else {
    error( "'$ip_string' does not denote a valid YABBY object" );
  }
  return ( $obj_name, $property );
}

sub load_cmd_hash {
  my ( @dotsplit, $extension, $command );
  my ( $file_list, @cmd_list, %cmd_hash );
  $file_list = dir_files( $LIB_DIR );
  @cmd_list = ();
  foreach ( @$file_list ) {
    if ( substr( $_, 0, 1 ) ne "_" ) {
      @dotsplit =  split /\./, $_;
      $extension = pop( @dotsplit );
      if ( $extension eq "pl" ) {
        $command = join ".", @dotsplit;
        push( @cmd_list, $command );
      }
    }
  }
  %cmd_hash = ();
  foreach $command ( @cmd_list ) { $cmd_hash{$command} = 1; }
  $cmd_hash{"quit"} = 1;
  $cmd_hash{"exit"} = 1;
  return \%cmd_hash;
}

# ---------
# AUXILIARY 
# ---------

sub check_call {
  my ( @argl ) = @_;
  my ( $narg, $message, $ok_args, $ii );
  # catch "help"
  if ( ( defined($argl[0]) ) && ( $argl[0] eq "help" ) ) {
    print "$USAGE\n";
    exit_ok();
  }
  # pop the number of expected arguments
  $narg = pop @argl;
  # check the number of arguments
  $ok_args = 0;
  for $ii ( 0 .. $#{$narg} ) {
    if ( $narg->[$ii] == ($#argl + 1) ) {
       $ok_args++; 
    }
  }
  if ( ! $ok_args ) {
    if ( $#{$narg} == 0 ) {
      $message = sprintf( "exactly %d argument(s) required [ %d supplied ]",
           $narg->[0], $#argl + 1 );
    } else {
      $message =
        sprintf( "between %d and %d arguments required [ %d supplied ]",
        $narg->[0], $narg->[$#{$narg}], $#argl + 1 );
    }
  error( $message );
  }
}

#  argument: ( OBJ_NAME, PROPERTY1, PROPERTY2, ... )
sub requirements {
  my ( @property_list ) = @_;
  my ( $error_flag, $obj_name, $property );
  $error_flag = 0;
  $obj_name = shift @property_list;
  for $property ( @property_list ) {
    if ( ! exists_ip( $obj_name, $property ) ) {
      print " $PROG_NAME\:: missing requirement: '$obj_name.$property'\n"; 
      $error_flag++;
    }
  }
  if ( $error_flag ) { print "\n"; exit_error(); }
}

# remove dependencies
sub remove_deps {
  my ( $obj_name, @deps ) = @_;
  my ( $ip_hash, $key, $prop, $dep, $to_remove, $dep_base, $prop_base, $nn );
  $ip_hash = load_ip_hash();
  for $key ( keys %$ip_hash ) {
    if ( $obj_name eq $WILDCARD ) {
      for $prop ( @{ $ip_hash->{$key} } ) {
        for $dep ( @deps ) {
          if ( $dep eq $prop ) { delete_ip( $key, $prop ); }
        }
      }
    } else { # look for a specific item 
      if ( $key eq $obj_name ) {
        for $prop ( @{ $ip_hash->{$key} } ) {
          $to_remove = 0;
          for $dep ( @deps ) {
            if ( substr( $dep, -1, 1 ) eq $WILDCARD ) {
              $dep_base = substr( $dep, 0, -1 );
              $nn = length( $dep_base );
              $prop_base = substr( $prop, 0, $nn );
            } else {
              $dep_base = $dep;
              $prop_base = $prop;
            }
          if ( $dep_base eq $prop_base ) { $to_remove++; }
          }
        if ( $to_remove ) { delete_ip( $obj_name, $prop ); }
        }
      }
    }
  }
}

# ----------------------
# EXECUTE OTHER PROGRAMS
# ----------------------

sub execute {
  my ( @cmd ) = @_;
  my ( $status );
  $status = system @cmd;
  if ( $status != 0 ) { error( "'@cmd' failed" ); }
}

sub call {
  my ( @argl ) = @_;
  my ( $sub_name, $cmd_root, $cmd_script, @cmd, $status );
  $sub_name = "call";
  $cmd_root = shift @argl;
  $cmd_script = $LIB_DIR . "/" . $cmd_root . ".pl";  
  @cmd = ();
  push @cmd, "-w";
  push @cmd, $cmd_script;
  push @cmd, @argl;
  push @cmd, $LIB_DIR;
  push @cmd, $SYS_DIR;
  $status = system "$PERL_CALL $PERL_INCL @cmd";
  if ( $status != 0 ) {
     error( "system script '$cmd_root' failed", $sub_name );
  }
}

# -----
# OTHER
# -----

# get the list of files from a directory
sub dir_files {
  my ( $dir_name ) = @_;
  my ( $file_list, @all_entries );
  local ( *DIR );
  if ( opendir(DIR,$dir_name) ) {
    $file_list = [];
    @all_entries = readdir( DIR );
    foreach ( @all_entries ) {
      if ( -f "$dir_name/$_" ) {
        push @$file_list, $_;
      }
    }
    closedir ( DIR );
  } else {
     error( "failed to opendir '$dir_name'" );
  }
  return $file_list;
}

return 1;

