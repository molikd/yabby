# dump.pl

use yabby_sys;

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
# body
$tar_archive = $file_name . ".tar";
if ( -e $tar_archive ) {
   error( "$tar_archive exists, remove prior to dumping" );
}

$status = system( "tar", "--create", "--file=$tar_archive", $SYS_DIR );
if ( $status != 0 ) { error( "tar failed" ); }

$gzip_archive = $tar_archive . ".gz";
$status = system( "gzip", $tar_archive );
if ( $status != 0 ) { error( "gzip failed" ); }

print " Yabby session archived as '$gzip_archive'\n";

