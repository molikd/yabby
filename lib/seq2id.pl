# seq2id.pl

use yabby_sys;
use yabby_seq;

use Getopt::Std;

$USAGE = "
 Converts a sequence object into seqid object.

 Usage:
        seq2id OBJ_NAME

 where OBJ_NAME is the name of an existing sequence object.

 Notes:

 1. This command is merely an example to demonstrate how a
 new object type can be implemented.
";

# options
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

$seqid_obj = [];

for $key ( @$keys ) {

  $seq_item = $seq_hash->{$key};
  $seq_id = $seq_item->{$DBA_SEQID};

  push @$seqid_obj, [ $seq_id ];
}

print " Saving '$obj_name.$SEQID'\n";
save_ip( $seqid_obj, $obj_name, $SEQID, $WARN_OVERW );

