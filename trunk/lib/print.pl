# print.pl

use yabby_sys;
use yabby_seq;
use yabby_blast;
use yabby_emboss;

use Getopt::Std;

$USAGE = "
 Prints an object on the terminal screen or to a file.

 Usage:

    print [ options ] OBJ_NAME.TYPE

 Options:

 General:
 -f FILE_NAME -- print to a file instead on the terminal
 screen

 Specific for sequence object:
 -l -- print the sequences as the three-letter code
 -c -- print the sequences as the CSV table
 -n N -- print N residues per line (both when printing one- and
 three-letter codes)
 -t N -- truncate each sequence at N letters when writing (works
 only when printing one-letter code)

 Specific for needl2 object:
 -s -- sort by similarity score

 Notes:

 1. Currently print supports the following objects: 'seq', 'motif',
 'blastg', and 'needl2'.
";

# options
@opt_str = ();

getopt('fnt');

if ( defined($opt_f) ) {
   push @opt_str, "-f";
   push @opt_str, $opt_f;
}
if ( defined($opt_n) ) {
   push @opt_str, "-n";
   push @opt_str, $opt_n;
}
if ( defined($opt_t) ) {
   push @opt_str, "-t";
   push @opt_str, $opt_t;
}

getopts('lcs');
if ( defined($opt_l) ) {
   push @opt_str, "-l";
}
if ( defined($opt_c) ) {
   push @opt_str, "-c";
}
if ( defined($opt_s) ) {
   push @opt_str, "-s";
}

# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [1] );
$ip_string = $argl[0];
( $obj_name, $property ) = split_ip_string( $ip_string );

# body
if ( $property eq $SEQUENCE ) {
  call( "_print_seq", @opt_str, $obj_name );
} elsif ($property eq $MOTIF) {
  call( "_print_motif", @opt_str, $obj_name );
} elsif ($property eq $BLASTG) {
  call( "_print_blastg", @opt_str, $obj_name );
} elsif ($property eq $NEEDL2) {
  call( "_print_needl2", @opt_str, $obj_name );
} else {
  error( "printing the property '$property' not yet implemented" );
}

