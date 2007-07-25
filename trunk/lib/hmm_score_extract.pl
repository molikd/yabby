# hmm_score_extract.pl

use yabby_sys;
use yabby_hmm;

use Getopt::Std;

$USAGE = "
 Fetches hits from the HMMER (HMMPFAM) search output file.

 Usage:
 	hmm_score_extract [options] HMMPFAM_OUT

 Where HMMPFAM_OUT is the HMMPFAM output file.

 Options:

 -E CUTOFF -- Define cutoff for acceptable E values (default: CUTOFF=0.01)

 -s HMM_ITEM -- Save the scores under the name HMM_ITEM

 -d -- Turn debuggin on. This will create the file hmm_scores.opt_d_flag
  with raw scores.
";

# options
getopt('Es');

if ( defined($opt_E) ) {
  $opt_E_value = $opt_E;
} else {
  $opt_E_value = $E_CUTOFF_DEFAULT;
}

if ( defined($opt_s) ) {
  $opt_s_flag = 1;
  $opt_s_value = $opt_s;
} else {
  $opt_s_flag = 0;
}

getopts('d');

if ( defined($opt_d) ) {
  $opt_d_flag = 1;
} else {
  $opt_d_flag = 0;
}

# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 1 ] );
$hmmpfam_out  = $argl[0];

# requirements
# body
printf " Processing HMMPFAM search output file\n";
$file = open_for_reading( $hmmpfam_out );
$seq_score = 0;
@accept_scores = ();

while( <$file> ) {

  $line = $_; chomp( $line );

  if ( $line =~ "Query sequence:" ) {
    @fields = split " ", $line;
    $query_seq = $fields[2];
  }

  if ( $line =~ "Scores for sequence family classification" ) {
    $seq_score = 1;
    $score_type = "entire_sequence";
  }

  if ( $line eq "" ) {
    $seq_score = 0;
  }

  if ( $seq_score ) {

    $seq_score++;

    if ( ( $seq_score > 2) && # not the anchor line
         (substr($line,0,5) ne "Model") &&
         (substr($line,0,5) ne "-----") &&
         ( $line ne "\t[no hits above thresholds]" ) ) {

      @fields = split " ", $line;
      $pfam_model = $fields[0];
      $E = $fields[-2];

      if ( $E < $opt_E_value ) {

        push @accept_scores,
         [ $E, $query_seq . "\@" . $pfam_model, $score_type ];
      }
    }
  }

  if ( $line =~ "Parsed for domains:" ) {

    $dom_score = 1;
    $score_type = "domain";
  }

  if ( $line eq "" ) {

    $dom_score = 0;
  }

  if ( $dom_score ) {

    $dom_score++; # flag to skip the anchor line

    if ( ( $dom_score > 2) && # not the anchor line
       (substr($line,0,5) ne "Model") &&
       (substr($line,0,5) ne "-----") && 
       ( $line ne "\t[no hits above thresholds]" ) ) {

      @fields = split " ", $line;
      $pfam_model = $fields[0];
      $E = $fields[-1];

      if ( $E < $opt_E_value ) {

        push @accept_scores,
          [ $E, $query_seq . "\@" . $pfam_model, $score_type ];
      }
    }
  }

 if ( $seq_score && $dom_score ) {

   error( "both sequence and domain scores ON" ); 
 }
}

close_file( $file );

if ( $opt_d_flag ) {

  $debug_file = "hmm_scores.opt_d_flag";
  print " Debug is ON, saving $debug_file";
  $file = open_for_writing( $debug_file );

  print $file " Score     PeptideID\@HMMmodel        type\n";
  print $file "------------------------------------------\n";

  for $entry ( @accept_scores ) {

    printf $file " %8.2e  %-24s %-12s\n", $entry->[0], $entry->[1],
      $entry->[2];
  }

  close_file( $file );
}

# Collapse entries which have the same $match_id (PeptideID::HMMmodel)
# but differ in type of the match i.e. "domain" or "entire_sequence".
# Also here check for '@' in the $match_id. Exacly one must be present,
# otherwise the sequence ID or motif name also contain it (bomb with
# error in latter case).

%hmm_score_hash = ();

for $entry ( @accept_scores ) {

  $match_score = $entry->[0];
  $match_id = $entry->[1];

  $count = 0;
  while ( $match_id =~ /\@/g ) { $count++; }

  if ( $count != 1 ) {
     print "\n --> '$match_id' contains more then one '\@'\n";
     error( "Unacceptable sequence id or HMM model name" );
  }

  if ( exists($hmm_score_hash{$match_id}) ) {

    if ( $seq_score < $hmm_score_hash{$match_id} ) {

      $hmm_score_hash{$match_id} = $match_score;
    }

  } else {

    $hmm_score_hash{$match_id} = $match_score;
  }
}

# create hmm_scores object. Sort scores on the fly

$hmm_scores = [];

for $match_id ( sort { $hmm_score_hash{$a} <=> $hmm_score_hash{$b} }

  keys %hmm_score_hash ) {
  push @$hmm_scores, [ $match_id, $hmm_score_hash{$match_id} ];
}

printf "\n  No     Sequence                            E-score\n";
printf " -----------------------------------------------------\n";

$cntr = 0;
for $item ( @$hmm_scores ) {
  $cntr++;
  printf " (%4d)  %-32s  %10.2e\n", $cntr, $item->[0], $item->[1];
}

if ( $opt_s_flag ) {
  save_ip( $hmm_scores, $opt_s_value, $HMM_SCORE, $WARN_OVERW );
}

