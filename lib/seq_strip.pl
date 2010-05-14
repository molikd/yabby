# seq_strip.pl

use yabby_sys;
use yabby_seq;
use yabby_utils;

use Getopt::Std;

$USAGE = "
 Strips specified sequence portion of a sequence object.

 Usage:
 	seq_strip begin:end OBJ_NAME OBJ_NAME_NEW

 Where OBJ_NAME is the name of an existing sequence object, and
 begin:end are the first and last residue to strip (inclusive).
 The resulting object will be saved under the name OBJ_NAME_NEW.

 If more than one sequence is present in the sequence object,
 all will be stripped and saved under the new name.

 In stripped sequences, IDs are set to ORIGINALID_begin:end.
";

# options
# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 3 ] );
$strip_range = $argl[0];
$obj_name = $argl[1];
$obj_name2 = $argl[2];

# requirements
requirements( $obj_name, $SEQUENCE );
$xmldoc = load_ip_xml( $obj_name, $SEQUENCE );

# body
$fields = split_on_colon($strip_range);

$begin = $fields->[0];
$end = $fields->[1];

if ( (! unsig_int($begin)) ||  (! unsig_int($end)) ) {
  error("'begin' and 'end' must be unsigned integers");
}
if ( $begin == 0 ) {
  error("'begin' must not be equal to zero");
}
if ( ! ($begin < $end) ) {
  error("'begin' must less than 'end'");
}

$seq_hash = xml2seq( $xmldoc );
$keys = get_seq_keys( $seq_hash );

printf " '%s' contains %d sequence(s)\n", $obj_name, $#{$keys}+1;

$seq_hash2 = {};

for $key ( @$keys ) {

  $seq_item = $seq_hash->{$key};
  $seq_slice = substr( $seq_item->{$DBA_SEQUENCE}, $begin-1, $end-$begin+1 );

  print " stripping '$seq_item->{$DBA_SEQID}'\n";

  $seq_item_new = {};
  $seq_item_new->{$DBA_SEQID} = $seq_item->{$DBA_SEQID} .  "_$begin:$end";
  $seq_item_new->{$DBA_COMMENT} = $seq_item->{$DBA_COMMENT};
  $seq_item_new->{$DBA_SEQUENCE} = $seq_slice;
  $seq_hash2->{$key} = $seq_item_new;
}

$xmldoc = seq2xml( $seq_hash2 );
save_ip_xml( $xmldoc, $obj_name2, $SEQUENCE, $WARN_OVERW );

