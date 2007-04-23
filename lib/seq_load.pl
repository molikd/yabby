# seq_load.pl

use yabby_sys;
use yabby_seq;

use Getopt::Std;

$USAGE = "
 Loads sequence(s) from the database file.

 Usage:
 	seq_load [ options ] DBA_FILE OBJ_NAME

 Where DBA_FILE is the name of the database file. OBJ_NAME is
 the internal Yabby name for the sequence(s).

 Options:

 -a -- append sequences to an already existing sequence
  object OBJ_NAME
 -f -- the file format is FASTA (default)
 -b -- the file format is BLOCKS

 Notes:
 1. Only BLOCKS format as given by MEME output was tested.
";

# options
getopts('afb');

if ( defined($opt_a) ) {
  $append_flag = 1;
} else {
  $append_flag = 0;
}

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
printf " %d sequence(s) found.\n", $#{$keys}+1;

if ( $append_flag ) {
  if ( exists_ip( $obj_name, $SEQUENCE ) ) {
    $xmldoc = load_ip_xml( $obj_name, $SEQUENCE );
    $seq_hash2 = xml2seq( $xmldoc );
    $keys2 = get_seq_keys( $seq_hash2 );
    $n = $#{$keys2}+1;
    for $ii ( 1 .. $#{$keys}+1 ) {
      $seq_hash2->{$n+$ii} = $seq_hash->{$ii};
    }
    $xmldoc = seq2xml( $seq_hash2 );
  } else {
    error( "'$obj_name.$SEQUENCE' does not exist" );
  }
} else {
  $xmldoc = seq2xml( $seq_hash );
}

save_ip_xml( $xmldoc, $obj_name, $SEQUENCE, $WARN_OVERW );

