# seq_letters.pl

use yabby_sys;
use yabby_seq;

use Getopt::Std;

$USAGE = "
 Chops the first sequence letter from the sequence object, and
 saves the result as a new sequence object.

 Usage:
        seq_letters OBJ_NAME OBJ_NAME_NEW

 where OBJ_NAME is the name of an existing sequence object.

 Notes:

 1. This command is merely an example to demonstrate how new
 Yabby commands can be developed.
";

# options
# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 2 ] );
$obj_name = $argl[0];
$obj_name2 = $argl[1];

# requirements
requirements( $obj_name, $SEQUENCE );
$xmldoc = load_ip_xml( $obj_name, $SEQUENCE );

# body
$seq_hash = xml2seq( $xmldoc );
$keys = get_seq_keys( $seq_hash );

printf " '%s' contains %d sequence(s)\n", $obj_name, $#{$keys}+1;

$seq_hash2 = {};

for $key ( @$keys ) {

  $seq_item = $seq_hash->{$key};

  $seq_item_new = {};
  $seq_item_new->{$DBA_SEQID} = $seq_item->{$DBA_SEQID};
  $seq_item_new->{$DBA_COMMENT} = $seq_item->{$DBA_COMMENT};
  $seq_item_new->{$DBA_SEQUENCE} = $seq_item->{$DBA_SEQUENCE};

  # chop the first letter from the sequence
  substr( $seq_item_new->{$DBA_SEQUENCE}, 0, 1 ) = "";

  $seq_hash2->{$key} = $seq_item_new;
}

$xmldoc = seq2xml( $seq_hash2 );

printf " Saving chopped sequences as '%s'\n", $obj_name2;
save_ip_xml( $xmldoc, $obj_name2, $SEQUENCE, $WARN_OVERW );

