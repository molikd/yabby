# seq_uniprot.pl

use yabby_sys;
use yabby_seq;

use Getopt::Std;

use Bio::DB::SwissProt;

$USAGE = "
 Fetch a sequence from SwissProt.

 Usage:
        seq_uniprot [ options ] LOCATION IDENTIFIER OBJ_NAME

 Fetch a sequence from SwissProt using an identifier such as the
 sequence accession number (default) or
 unique ID and saves the sequence under the name OBJ_NAME.

 Options:

 -l LOCATION -- possible values (australia,canada,china,korea,switzerland,taiwan,us)

 -a ACCESSION_NUMBER -- fetch sequence by accession number (default)

 -i UNIQUE_ID -- fetch sequence by unique ID

 Notes:

 1. This command requires Bioperl's Bio::DB module.

 Examples:

 seq_uniprot -a P43780 -l australia miga 
 seq_uniprot -i BOLA_HAEIN -l australia migi
";

# options
getopt('ail');

if ( defined($opt_a) ) {
  $opt_a_flag = 1;
  $identifier = $opt_a;
} elsif ( defined($opt_i) ) {
  $opt_i_flag = 1;
  $identifier = $opt_i;
}

if ( defined($opt_l) ) {
  $opt_l_flag = 1;
  $location = $opt_l;
}

if ( ! defined($location)  ) {
  error("need to specify which expasy DB to use:  refer to usage");
}

# initialization
if ( ! $identifier ) {
  @argl = sys_init( @ARGV );
  check_call( @argl, [ 2 ] );
  $identifier = $argl[0];
  $obj_name = $argl[1];
} else {
  @argl = sys_init( @ARGV );
  check_call( @argl, [ 1 ] );
  $obj_name = $argl[0];
}

# body

$sp = new Bio::DB::SwissProt('-servertype' => 'expasy',
                             '-hostlocation' => $location,
                             '-retrievaltype' => 'tempfile',
                             '-format' => 'fasta',);

if ( $opt_i_flag ) {
  $seqz = $sp->get_Seq_by_id($identifier);
} else {
  $seqz = $sp->get_Seq_by_acc($identifier);
}

if ( substr($seqz->{primary_seq}->{desc},0,16) eq "WARNING:  ======" ) {
  error("error condition returned by BioPerl");
}

# initialise sequence object
$seq_hash = {};
add_bioperl_seq($seq_hash, $seqz);

$xmldoc = seq2xml($seq_hash);

printf " Saving '%s' as '%s'\n", $identifier, $obj_name;

save_ip_xml( $xmldoc, $obj_name, $SEQUENCE, $WARN_OVERW );

