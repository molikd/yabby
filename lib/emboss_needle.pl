# emboss_needle.pl

use yabby_sys;
use yabby_seq;
use yabby_emboss;
use yabby_utils;

use Getopt::Std;

$USAGE = "
  Extracts sequences which have the highest similarity from
  the output of the EMBOSS program 'needle'.

  Usage:
        emboss_needle NEEDLE_OUTPUT NN

  Where NEEDLE_OUTPUT is the output file of the program 'needle',
  and NN is the number of highest alignments to report (as given
  by the 'Similarity' line in the needle output).
";

# options
# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 2 ] );
$needle_file = $argl[0];
$nn = $argl[1];

if (! unsig_int($nn) ) {
  error('second argument must be a positive integer');
}

# requirements
# body
print " Processing the file '$needle_file' ..\n\n";

$top_entries = proc_needle_output($needle_file, $nn);

$ii = 0;
for $par ( @$top_entries ) { 
  $ii++;
  printf " (%d) %s:%s, Similarity: %.1f\n", $ii+1, $par->[0], $par->[1],
    $par->[2];
}

