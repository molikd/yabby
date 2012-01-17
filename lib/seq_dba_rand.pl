# seq_dba_rand.pl

use yabby_sys;
use yabby_seq;

use Getopt::Std;
use List::Util 'shuffle';

$USAGE = "
 Randomizes sequences in the FASTA database file.

 Usage:
 	seq_dba_rand DBA_FILE RAND_DBA_FILE

 Where DBA_FILE is the name of the FASTA sequence database,
 and RAND_DBA_FILE is the name of the output FASTA sequence
 database with sequences randomized.
";

# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 2 ] );
$dba_file  = $argl[0];
$rand_dba_file  = $argl[1];

# body
print " Randomizing the database '$dba_file' ..\n";

$seq_cntr = read_fasta__rand( $dba_file, $rand_dba_file );

printf " '%d' sequences processed.\n", $seq_cntr;
 

