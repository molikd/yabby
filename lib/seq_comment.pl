# seq_comment.pl

use yabby_sys;
use yabby_seq;
use yabby_utils;

use Getopt::Std;

$USAGE = "
 Modifies sequence comments to add a unique number. 

 Usage:
    seq_comment OBJ_NAME

 where OBJ_NAME is the name of an existing sequence object.

 The sequence object with modified comments overwrites OBJ_NAME.
 The comment for each sequence is modified to prepend N- where
 N is the order of the sequence.  For example, if the sequence
 comment was Q9JXN6, and was first in the sequence object, its
 comment will be modified to 1-Q9JXN6. 
";

# options
# initialization

@argl = sys_init( @ARGV );
check_call( @argl, [1] );
$obj_name = $argl[0];

# requirements
requirements( $obj_name, $SEQUENCE );
$xmldoc = load_ip_xml( $obj_name, $SEQUENCE );
$seq_hash = xml2seq( $xmldoc );

# body
$keys = get_seq_keys( $seq_hash );
for $key ( @$keys ) {
  $seq_item = $seq_hash->{$key};
  $seq_item->{$DBA_SEQID} = $key . "-" . $seq_item->{$DBA_SEQID};
}

$xmldoc = seq2xml( $seq_hash );
save_ip_xml( $xmldoc, $obj_name, $SEQUENCE, $NOWARN_OVERW );

printf " Comments modified in %d sequence(s).\n", $#{$keys}+1;

