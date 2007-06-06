# emboss_needle.pl

use yabby_sys;
use yabby_seq;
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

$needle_hash = {};

$fp = open_for_reading( $needle_file );

$read_entry = 0;
$entry_lines = [];

while ( <$fp> ) {

  $record = $_;
  #chomp( $record );
  @fields = split " ", $record;

  if ( defined($fields[1]) && ($fields[1] eq "Aligned_sequences:") ) {
     if ( $read_entry == 1 ) {
        print " Error 1!\n";
        exit 0;
     }
     $read_entry = 1;
     @$entry_lines = ();
  }

  if ( defined($fields[1]) && ($fields[1] eq "Score:") ) {
     if ( $read_entry == 0 ) {
        print " Error 0!\n";
        exit 0;
     }
     $read_entry = 0;
     $entry_pars = extract_entry( $entry_lines );
     $entry_no++;
     $needle_hash{$entry_no} = $entry_pars;
  }

  if ( $read_entry ) {
     push @$entry_lines, $record;
  }
}

close_file( $fp );

# sort the hash by similarity
@keyarray = ();
for $key (sort { $needle_hash{$b}->[2] <=> $needle_hash{$a}->[2] }
                keys %needle_hash) 
{
  push @keyarray, $key;
}

if ($nn > $#keyarray+1){
  $k = $#keyarray+1;
  error("there are only '$k' alignments ($nn requested)");
}

for $ii ( 0 .. $nn-1 ) {
  $key = $keyarray[$ii];
  $par = $needle_hash{$key};
  printf " (%d) %s:%s, Similarity: %.1f\n", $ii+1, $par->[0], $par->[1],
    $par->[2];
}

# subroutines

sub extract_entry {

    my ( $entry_lines ) = @_;
    my ( @fields, $seq_name1, $seq_name2, $similarity );

    # --- $entry_lines is a chunk like this:
    # 1: G25M-82-MONOMER
    # 2: LmjF01.0010
    # Matrix: EBLOSUM62
    # Gap_penalty: 10.0
    # Extend_penalty: 0.5
    #
    # Length: 687
    # Identity:      54/687 ( 7.9%)
    # Similarity:    97/687 (14.1%)
    # Gaps:         474/687 (69.0%)
    # Score: 30.5

    @fields = split " ", $entry_lines->[1];
    $seq_name1 = $fields[2];
    @fields = split " ", $entry_lines->[2];
    $seq_name2 = $fields[2];
    @fields = split " ", $entry_lines->[9];

    if ($#fields == 4) {

      $similarity = $fields[4];
      substr( $similarity, -2 ) = "";

    } elsif ($#fields == 3) {

      $similarity = $fields[3];
      substr( $similarity, 0, 1 ) = "";
      substr( $similarity, -2 ) = "";

    } else {

      error("unexpected fields length")
    }

    $entry_pars = [];
    push @$entry_pars, $seq_name1;
    push @$entry_pars, $seq_name2;
    push @$entry_pars, $similarity;
    return $entry_pars;
}

