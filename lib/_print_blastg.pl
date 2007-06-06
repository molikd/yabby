# _print_blastg.pl

use yabby_sys;
use yabby_blast;

use Getopt::Std;

# options
getopt('f');

if ( defined($opt_f) ) {
  $opt_f_flag = 1;
  $file_name = $opt_f;
} else {
  $opt_f_flag = 0;
}

# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [1] );
$obj_name = $argl[0];
requirements( $obj_name, $BLASTG );

$top_hits = load_ip( $obj_name, $BLASTG );

# body
if ( $opt_f_flag ) {
  $fp = open_for_writing( $file_name );
} else {
  $fp = *STDOUT;
}

for $item (@$top_hits) {
  print $fp "$item->[0] $item->[1] $item->[2]\n";
}

if ( $opt_f_flag ) {
  close_file( $fp );
  print " '$obj_name.$BLASTG' written to the file '$file_name'\n";
}

