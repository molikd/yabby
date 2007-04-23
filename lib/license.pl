# license.pl

use yabby_sys;

$USAGE = "
 Prints Yabby license

 Usage:
 	license
";

# options
# initialization

@argl = sys_init( @ARGV );

check_call( @argl, [ 0 ] );

# requirements
# body

$status = system( "more", "$LIB_DIR/../LICENSE" );

if ( $status != 0 ) {

  error( "cannot find license file", "\n" );
  }

