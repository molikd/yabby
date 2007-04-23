# restore.pl

use yabby_sys;

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
# body

$tar_archive = $archive_name . ".tar";
$gzip_archive = $tar_archive . ".gz";

if ( ! -e $gzip_archive ) { error( "$gzip_archive does not exist" ); }

$status = system( "gzip", "-d", $gzip_archive );
if ( $status != 0 ) { error( "gzip decompress failed", "\n" ); }

$status = system( "tar", "-xf", $tar_archive );
if ( $status != 0 ) { error( "tar failed" ); }

$status = system( "gzip", $tar_archive );
if ( $status != 0 ) { error( "final gzip compress failed" ); }

print " Yabby session '$archive_name' restored\n";

