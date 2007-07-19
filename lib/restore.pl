# restore.pl

use yabby_sys;
use Switch;

$USAGE = "
 Restores Yabby session saved with the command 'dump'

 Usage:
	restore SESSION_NAME

 Where SESSION_NAME is the archive name used when dumping
 the session.

 Notes:
 1. The session will sored to a file named SESSION_NAME.tar.gz.
 2. Relies on GNU gar and gzip commands. These must be in the
 executable path.
";

# options
# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 1 ] );
$archive_name = $argl[0];

# requirements
$tar_archive = $archive_name . ".tar";
$gzip_archive = $tar_archive . ".gz";

if ( ! -e $gzip_archive ) { error( "$gzip_archive does not exist" ); }


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
    $status = system( "gzip", "-d", $gzip_archive );
    if ( $status != 0 ) { error( "gzip decompress failed", "\n" ); }
    
    $status = system( "tar", "-xf", $tar_archive );
    if ( $status != 0 ) { error( "tar failed" ); }
    
    $status = system( "gzip", $tar_archive );
    if ( $status != 0 ) { error( "final gzip compress failed" ); }
  }

  case ( "DOS" ) {    
    $status = system( "COMPACT \\Q \\U \"$gzip_archive\"" );
    if ( $status != 0 ) { error( "decompress failed", "\n" ); }
    
    $status = system( "RENAME \"$gzip_archive\" \"$archive_name\"" );
    if ( $status != 0 ) { error( "decompress failed", "\n" ); }
  }
}

print " Yabby session '$archive_name' restored\n";

