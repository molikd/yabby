# seq_info.pl

use yabby_sys;
use yabby_seq;
use yabby_utils;

use Getopt::Std;

$USAGE = "
 Prints information about the sequence object.

 Usage:
 	seq_info [ options ] OBJ_NAME

 Where OBJ_NAME is the name of an existing sequence
 object.

 Options:

 -l -- long output. When multiple sequences are present,
 print the number of residues for each sequence. By
 default, only a short summary is printed 

 -n -- print only the number of residues in each
 sequence
";

# options
getopts('ln');

if ( defined( $opt_l ) ) {
  $opt_l_flag = 1;
} else {
  $opt_l_flag = 0;
}

if ( defined( $opt_n ) ) {
  $opt_n_flag = 1;
} else {
  $opt_n_flag = 0;
}

# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 1 ] );
$obj_name  = $argl[0];

# requirements
requirements( $obj_name, $SEQUENCE );
$xmldoc = load_ip_xml( $obj_name, $SEQUENCE );

# body
$seq_hash = xml2seq( $xmldoc );
$keys = get_seq_keys( $seq_hash );
printf " '%s' contains %d sequence(s)\n", $obj_name, $#{$keys}+1;

# if a single sequence, do long output by default 
if ( ($#{$keys} == 0) || $opt_l_flag ) {
  for $key ( @$keys ) {
    $seq_item = $seq_hash->{$key};
    $seq_id = $seq_item->{$DBA_SEQID};
    @seq_char = split //, $seq_item->{$DBA_SEQUENCE};
    printf " %2d -> %s, %d residues\n", $key, $seq_id, $#seq_char+1;
  }
} elsif ( $opt_n_flag ) {
  for $key ( @$keys ) {
    $seq_item = $seq_hash->{$key};
    $seq_id = $seq_item->{$DBA_SEQID};
    @seq_char = split //, $seq_item->{$DBA_SEQUENCE};
    printf "%d\n", $#seq_char+1;
  }

} else { # short output
  # find the min/max number of residues
  $n_min = $INFINITY;
  $n_max = 0;
  $min_seqid = $max_seqid = "NONE";
  for $key ( @$keys ) {
    $seq_item = $seq_hash->{$key};
    $seq_id = $seq_item->{$DBA_SEQID};
    @seq_char = split //, $seq_item->{$DBA_SEQUENCE};
    if ( ($#seq_char+1) < $n_min ) {
      $n_min = $#seq_char+1;
      $min_seqid = $seq_id;
    }
    if ( ($#seq_char+1) > $n_max ) {
      $n_max = $#seq_char+1;
      $max_seqid = $seq_id;
    }
  }
  printf "   min number of residues: %d (sequence '%s')\n", $n_min, $min_seqid;
  printf "   max number of residues: %d (sequence '%s')\n", $n_max, $max_seqid;
}

