# dump.pl

use yabby_sys;
use Switch;

$USAGE = "
 Dumps the current workspace to a file, which later can be
 restored with 'restore'. 

 Usage:
	dump SESSION_NAME

 This command saves the current Yabby session in the file
 SESSION_NAME.tar.gz in the current directory.

 Notes:

 1. Currently works only with GNU tar
";

# options
# initialization

@argl = sys_init( @ARGV );
check_call( @argl, [ 1 ] );
$file_name = $argl[0];

# requirements
$tar_archive = $file_name . ".tar";
$gzip_archive = $tar_archive . ".gz";

if ( -e $tar_archive ) {
   error( "$tar_archive exists, remove prior to dumping" );
}

# determine operating system

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

# body
switch ( $OS_NAME ) {

  case ( "UNIX" ) {
    $status = system( "tar", "--create", "--file=$tar_archive", $SYS_DIR );
    if ( $status != 0 ) { error( "tar failed" ); }
    
    $status = system( "gzip", $tar_archive );
    if ( $status != 0 ) { error( "gzip failed" ); }
    
  }
  case ( "DOS" ) {    
    $status = system( "COMPACT \\C \\Q \"$SYS_DIR\"" );
    if ( $status != 0 ) { error( "compress failed", "\n" ); }
    
    $status = system( "RENAME \"$SYS_DIR\" \"$gzip_archive\"" );
    if ( $status != 0 ) { error( "compress failed", "\n" ); }
  }
}

print " Yabby session archived as '$gzip_archive'\n";