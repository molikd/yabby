# sprot_fetch.pl

use yabby_sys;
use yabby_seq;

# sprot_fetch test.dat 104K_THEAN
# OS: Theileria annulata.
  
# sprot_fetch test.dat 13S1_FAGES
# OS: Fagopyrum esculentum (Common buckwheat).

# sprot_fetch test.dat 1433T_RABIT
# OS: Oryctolagus cuniculus (Rabbit).

$USAGE = "
 Fetches a sequence from a SWISS-PROT database by its ID.

 Usage:
 	sprot_fetch <DBA_FILE> <SPROT_ID>

 Where <DBA_FILE> is the database is the Swiss-Prot format,
 and <SPROT_ID> is the swiss-prot sequence ID. Prints the
 sequence ID, organism, and sequence letters.
";

# options
# initialization
@argl = sys_init( @ARGV );

check_call( @argl, [ 2 ] );
$sprot_dba  = $argl[0];
$sprot_id  = $argl[1];

# requirements
# body
$seq_item = fetch_sprot_seq($sprot_dba, $sprot_id);

if (! defined($seq_item->{$DBA_SEQID}) ) {

  printf " Entry with ID '%s' not found.\n", $sprot_id;
  printf " A total of %d sequences processed\n", $seq_item->{$DBA_CNTR};

} else {

  printf " Sequence ID: '%s'\n", $seq_item->{$DBA_SEQID};
  printf " Organism: '%s'\n", $seq_item->{$DBA_OS};
  print " Sequence:\n";

  print_seq( *STDOUT, $seq_item->{$DBA_SEQUENCE}, $PRINT_WIDTH );
}

