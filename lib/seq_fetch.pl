# seq_fetch.pl

use yabby_sys;
use yabby_seq;

use Getopt::Std;

use Bio::DB::GenBank;

#Example:
#seq_fetch J00522 mig 

$USAGE = "
 Fetch a sequence from GenBank.

 Usage:
        seq_fetch ACC_NUM OBJ_NAME

 Fetch a sequence from GenBank using sequence accession number,
 and save the sequence under the name OBJ_NAME.

 Notes:

 1. This command requires Bioperl's Bio::DB module.
";

# options
# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 2 ] );
$seqid = $argl[0];
$obj_name = $argl[1];

# body
$gb = new Bio::DB::GenBank(-retrievaltype=>'tempfile', -format=>'Fasta');
$seqz = $gb->get_Seq_by_acc($seqid);

$seq_item = {};
$seq_item->{$DBA_SEQID} = $seqz->{primary_seq}->{display_id};
$seq_item->{$DBA_COMMENT} = $seqz->{primary_seq}->{desc};
$seq_item->{$DBA_SEQUENCE} = $seqz->{primary_seq}->{seq};

$seq_hash = {};
$seq_hash->{1} = $seq_item;

$xmldoc = seq2xml( $seq_hash );

printf " Saving '%s' as '%s'\n", $seqid, $obj_name;

save_ip_xml( $xmldoc, $obj_name, $SEQUENCE, $WARN_OVERW );

