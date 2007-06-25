# motif_meme.pl

use yabby_sys;
use yabby_utils;
use yabby_seq;

use Getopt::Std;

# description and usage

$USAGE = "
 Extracts motifs from MEME text output files.

 Usage:
 	meme_motif MEME_OUTPUT MOTIF_NUMBER OBJ_NAME

 Reads the output file MEME_OUTPUT, extracts motif number
 MOTIF_NUMBER and saves motif as OBJ_NAME.

 Notes:

 1. See 'motif_load'.
";

# options
# initialization
@argl = sys_init( @ARGV );

# assign the arguments
check_call( @argl, [ 3 ] );
$meme_output = $argl[0];
$motif_number = $argl[1];
$obj_name = $argl[2];

# requirements
# body
printf " Reading MEME output '%s' ..\n", $meme_output;

$fp = open_for_reading( $meme_output );
$motif_on = 0;
$cntr = -1;
@motif_lines = ();

while ( <$fp> ) {

  $record = $_; chomp( $record );
  @fields = split " ", $record;

  if ( defined($fields[0]) && defined($fields[1]) &&
        defined($fields[2]) && ($fields[0] eq "BL") &&
        ($fields[1] eq "MOTIF") && ($fields[2] eq $motif_number) ) {
    $motif_on = 1;
  }

  if ( ($motif_on == 1) && ($fields[0] eq "//") ) {
    $motif_on = 0;
  }

  if ( $motif_on ) {
    $cntr++;
    if ( $cntr > 0 ) {
       push @motif_lines, $record;
    }
  }
}

close_file( $fp );
if ( $#motif_lines < 0 ) {
  error( "motif $motif_number not found" );
}

# create sequence hash and write out

$seq_hash = {};
$cntr = 0;

for $line ( @motif_lines ) {
  $cntr++;
  @fields = split /\(/, $line;
  $seq_id = trim_end_blanks( $fields[0] );
  @fields2 = split /\)/, $fields[1];
  $offset = trim_end_blanks( $fields2[0] );
  @fields3 = split " ", $fields2[1];

  # @fields3 must contain exactly two items: the sequence
  # and the weight
  if ( $#fields3 != 1 ) {
    print "Record was split as follows:\n";
    print "  fields : |@fields|\n";
    print "  fields2: |@fields2|\n";
    print "  fields3: |@fields3|\n";
    error( "splitting of the motif line no. $cntr unsuccessful" );
  }

  $sequence = $fields3[0];
  $weight = $fields3[1];

  # create sequence entry
  $seq_item = {};
  #$seq_item->{$DBA_SEQID} = "motif" . $motif_number . "seq" . $cntr;
  #$comment = sprintf "id=%s offset=%s weight=%s", $seq_id,
  #   $offset, $weight;
  $seq_item->{$DBA_SEQID} = $seq_id;
  $comment = sprintf "offset=%s weight=%s", $offset, $weight;
  $seq_item->{$DBA_COMMENT} = $comment;
  $seq_item->{$DBA_SEQUENCE} = $sequence;
  $seq_hash->{$cntr} = $seq_item;
}

printf " Motif %s saved as '%s'.\n", $motif_number, $obj_name;

$xmldoc = seq2xml( $seq_hash );
save_ip_xml( $xmldoc, $obj_name, $MOTIF, $WARN_OVERW );

