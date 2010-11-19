# seq_genbank.pl

use yabby_sys;
use yabby_seq;

use Getopt::Std;

use Bio::DB::GenBank;

$USAGE = "
 Fetch a sequence from GenBank.

 Usage:
        seq_genbank FILE_NAME OBJ_NAME

 Fetches a list of sequences from GenBank using an identifier such
 as the sequence accession number (default), version, GI number or
 unique ID (locus) and save the sequence under the name OBJ_NAME.
 The identifier list consists of GI_NUMBERs read from the file
 FILE_NAME, arranged as one identifier per line.

 The sequences will be stored in the object OBJ_NAME.

 Notes:

 1. This command requires Bioperl's Bio::DB module.
";

# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 2 ] );
$file_name = $argl[0];
$obj_name = $argl[1];

# body

# read the GIs file
$file = open_for_reading( $file_name );
@file_lines = <$file>;
close_file( $file );

# initialise sequence object
$seq_hash = {};

# initialise bioperl
$gb = new Bio::DB::GenBank(-retrievaltype=>'tempfile', -format=>'fasta');

# loop over all sequence GIs, attempt to fetch each
foreach ( @file_lines ) {

  $identifier = $_; chomp($identifier);

  printf " Attempting to fetch the sequence |%s| ...", $identifier;

  $seqz = $gb->get_Seq_by_gi($identifier);

  if ( ! defined($seqz)  ) {
    error("error condition returned by BioPerl");
  } else {
    print " done\n";
  } 

  # add to the sequence object
  add_bioperl_seq($seq_hash, $seqz);
}

# convert to XML
$xmldoc = seq2xml($seq_hash);

printf " Saving sequences as '%s'\n", $obj_name;

save_ip_xml( $xmldoc, $obj_name, $SEQUENCE, $WARN_OVERW );

