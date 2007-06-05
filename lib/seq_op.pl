# seq_op.pl

use yabby_sys;
use yabby_seq;
use yabby_utils;

use Getopt::Std;

$USAGE = "
 Calculates union/intersection/difference of two sequence objects
 by usind sequence IDs.

 Usage:
 	seq_op [ options ] SEQ1_OBJ SEQ2_OBJ RES_OBJ

 Calculates union/intersection/difference of two sequence objects
 SEQ1_OBJ and SEQ2_OBJ, and stores the result as the sequence
 object RES_OBJ.

 Options:

 -u -- calculate the union (default)
 -i -- calculate the intersection 
 -d -- calculate the difference

 Caveats:

 1. The calculation will fail if there are duplicate sequences in
 one set. For example, if two sets of sequences have no sequence
 in common, but one set of sequences contains two copies of the
 sequence 'F36.5845', the intersection of the two sets will contain
 this sequence. 
";

# options
getopts('uidc');

if ( defined($opt_i) ) {
  $ISECT = 1;
} else {
  $ISECT = 0;
}

if ( defined($opt_d) ) {
  $DIFF = 1;
} else {
  $DIFF = 0;
}

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

$seq1IDs = get_seq_ids( $seq1hash );
$seq2IDs = get_seq_ids( $seq2hash );

$setop = unindi( $seq1IDs, $seq2IDs );

$union = $setop->[0];
$isect = $setop->[1];
$diff = $setop->[2];

printf " Found %d sequence(s) in '%s'\n", $#{$keys1}+1, $seq1;
printf " Found %d sequence(s) in '%s'\n", $#{$keys2}+1, $seq2;
printf "  INTERSECTION contains %d sequence(s)\n", $#{$isect}+1;
printf "  DIFFERENCE contains %d sequence(s)\n", $#{$diff}+1;
printf "  UNION contains %d sequence(s)\n", $#{$union}+1;

if ( $ISECT ) {
  printf " [ Saving INTERSECTION as '%s' ]\n", $obj_name;
  @op_array = @$isect;

} elsif ( $DIFF ) {
  printf " [ Saving DIFFERENCE as '%s' ]\n", $obj_name;
  @op_array = @$diff;

} else {

  printf " [ Saving UNION as '%s' ]\n", $obj_name;
  @op_array = @$union;
}

$seq_id_hash = {};

for $key ( @$keys1 ) {
  $seq_item = $seq1hash->{$key};
  $id = $seq_item->{$DBA_SEQID};
  $seq_id_hash->{$id} = $seq_item; 
}

for $key ( @$keys2 ) {
  $seq_item = $seq2hash->{$key};
  $id = $seq_item->{$DBA_SEQID};
  $seq_id_hash->{$id} = $seq_item; 
}

$seq_hash = {};
$cntr = 0;

for $id ( @op_array ) {
  $cntr++;
  $seq_item = $seq_id_hash->{$id};
  $seq_hash->{$cntr} = $seq_item;
}

$xmldoc = seq2xml( $seq_hash );

save_ip_xml( $xmldoc, $obj_name, $SEQUENCE, $WARN_OVERW );

