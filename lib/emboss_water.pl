# emboss_water.pl

use yabby_sys;
use yabby_seq;
use yabby_emboss;
use yabby_utils;

use Getopt::Std;

$USAGE = "
  Extracts sequences with the highest similarity score from
  the output of the EMBOSS program 'water'.

  Usage:
        emboss_water NEEDLE_OUTPUT N

  Where NEEDLE_OUTPUT is the output file of the program 'needle',
  and N is the number of highest alignments to report (as given
  by the 'Similarity' line in the water output).
";

# options
# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 2 ] );
$water_file = $argl[0];
$nn = $argl[1];

if (! unsig_int($nn) ) {
  error('second argument must be a positive integer');
}

# requirements

# body
print " Processing the file '$water_file' ..\n\n";

$top_entries = proc_water_output($water_file, $nn);

$ii = 0;
for $par ( @$top_entries ) { 
  $ii++;
  printf " (%2d) %s:%s, Similarity: %.1f\n", $ii+1, $par->[0], $par->[1],
    $par->[2];
}

