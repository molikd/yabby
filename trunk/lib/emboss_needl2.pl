# emboss_needl2.pl

use yabby_sys;
use yabby_emboss;
use yabby_seq;
use yabby_utils;

use Getopt::Std;

$USAGE = "
  For each sequence in a set finds the best matching sequence
  from the database by running the EMBOSS program needle.
  Uses the information on sequence similarity reported by
  needle.

  Usage:
        emboss_needl2 SEQ_QUERY SEQ_DBA OBJ_NAME

  Where SEQ_QUERY is an existing yabby sequence object, SEQ_DBA
  is the FASTA database file with sequences to be compared, and
  OBJ_NAME is the name of the 'needl2' object to be created. 
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

# set the variable for the program 'needle'
$needle_gap_extend = $DEFAULT_GAP_EXTEND;
$needle_gap_open = $DEFAULT_GAP_OPEN;
$tmp_fasta_file = $TMP_FASTA_FILE;
$tmp_needle_out = $tmp_fasta_file . ".needle";

# body
$seq_hash = xml2seq($xmldoc);
$keys = get_seq_keys($seq_hash);

printf " '%s' contains %d sequence(s)\n", $seq_query, $#{$keys}+1;

$needl2 = [];

for $key ( @$keys ) {

  $seq_item = $seq_hash->{$key};
  printf " Working on %s\n", $seq_item->{$DBA_SEQID};

  # create a temporary FASTA file for 'needle' run
  $fp = open_for_writing($tmp_fasta_file);
  print_seq_fasta($fp, $seq_item, $PRINT_WIDTH);
  close_file($fp);

  # run 'needle'
  $command = $NEEDLE_PATH;
  $command = $command . " -gapopen $needle_gap_open";
  $command = $command . " -gapextend $needle_gap_extend";
  $command = $command . " -outfile $tmp_needle_out";
  $command = $command . " $tmp_fasta_file";
  $command = $command . " $seq_dba";

  $status = system $command;

  if ($status != 0) {
    error("the program 'needle' failed");
  }

  # delete temporary FASTA file
  unlink($tmp_fasta_file) or die "Can't unlink '$tmp_fasta_file': $!";

  # out of the needle run, get the entry with the highest similarity 
  $top_entries = proc_needle_output($tmp_needle_out,1);

  push @$needl2, $top_entries->[0];
}
 
save_ip($needl2, $obj_name, $NEEDL2, $WARN_OVERW);

