# seq_sprot_os.pl

use yabby_sys;
use yabby_seq;

$USAGE = "
 Inserts the organism name into sequence comments by using
 the local Swiss-Prot database file.

 Usage:
 	seq_sprot_os DBA_FILE OBJ_NAME

Where DBA_FILE is the local database file in the Swiss-Prot
format, and OBJ_NAME is the name of an existing sequence
object. The object OBJ_NAME will be overwritten with altered
comments to include the organism name for each sequence.
";

# options
# initialization
@argl = sys_init( @ARGV );

check_call( @argl, [ 2 ] );
$sprot_dba = $argl[0];
$obj_name = $argl[1];

# requirements
requirements( $obj_name, $SEQUENCE );
$xmldoc = load_ip_xml( $obj_name, $SEQUENCE );
$seq_hash = xml2seq( $xmldoc );

# body
$keys = get_seq_keys( $seq_hash );

$seq_hash2 = {};
$cntr = 0;

printf " %d sequences to process.\n", $#{$keys}+1;
print " Printing dot per processed sequence:\n";

for $key ( @$keys ) {

  if ( $cntr == 0 ) { print " " }

  $seq_item = $seq_hash->{$key};
  $seq_id = $seq_item->{$DBA_SEQID};

  $seq_item_dba = fetch_sprot_seq($sprot_dba, $seq_id);

  if (! defined($seq_item_dba->{$DBA_SEQID}) ) {
    error("sequence '$seq_id' not found in the database");
  } else {
    $cntr++;
    $seq_item->{$DBA_COMMENT} = $seq_item->{$DBA_COMMENT}
        . " " .  $seq_item_dba->{$DBA_OS};
    $seq_hash2->{$cntr} = $seq_item;
  }
  if ( ($cntr % 60) == 0 ) { print ".\n " } else { print "." };
}

print "\n All done.\n";

$xmldoc = seq2xml( $seq_hash2 );
save_ip_xml( $xmldoc, $obj_name, $SEQUENCE, $WARN_OVERW );

