# seq_compl.pl

use yabby_sys;
use yabby_seq;
use yabby_utils;

use Getopt::Std;

$USAGE = "
 Calculates sequence complement (for DNA sequences).

 Usage:
 	seq_compl [ options ] OBJ_NAME OBJ_NAME_NEW

 Where OBJ_NAME is the name of an existing sequence object,
 the complement sequence will be saved under the name
 OBJ_NAME_NEW. The sequence OBJ_NAME must be a DNA sequence.

 Options:
 -r -- Calculate reverse complement.
";

# options
getopts('r');

if ( defined($opt_r) ) {
  $opt_r_flag = 1;
} else {
  $opt_r_flag = 0;
}

# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 2 ] );
$obj_name  = $argl[0];
$obj_name2  = $argl[1];

# requirements
requirements( $obj_name, $SEQUENCE );
$xmldoc = load_ip_xml( $obj_name, $SEQUENCE );

# body
$seq_hash = xml2seq( $xmldoc );
$keys = get_seq_keys( $seq_hash );

printf " '%s' contains %d sequence(s)\n", $obj_name, $#{$keys}+1;

$seq_hash2 = {};

for $key ( @$keys ) {

  $seq_item = $seq_hash->{$key};

  print " Working on '$seq_item->{$DBA_SEQID}'\n";

  @seq_array = split //, $seq_item->{$DBA_SEQUENCE};
  @seq_compl = ();

  foreach $c ( @seq_array ) {
     push @seq_compl, dna_compl($c); 
  }

  $seq_string = join "", @seq_compl;

  if ( $opt_r_flag ) {
    $seq_string = reverse($seq_string);
  }

  $seq_item2 = {};
  $seq_item2->{$DBA_SEQID} = $seq_item->{$DBA_SEQID};
  $seq_item2->{$DBA_COMMENT} = $seq_item->{$DBA_COMMENT};
  $seq_item2->{$DBA_SEQUENCE} = $seq_string;
  $seq_hash2->{$key} = $seq_item2;
}

$xmldoc = seq2xml( $seq_hash2 );
save_ip_xml( $xmldoc, $obj_name2, $SEQUENCE, $WARN_OVERW );

# subroutines
sub dna_compl {

  my ( $c ) = @_;
  
  $c = lc($c);

  if ( $c eq "a" ) {
    $r = "t";
  } elsif ( $c eq "t" ) {
    $r = "a";
  } elsif ( $c eq "g" ) {
    $r = "c";
  } elsif ( $c eq "c" ) {
    $r = "g";
  } else {
     error( "character '$c' found, must be a DNA sequence" )
  }

  return $r;
}

