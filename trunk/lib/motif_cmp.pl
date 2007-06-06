# motif_cmp.pl

use yabby_sys;
use yabby_seq;
use yabby_utils;

use Getopt::Std;

$USAGE = "
 Compares two sequence motifs.

 Usage:
 	motif_cmp MOTIF1_OBJ MOTIF2_OBJ

 Compares two motifs.  Two motifs are equal if they have the
 same number of sequences, the sequences have the same ID,
 and the sequences themselves are identical as strings.
";

# options
# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 2 ] );
$motif1 = $argl[0];
$motif2 = $argl[1];

# requirements
requirements( $motif1, $MOTIF );
requirements( $motif2, $MOTIF );

$xmldoc = load_ip_xml( $motif1, $MOTIF );
$motif1hash = xml2seq( $xmldoc );

$xmldoc = load_ip_xml( $motif2, $MOTIF );
$motif2hash = xml2seq( $xmldoc );

# body
$keys1 = get_seq_keys( $motif1hash );
$keys2 = get_seq_keys( $motif2hash );

$motif1IDs = get_seq_ids( $motif1hash );
$motif2IDs = get_seq_ids( $motif2hash );

$setop = unindi( $motif1IDs, $motif2IDs );

$union = $setop->[0];
$isect = $setop->[1];
$diff = $setop->[2];

if ( $#{$diff}+1 != 0 ) {
  printf " Found %d sequence(s) in '%s'\n", $#{$keys1}+1, $motif1;
  printf " Found %d sequence(s) in '%s'\n", $#{$keys2}+1, $motif2;
  printf "  INTERSECTION contains %d sequence(s)\n", $#{$isect}+1;
  printf "  DIFFERENCE contains %d sequence(s)\n", $#{$diff}+1;
  printf "  UNION contains %d sequence(s)\n", $#{$union}+1;
  print "\n Motifs '$motif1' and '$motif2' are different by sequence IDs.\n";
  exit_ok;
}

printf " Motifs '$motif1' and '$motif2' contain the same sequence IDs.\n";
printf " Comparing the sequences...";

for $id ( @$motif1IDs ) {
  $sequence1 = get_seq_by_id( $id, $motif1hash );
  $sequence2 = get_seq_by_id( $id, $motif2hash );
  if ( $sequence1 ne $sequence2 ) {
    printf " difference in '$id' found.\n";
    printf "\n Motifs '$motif1' and '$motif2' are different.\n";
    exit_ok;
  }
}

printf "\n Motifs '$motif1' and '$motif2' are identical.\n"

