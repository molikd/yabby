# emboss_needle_cmp.pl

use yabby_sys;
use yabby_emboss;
use yabby_seq;
use yabby_utils;

use Getopt::Std;

$USAGE = "
  For each sequence in a set finds the best matching sequence
  from another set. Uses EMBOSS program 'needle'.

  Usage:
        emboss_needle_cmp SEQ_QUERY SEQ_DBA OBJ_NAME

  Where SEQ_QUERY is an existing yabby sequence object, SEQ_DBA
  is the FAST file with sequences to be compared, and OBJ_NAME
  is the name of the object to be created. 
";

# options
# initialization
@argl = sys_init(@ARGV);
check_call( @argl, [ 3 ] );
$seq_query = $argl[0];
$seq_dba = $argl[1];
$obj_name = $argl[2];

# requirements
requirements($seq_query, $SEQUENCE);
$xmldoc = load_ip_xml($seq_query, $SEQUENCE);

$tmp_needle_out = $TMP_FASTA_FILE . ".needle";

# body
$seq_hash = xml2seq($xmldoc);
$keys = get_seq_keys($seq_hash);

printf " '%s' contains %d sequence(s)\n", $seq_query, $#{$keys}+1;

for $key ( @$keys ) {

  $seq_item = $seq_hash->{$key};
  printf " Working on %s\n", $seq_item->{$DBA_SEQID};

  $fp = open_for_writing($TMP_FASTA_FILE);
  print_seq_fasta($fp, $seq_item, $PRINT_WIDTH);
  close_file($fp);

  $command = $NEEDLE_PATH;
  $command = $command . " -gapopen $NEEDLE_GAP_OPEN";
  $command = $command . " -gapextend $NEEDLE_GAP_EXTEND";
  $command = $command . " -outfile $tmp_needle_out";
  $command = $command . " $TMP_FASTA_FILE";
  $command = $command . " $seq_dba";

  $status = system $command;

  if ( $status != 0 ) {
    error("the program 'needle' failed");
  }

  $top_entries = proc_needle_output($tmp_needle_out,1);
 
  for $par ( @$top_entries ) { 
    printf "%s %s %s\n", $par->[0], $par->[1], $par->[2]; 
  }
}

