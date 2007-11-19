# sprot_fetch.pl

use yabby_sys;
use yabby_seq;

$USAGE = "
 Fetches a sequence from a SWISS-PROT database by its ID.

 Usage:
 	sprot_fetch DBA_FILE SPROT_ID OBJ_NAME

 Where DBA_FILE is the database is the Swiss-Prot format,
 and SPROT_ID is the swiss-prot sequence ID, and OBJ_NAME
 is the name under which the sequence will be saved in
 the workspace.
";

# options
# initialization
@argl = sys_init( @ARGV );

check_call( @argl, [ 3 ] );
$sprot_dba = $argl[0];
$sprot_id = $argl[1];
$obj_name = $argl[2];

# requirements
# body
$seq_item = fetch_sprot_seq($sprot_dba, $sprot_id);

if (! defined($seq_item->{$DBA_SEQID}) ) {

  printf " Entry ID '%s' not found.\n", $sprot_id;
  printf " [ A total of %d sequences processed ]\n",
      $seq_item->{$DBA_CNTR};
  exit_error()
}

$seq_hash = {};
$seq_hash->{1} = $seq_item;
$xmldoc = seq2xml( $seq_hash );

print " Sequence '$sprot_id' found.\n";
print " [ Saving as '$obj_name.$SEQUENCE' ]\n";

save_ip_xml( $xmldoc, $obj_name, $SEQUENCE, $WARN_OVERW );

