# seq_firstl.pl

use yabby_sys;
use yabby_seq;

use Getopt::Std;

$USAGE = "
 Prints the first sequence letter from the sequence object. 

 Usage:
        seq_firstl [ options ] OBJ_NAME

 where OBJ_NAME is the name of an existing sequence object.

 Options:

 -t -- print the last letter instead of the first

 Notes:

 1. This command is merely an example to demonstrate how new
 Yabby commands can be developed.
";

# options
getopts('t');

if ( defined( $opt_t ) ) {
  $opt_t_flag = 1;
} else {
  $opt_t_flag = 0;
}

# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 1 ] );
$obj_name = $argl[0];

# requirements
requirements( $obj_name, $SEQUENCE );
$xmldoc = load_ip_xml( $obj_name, $SEQUENCE );

# body
$seq_hash = xml2seq( $xmldoc );
$keys = get_seq_keys( $seq_hash );
printf " '%s' contains %d sequence(s)\n", $obj_name, $#{$keys}+1;

for $key ( @$keys ) {

  $seq_item = $seq_hash->{$key};
  $seq_id = $seq_item->{$DBA_SEQID};
  $sequence = $seq_item->{$DBA_SEQUENCE};

  if ( $opt_t_flag ) {
    $lett = substr( $seq_item->{$DBA_SEQUENCE}, -1, 1 );
  } else {
    $lett = substr( $seq_item->{$DBA_SEQUENCE}, 0, 1 );
  }

  printf " Sequence '%s', the letter is '%s'\n", $seq_id, $lett;
}



