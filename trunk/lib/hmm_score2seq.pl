# hmm_score2seq.pl

use yabby_sys;
use yabby_seq;
use yabby_hmm;
use yabby_utils;

use Getopt::Std;

$USAGE = "
 Fetches and saves sequences whose ID's are given in the HMM scores
 objects created by the command 'hmm_score'.

 Usage:
  hmm_score2seq [ options ] DBA_FILE OUT_FILE OBJ_NAME

 Where DBA_FILE is the sequence database, OUT_FILE is the output file
 with sequences (to be created), and OBJ_NAME is the name under which
 the scores were saved with 'hmm_score'.

 Options:

 -w WIDTH -- Set the width of the sequence string per line written
 to the OUT_FILE (default: width=60)

 -m MODEL -- Extract only sequences that matched a particular HMM
 model. If this option is not activated all matches are written to
 the output file and sequence IDs are written as SEQID\@PFAM_MODEL.
 If this option is activated the sequence IDs are written only as
 SEQID.

 -c -- Do NOT embed the matching model and maching score into sequence
 comment.

 Notes:

 1. Sequence database file DBA_FILE must be in FASTA format.
";

# options
getopt('wm');

if ( defined($opt_w) ) {
  if ( ! unsig_int($opt_w) ) {
    error("when specifying -w an integer must follow");
  } else {
    $opt_w_value = $opt_w;
  }
} else {
  $opt_w_value = $PRINT_WIDTH; 
}

if ( defined($opt_m) ) {
  $opt_m_flag = 1;
  $opt_m_value = $opt_m;
} else {
  $opt_m_flag = 0;
  $opt_m_value = undef;
}

getopts('c');

if ( defined($opt_c) ) {
  $opt_c_value = 1;
} else {
  $opt_c_value = 0;
}

# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [3] );
$dba_file = $argl[0];
$output_file = $argl[1];
$hmm_item = $argl[2];

# requirements
requirements( $hmm_item, $HMM_SCORE );
$hmm_scores = load_ip( $hmm_item, $HMM_SCORE );

if ($#{$hmm_scores} == -1) {
  print " No matches found.\n";
  exit(0);
}

# body
# repackage $hmm_scores so to split sequence ID and HMM model
$hmm_scores2 = [];

for $item ( @$hmm_scores ) {

  $match_id = $item->[0];
  $match_score = $item->[1];
  # get sequence ID and HMM model from $match_id
  @words = split /\@/, $match_id;
  $seq_id = $words[0];
  $hmm_model = $words[1];

  if ( $opt_m_flag ) {
    if ( $hmm_model eq $opt_m_value ) {
      push @$hmm_scores2,  [ $seq_id, $hmm_model, $match_score ];
    }
  } else {
    push @$hmm_scores2, [ $seq_id, $hmm_model, $match_score ];
  }
}

if ( $#{$hmm_scores2} == - 1 ) {
  print " the HMM model '$opt_m_value' not found";
  print " in '$hmm_item.$HMM_SCORE'\n";
  error( "no sequences to extract" );
} else {
  printf " found %d sequences to extract\n", $#{$hmm_scores2} + 1;
}

$hits_list = [];
printf " Processing the database '%s'\n", $dba_file;
$fp = open_for_reading( $dba_file );
do { $record = <$fp> } until $. == 1 || eof;
chomp( $record );
@fields = split //, $record;
if ( $fields[0] ne ">" ) {
  error( "database does not start with '>'" );
}
shift @fields;
$comment = join "", @fields;
$sequence = "";
$seqstr = "";
$db_entry_line = 1;

$cntr = 1;
while ( <$fp> ) {

  $cntr++;
  $record = $_;
  chomp( $record );
  @fields = split //, $record;

  if ( defined($fields[0]) && ($fields[0] eq ">") ) {

    if ( $db_entry_line == 1 ) {
      error("improper FASTA file: comment without sequence (line $cntr)");
    }

    $db_entry_line = 0;
    if ( $cntr > 1 ) {
      add_hits_list( $hits_list, $hmm_scores2, $comment, $sequence );
    }
  }

  $db_entry_line++;

  if ( $db_entry_line == 1 ) {

    shift @fields;
    $comment = join "", @fields;
    $sequence = "";
  } else {

    $seqstr = join "", @fields;
    @fields2 = split / /, $seqstr;
    $seqstr = join "", @fields2;
    $sequence = $sequence . $seqstr;
  }
}

add_hits_list( $hits_list, $hmm_scores2, $comment, $sequence );
close_file( $fp );

# sort hits list by the score
%index_hash = ();
for $ii (0 .. $#{$hits_list}) {
  $index_hash{$ii} = $hits_list->[$ii]->[2];
}

@sorted_ix = ();

for $ix ( sort { $index_hash{$a} <=> $index_hash{$b} }
  keys %index_hash ) {
  push @sorted_ix, $ix;
}

# create sequence hash and write out
$seq_hash = {};
$cntr = 0;

for $ii ( @sorted_ix ) {
  $cntr++;
  $hits_list_entry = $hits_list->[$ii];

  if ( $opt_c_value ) {
     $comment = $hits_list_entry->[3];

  } else {
     $comment = sprintf "score: %.2e, model: %s", $hits_list_entry->[2],
  	$hits_list_entry->[1];
     $comment = sprintf "(%s) %s", $comment, $hits_list_entry->[3];
  }

  $seq_item = {};
  # If matches to a particular model are requested,  the sequence IDs
  # are not altered. If all matches are requested to be written out,
  # @PFAM_MODEL is added to the sequence ID to have SEQID@PFAM_MODEL
  # as sequence IDs.  This is to avoid duplication of sequence IDs
  # in the output file for sequences that matched more then one model.
  if ( $opt_m_flag ) {
    $seq_item->{$DBA_SEQID} = $hits_list_entry->[0];

  } else {
    $seq_item->{$DBA_SEQID} = $hits_list_entry->[0] . "@" .
      $hits_list_entry->[1];
  }

  $seq_item->{$DBA_COMMENT} = $comment;
  $seq_item->{$DBA_SEQUENCE} = $hits_list_entry->[4];
  $seq_hash->{$cntr} = $seq_item;
}

@keys = sort { $a <=> $b } keys %$seq_hash;
$fp = open_for_writing( $output_file );

for $key ( @keys ) {
  $seq_item = $seq_hash->{$key};
  if ( $opt_c_value ) {
    print_seq_fasta($fp, $seq_item, $opt_w_value, 1);
  } else {
    print_seq_fasta($fp, $seq_item, $opt_w_value);
  }
}
close_file( $fp );

printf " Sequences written to '%s'\n", $output_file;

# subroutines
sub add_hits_list {
  my ( $hits_list, $hmm_scores2, $comment, $sequence ) = @_;
  my ( @fields, $dba_id, $match, $item );
  @fields = split " ", $comment;
  $dba_id = $fields[0];
  $match = 0;
  for $item ( @$hmm_scores2 ) {
    if ( $item->[0] eq $dba_id ) {
      $match++;
      push @$hits_list, [ $item->[0], $item->[1], $item->[2],
	$comment, $sequence ];
    }
  }
}

