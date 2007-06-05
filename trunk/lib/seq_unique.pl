# seq_unique.pl

use yabby_sys;
use yabby_seq;
use yabby_utils;

use Getopt::Std;

$USAGE = "
 Finds unique sequences in one sequence object relative to another
 by comparing sequence strings.

 Usage:
 	seq_unique SEQ1_OBJ SEQ2_OBJ OBJ_NAME

 This command will find unique sequences in SEQ1_OBJ compared
 to SEQ2_OBJ, and store unique sequences as OBJ_NAME.

 Notes:

 1. Sequences present in the first sequence object and not present
 in the second second object are calculated. Therefore the order
 of sequence objects given in the argument matters.

 2. This command compares sequence letters as opposed to seq_op
 which compares sequence IDs. Two sequences are identical if they
 are an exact letter-by-letter match.
";

# options
# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 3 ] );
$seq1 = $argl[0];
$seq2 = $argl[1];
$obj_name = $argl[2];

# requirements
requirements( $seq1, $SEQUENCE );
requirements( $seq2, $SEQUENCE );

$xmldoc = load_ip_xml( $seq1, $SEQUENCE );
$seq1hash = xml2seq( $xmldoc );

$xmldoc = load_ip_xml( $seq2, $SEQUENCE );
$seq2hash = xml2seq( $xmldoc );

# body
$keys1 = get_seq_keys( $seq1hash );
$keys2 = get_seq_keys( $seq2hash );

my $cntr = 0;
my $seq_hash = {};

for $key1 ( @$keys1 ) {

  $seq_item1 = $seq1hash->{$key1};
  $seq_comment = $seq_item1->{$DBA_COMMENT};
  $s1 = $seq_item1->{$DBA_SEQUENCE};

  $matches = 0;

  for $key2 ( @$keys2 ) {

    $seq_item2 = $seq2hash->{$key2};
    $s2 = $seq_item2->{$DBA_SEQUENCE};

    if ( $s1 eq $s2 ) {

      $matches++;
    }
  }

  if ( $matches == 0 ) {

    $cntr++;
    $seq_hash->{$cntr} = $seq_item1;

  } elsif ( $matches > 1 ) {

    printf " Warning: sequence '%s' matched %d times\n", $seq_comment, $cntr; 
  }
}

if ( $cntr > 0 ) {

  print " $cntr unique sequences found.\n";

  $xmldoc = seq2xml( $seq_hash );
  save_ip_xml( $xmldoc, $obj_name, $SEQUENCE, $WARN_OVERW );

} else {

  print " No unique sequences found.\n";
}

