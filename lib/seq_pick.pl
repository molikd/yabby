# seq_pick.pl

use yabby_sys;
use yabby_seq;
use yabby_utils;

use Getopt::Std;

$USAGE = "
 Extracts a subset of sequences from the sequence object.

 Usage:

    seq_pick [ options ] OBJ_NAME OBJ_NAME_NEW

 where OBJ_NAME is the name of an existing sequence object,
 and OBJ_NAME_NEW is the name of the sequence object to
 be created.

 Options:

 -n RANGE -- extract the sequence by sequence number. The
 parameter RANGE can be a single integer, in which the
 sequence with this sequence number will be extracted.
 Alternatively, RANGE can contain two integers separated
 by a colon such as N:M. In this case the sequences which
 have the sequence number between N and M will be extracted
 (inclusive). 

 -q SEQID -- pick a sequence with the sequence ID SEQID

 -l MIN:MAX -- pick sequences whose length is between MIN
 and MAX
";

# options
getopt('nql');

if ( defined( $opt_n ) ) {
  $opt_n_flag = 1;
  $opt_n_value = $opt_n;
} else {
  $opt_n_flag = 0;
}

if ( defined( $opt_q ) ) {
  $opt_q_flag = 1;
  $opt_q_value = $opt_q;
} else {
  $opt_q_flag = 0;
}

if ( defined( $opt_l ) ) {
  $opt_l_flag = 1;
  $fields = split_on_colon($opt_l);
  $MIN_LEN = $fields->[0];
  $MAX_LEN = $fields->[1];
  if ( (! unsig_int($MIN_LEN)) ||  (! unsig_int($MAX_LEN)) ) {
    error("-l option <MIN> and <MAX> must be unsigned integers");
  }
} else {
  $opt_l_flag = 0;
}

# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 2 ] );
$obj_name = $argl[0];
$obj_name2 = $argl[1];

# requirements
requirements( $obj_name, $SEQUENCE );
$xmldoc = load_ip_xml( $obj_name, $SEQUENCE );
$seq_hash = xml2seq( $xmldoc );

# body
$keys = get_seq_keys( $seq_hash );

if ( $opt_n_flag ) { 

  if ( $opt_n_value =~ /:/ ) {
    @fields = split ":", $opt_n_value;
    $MIN_SEQ = $fields[0];
    $MAX_SEQ = $fields[1];
    if ( (! unsig_int($MIN_SEQ)) ||  (! unsig_int($MAX_SEQ)) ) {
      error("the range of sequences must be given as integers");
    }
    if ( $MIN_SEQ > $MAX_SEQ ) {
      error("minimum sequence number is greater than the maximum");
    }
    $sequence_range = 1;
  } else {
    $TARG_SEQN = $opt_n_value;
    if (! unsig_int($TARG_SEQN)) {
      error("the sequence number must be an integers");
    }
    $sequence_range = 0;
  }

  if ( $sequence_range ) {
    $seq_hash2 = {};
    $cntr = 0;
    for $key ( @$keys ) {
      $seq_item = $seq_hash->{$key};
      if ( ($key>=$MIN_SEQ) && ($key<=$MAX_SEQ) ) {
        $cntr++;
        $seq_hash2->{$cntr} = $seq_item; 
      }
    }
  } else {
    if ( $TARG_SEQN > ($#{$keys}+1) ) {
      printf " Only %d sequences available\n", $#{$keys}+1;
      error( "Too high sequence number requested ($seq_num)" );
    }
    $seq_item = $seq_hash->{$TARG_SEQN};
    printf " Fetching the sequence %d ('%s')\n", $TARG_SEQN,
      $seq_item->{$DBA_SEQID};
    $seq_hash2 = {};
    $seq_hash2->{1} = $seq_item;
  }

} elsif ( $opt_q_flag ) {
  $match = 0;
  for $key ( @$keys ) {
    $seq_item = $seq_hash->{$key};
    $seq_id = $seq_item->{$DBA_SEQID};
    if ( $opt_q_value eq $seq_id ) {
      $match++;
      $seq_targ = $seq_item;
    }
  }

  if ( $match == 0 ) {
    error( "The set '$obj_name' does not contain sequence '$opt_q_value'" );
  } elsif ( $match > 1 ) {
    error( "Sequence ID '$opt_q_value' matches $match sequences (>1)" );
  } else {
    printf " Fetching the sequence '$opt_q_value'\n";
    $seq_hash2 = {};
    $seq_hash2->{1} = $seq_targ;
  }
} elsif ( $opt_l_flag )  {
  $seq_hash2 = {};
  $cntr = 0;
  for $key ( @$keys ) {
    $seq_item = $seq_hash->{$key};
    @seq_char = split //, $seq_item->{$DBA_SEQUENCE};
    if ( (($#seq_char+1)>=$MIN_LEN) && (($#seq_char+1)<=$MAX_LEN) ) {
      $cntr++;
      $seq_hash2->{$cntr} = $seq_item; 
    }
  }
  if ( $cntr == 0 ) {
    error( "no sequences matched" );
  } else {
    print " $cntr sequence(s) matched\n";
  }
} else {
  error( "no selection criteria specified" );
}

print " Saving the extracted sequence as '$obj_name2'\n";

$xmldoc = seq2xml( $seq_hash2 );

save_ip_xml( $xmldoc, $obj_name2, $SEQUENCE, $WARN_OVERW );

