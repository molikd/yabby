# mol2seq.pl

use yabby_sys;
use yabby_mol;
use yabby_seq;

$USAGE = "
 Creates the amino acid sequence from a molecule.

 Usage:
	mol2seq OBJ_NAME

 where OBJ_NAME is the name of an existing 'mol' object.
";

# options
# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 1 ] );
$obj_name = $argl[0];

# requirements
requirements( $obj_name, $MOLECULE );
$mol = load_ip( $obj_name, $MOLECULE );

# body
$resi_crnt = $mol->[0][0];
$sequence = aa3to1( $mol->[0][1] );

$cntr = 1;

for $ii ( 1 .. $#{$mol} ) {

  $resi_next = $mol->[$ii][0];   

  if ( $resi_next != $resi_crnt ) {

    $cntr++;

    if ( $resi_next != ($resi_crnt + 1) ) {

      printf " WARNING: a non-sequential residue: %4d %-4s\n",
          $mol->[$ii][0], $mol->[$ii][1];
    }

    $resi_crnt = $resi_next;
    $res_lett = aa3to1( $mol->[$ii][1] );
    $sequence = $sequence . $res_lett;
  }
}

printf " %d residues found in the molecule '$obj_name'\n", $cntr;

$comment = "$obj_name Created by yabby/mol2pdb";

$seq_item = {};
$seq_item->{$DBA_SEQID} = "MOL:" . $obj_name;
$seq_item->{$DBA_COMMENT} = $comment;
$seq_item->{$DBA_SEQUENCE} = $sequence;

$seq_hash = {};
$seq_hash->{1} = $seq_item;

$xmldoc = seq2xml( $seq_hash );

save_ip_xml( $xmldoc, $obj_name, $SEQUENCE, $WARN_OVERW );

