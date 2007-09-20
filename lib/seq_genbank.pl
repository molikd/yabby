# seq_genbank.pl

use yabby_sys;
use yabby_seq;

use Getopt::Std;

use Bio::DB::GenBank;

$USAGE = "
 Fetch a sequence from GenBank.

 Usage:
        seq_genbank [ options ] IDENTIFIER OBJ_NAME

 Fetch a sequence from GenBank using an identifier such as the
 sequence accession number (default), version, GI number or
 unique ID (locus) and save the sequence under the name OBJ_NAME.

 Options:

 -a ACCESSION_NUMBER (default) - fetch sequence by accession number

 -v VERSION -- fetch sequence by version number

 -g GI_NUMBER -- fetch sequence by GI number

 -i UNIQUE_ID -- fetch sequence by unique ID

 Notes:

 1. This command requires Bioperl's Bio::DB module.

 Examples:

 seq_genbank -a J00522    miga 
 seq_genbank -v J00522.1  migv
 seq_genbank -g 195052    migg
 seq_genbank -i MUSIGHBA1 migi
";

# options
getopt('avgi');

if ( defined($opt_a) ) {
  $opt_a_flag = 1;
  $identifier = $opt_a;
} elsif ( defined($opt_v) ) {
  $opt_v_flag = 1;
  $identifier = $opt_v;
} elsif ( defined($opt_g) ) {
  $opt_g_flag = 1;
  $identifier = $opt_g;
} elsif ( defined($opt_i) ) {
  $opt_i_flag = 1;
  $identifier = $opt_i;
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

$gb = new Bio::DB::GenBank(-retrievaltype=>'tempfile', -format=>'fasta');

if ( $opt_v_flag  ) {
  $seqz = $gb->get_Seq_by_version($identifier);
} elsif ( $opt_g_flag ) {
  $seqz = $gb->get_Seq_by_gi($identifier);
} elsif ( $opt_i_flag ) {
  $seqz = $gb->get_Seq_by_id($identifier);
} else {
  $seqz = $gb->get_Seq_by_acc($identifier);
}

if ( ! defined($seqz)  ) {
  error("error condition returned by BioPerl");
}

$seq_hash = bioperl2seq($seqz);

$xmldoc = seq2xml($seq_hash);

printf " Saving '%s' as '%s'\n", $identifier, $obj_name;

save_ip_xml( $xmldoc, $obj_name, $SEQUENCE, $WARN_OVERW );

