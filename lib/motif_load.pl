# motif_load.pl

use yabby_sys;
use yabby_seq;

use Getopt::Std;

$USAGE = "
 Loads sequence motif.

 Usage:
 	motif_load [ options ] DBA_FILE OBJ_NAME

 Where DBA_FILE is the name of the database file. OBJ_NAME is
 the internal YABBY name for this motif. 

 Options:

 -f -- the file format is FASTA (default)
 -b -- the file format is BLOCKS

 Notes:

 1. A 'motif' object is internally identical to the 'sequence' object.
 2. Only BLOCKS format as given by MEME output was tested.
";

# options
getopts('fb');

if ( defined($opt_f) ) {
  $file_format = "fasta";
} elsif ( defined($opt_b) ) {
  $file_format = "blocks";
} else {
  $file_format = "fasta";
}

# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 2 ] );
$dba_file  = $argl[0];
$obj_name  = $argl[1];

# requirements
# body
print " Reading the file '$dba_file' ..\n";

if ( $file_format eq "fasta" ) {
  $seq_hash = read_fasta( $dba_file );
} elsif ( $file_format eq "blocks" ) {
  $seq_hash = read_blocks( $dba_file );
} else {
  error( "unknown file format" );
}

$keys = get_seq_keys( $seq_hash );
printf " %d sequence(s) found in the motif '$obj_name'.\n", $#{$keys}+1;
$xmldoc = seq2xml( $seq_hash );
save_ip_xml( $xmldoc, $obj_name, $MOTIF, $WARN_OVERW );

