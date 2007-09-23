# _print_needl2.pl

use yabby_sys;
use yabby_emboss;

use Getopt::Std;

# options
getopt('f');

if ( defined($opt_f) ) {
  $opt_f_flag = 1;
  $file_name = $opt_f;
} else {
  $opt_f_flag = 0;
}

getopts('s');

if ( defined($opt_s) ) {
  $opt_s_flag = 1;
} else {
  $opt_s_flag = 0;
}

# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [1] );
$obj_name = $argl[0];
requirements( $obj_name, $NEEDL2 );
$needl2 = load_ip( $obj_name, $NEEDL2 );

# body
if ( $opt_f_flag ) {
  $fp = open_for_writing( $file_name );
} else {
  $fp = *STDOUT;
}

# sort by ascending similarity
if ($opt_s_flag) {
  @$needl2 = sort { $a->[2] <=> $b->[2] } @$needl2;
}

# print
for $item ( @$needl2 ) {
  print $fp "$item->[0] $item->[1] $item->[2]\n";
}

if ( $opt_f_flag ) {
  close_file( $fp );
  print " '$obj_name.$MOTIF' written to the file '$file_name'\n";
}

