# seq_os.pl

use yabby_sys;
use yabby_seq;

$USAGE = "
 Inserts organism names into sequence comments, where organism
 names are read from an external file.

 Usage:
 	seq_os ORG_FILE OBJ_NAME

 Where ORG_FILE is the file which contains pairs (sequence
 ID, organism name), and OBJ_NAME is the name of an existing
 sequence object. ORG_FILE must include all sequence IDs
 present in the OBJ_NAME.

 The object OBJ_NAME will be overwritten with altered comments
 to include the organism name for each sequence.
";

# options
# initialization
@argl = sys_init( @ARGV );

check_call( @argl, [ 2 ] );
$dba_file = $argl[0];
$obj_name = $argl[1];

# requirements
requirements( $obj_name, $SEQUENCE );
$xmldoc = load_ip_xml( $obj_name, $SEQUENCE );
$seq_hash = xml2seq( $xmldoc );

# body
print " Reading the file '$dba_file' ...\n";

$fp = open_for_reading( $dba_file );

$dba_hash = {};

while ( <$fp> ) {
  $line = $_; chomp( $line );
  @fields = split " ", $line;
  $seq_id = shift @fields;
  $org_name = join " ", @fields;
  $dba_hash{$seq_id} = $org_name;
}

close_file( $fp );

# process sequences
$keys = get_seq_keys( $seq_hash );

$seq_hash2 = {};
$cntr = 0;

printf " %d sequences to process.\n", $#{$keys}+1;
print " Printing dot per processed sequence:\n";

for $key ( @$keys ) {

  if ( $cntr == 0 ) { print " " }

  $seq_item = $seq_hash->{$key};
  $seq_id = $seq_item->{$DBA_SEQID};

  if ( exists($dba_hash{$seq_id}) ) {
    $cntr++;
    $org_name = $dba_hash{$seq_id};
    $seq_item->{$DBA_COMMENT} = $seq_item->{$DBA_COMMENT} . " " .  $org_name;
    $seq_hash2->{$cntr} = $seq_item;
  } else {
    error("sequence '$seq_id' does not exist in the database '$dba_file'" );
  }
}

print "\n All done.\n";

$xmldoc = seq2xml( $seq_hash2 );
save_ip_xml( $xmldoc, $obj_name, $SEQUENCE, $WARN_OVERW );

