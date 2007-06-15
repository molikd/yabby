# seq_firstl.pl

use yabby_sys;
use yabby_seq;

use Getopt::Std;

$USAGE = "
 Prints the first letter from the first sequence of a sequence
 object. 

 Usage:
        seq_firstl OBJ_NAME

 Notes:

 1. This merely an example script used to demonstrate how new
 Yabby commands can be developed.
";

# options
# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 1 ] );
$obj_name = $argl[0];

# requirements
requirements( $obj_name, $SEQUENCE );
$xmldoc = load_ip_xml( $obj_name, $SEQUENCE );

# body
$seq_hash = xml2seq( $xmldoc );
$seq_item = $seq_hash->{1};
printf " The first letter of the first sequence is: '%s'\n",
  substr( $seq_item->{$DBA_SEQUENCE}, 0, 1 );

