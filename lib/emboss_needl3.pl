# emboss_needl2.pl

use yabby_sys;
use yabby_emboss;
use yabby_seq;
use yabby_utils;

use Getopt::Std;

$USAGE = "
  Aligns all possible pairs of sequences from a set by
  with the EMBOSS program needle. Creates a new object
  that contains the sequence IDs for each aligned
  sequence pair and the associated similarity score
  as reported by needle.

  Usage:
        emboss_needl3 SEQ_QUERY OBJ_NAME

  Where SEQ_QUERY is an existing yabby sequence object,
  and OBJ_NAME is the name of the 'needl2' object to
  be created. 
";

# options

# initialization
@argl = sys_init(@ARGV);
check_call( @argl, [ 2 ] );
$seq_query = $argl[0];
$obj_name = $argl[1];

# requirements
requirements($seq_query, $SEQUENCE);
$xmldoc = load_ip_xml($seq_query, $SEQUENCE);

# set the variable for the program 'needle'
$needle_gap_extend = $NEEDLE_GAP_EXTEND;
$needle_gap_open = $NEEDLE_GAP_OPEN;
$tmp_fasta_file1 = $TMP_FASTA_FILE . "1";
$tmp_fasta_file2 = $TMP_FASTA_FILE . "2";
$tmp_needle_out = "needle.out";

# body
$seq_hash = xml2seq($xmldoc);
$keys = get_seq_keys($seq_hash);

printf " '%s' contains %d sequence(s)\n", $seq_query, $#{$keys}+1;

$needl3 = [];

for $ii ( 1 .. $#{$keys}+1 ) {
  for $jj ( $ii+1 .. $#{$keys}+1 ) {

    $seq_item1= $seq_hash->{$ii};
    $seq_item2= $seq_hash->{$jj};

    printf " Aligning %s and %s\n", $seq_item1->{$DBA_SEQID}, $seq_item2->{$DBA_SEQID};

    # create temporary FASTA files for 'needle' run
    $fp = open_for_writing($tmp_fasta_file1);
    print_seq_fasta($fp, $seq_item1, $PRINT_WIDTH);
    close_file($fp);

    # create temporary FASTA files for 'needle' run
    $fp = open_for_writing($tmp_fasta_file2);
    print_seq_fasta($fp, $seq_item2, $PRINT_WIDTH);
    close_file($fp);

    # run 'needle'
    $command = $NEEDLE_PATH;
    $command = $command . " -gapopen $needle_gap_open";
    $command = $command . " -gapextend $needle_gap_extend";
    $command = $command . " -outfile $tmp_needle_out";
    $command = $command . " $tmp_fasta_file1";
    $command = $command . " $tmp_fasta_file2";

    $status = system $command;

    if ($status != 0) {
      error("the program 'needle' failed");
    }

    # delete temporary FASTA files
    unlink($tmp_fasta_file1) or die "Can't unlink '$tmp_fasta_file1': $!";
    unlink($tmp_fasta_file2) or die "Can't unlink '$tmp_fasta_file2': $!";

   # from the needle run get the entry with the highest similarity 
   # (in this case, this is the only entry)
   $top_entries = proc_needle_output($tmp_needle_out,1);

   push @$needl3, $top_entries->[0];
  }
}
 
save_ip($needl3, $obj_name, $NEEDL3, $WARN_OVERW);

