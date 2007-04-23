# yabby_blast.pm

use XML::DOM;

# ---------
# CONSTANTS
# ---------

$BLAST = "blast";
$BLASTG = "blastg";

$BLAST_THRESH = 0.01;
$BLASTALL = "/usr/local/bin/blastall";

# -----------
# SUBROUTINES
# -----------

sub print_blast_info {

  my ( $xmldoc ) = @_;
  my ( $blast_out, $param_arry, $hits_hash, $E_threshold, @keys );
  my ( $hit_no, $hit_acce, $hsp_eval );

  $blast_out = xml2blast( $xmldoc );  
  $param_arry = $blast_out->[0];
  $hits_hash = $blast_out->[1];

  printf " Query sequence '%s'\n", $param_arry->[0];
  printf " Database '%s'\n", $param_arry->[1];

  $E_threshold = $param_arry->[2];
  @keys = keys %$hits_hash;
 
  if ( $#keys == -1 ) {

    printf " No BLAST hits above the threshold (E=%.2f) found.\n",
      $E_threshold;

  } else {

    printf " Found %d hits above the threshold (E=%.2f)\n",
      $#keys+1, $E_threshold;

    $hit_no = 1;
    $hit_acce = $hits_hash->{$hit_no}->[0];
    $hsp_eval = $hits_hash->{$hit_no}->[1];

    printf " The best hit: '%s'\n", $hit_acce;
    printf " E-score = %.2e\n", $hsp_eval;
  }
}

sub fetch_top_hit {

  my ( $xmldoc ) = @_;
  my ( $blast_out, $param_arry, $hits_hash, $E_threshold, @keys );
  my ( $hit_no, $hit_acce, $hsp_eval );

  $blast_out = xml2blast( $xmldoc );  
  $param_arry = $blast_out->[0];
  $hits_hash = $blast_out->[1];
  $E_threshold = $param_arry->[2];
  @keys = keys %$hits_hash;
 
  if ( $#keys == -1 ) { # no hits

     $hit_acce = "None";
     $hsp_eval = -1;

  } else { # get the best hit

    $hit_no = 1;
    $hit_acce = $hits_hash->{$hit_no}->[0];
    $hsp_eval = $hits_hash->{$hit_no}->[1];

    #printf " The best hit: '%s'\n", $hit_acce;
    #printf " E-score = %.2e\n", $hsp_eval;
  }

  return [ $hit_acce, $hsp_eval ];
}

# ---
# XML
# ---

$HIT = "Hit";
$HIT_NUM = "Hit_num";
$HIT_ACCE = "Hit_accession";
$HSP_EVAL = "Hsp_evalue";
$BLAST_DBA = "BlastOutput_db";
$QUERY_SEQ_NAME = "BlastOutput_query-def";
$E_THRESHOLD = "Parameters_expect";

sub xml2blast {

  my ( $xmldoc ) = @_;

  my ( $hit_no, $hit_acce, $hit_eval );
  my ( $dom_parser, $dom_obj, $param_arry, $hits_hash, $blast_out );

  $dom_parser = XML::DOM::Parser->new();
  $dom_obj = $dom_parser->parse( $xmldoc );

  # -- parameters --
  # Contains:
  #   $param_arry->[0] -- query sequence name
  #   $param_arry->[1] -- database path
  #   $param_arry->[2] -- E-value threshold
  $param_arry = ();

  push @$param_arry, $dom_obj->getElementsByTagName( $QUERY_SEQ_NAME )
	->item(0)->getFirstChild->getNodeValue;

  push @$param_arry, $dom_obj->getElementsByTagName( $BLAST_DBA )
	->item(0)->getFirstChild->getNodeValue;

  push @$param_arry, $dom_obj->getElementsByTagName( $E_THRESHOLD )
	->item(0)->getFirstChild->getNodeValue;

  # -- hits --
  # Contains:
  #   $hits_hash->{1} -- 1st hit [ accession code, E-value ]
  #   $hits_hash->{2} -- 2st hit [ accession code, E-value ]
  $hits_hash = {};

  foreach my $obj ( $dom_obj->getElementsByTagName($HIT) ) {

    $hit_no = $obj->getElementsByTagName( $HIT_NUM )
	->item(0)->getFirstChild->getNodeValue;

    $hit_acce = $obj->getElementsByTagName( $HIT_ACCE )
	->item(0)->getFirstChild->getNodeValue;

    $hsp_eval = $obj->getElementsByTagName( $HSP_EVAL )
	->item(0)->getFirstChild->getNodeValue;

    $hits_hash->{$hit_no} = [ $hit_acce, $hsp_eval ];
  }

  # assemble blast output
  $blast_out = ();
  push @$blast_out, $param_arry;
  push @$blast_out, $hits_hash;

  return $blast_out; 
} 

return 1;

