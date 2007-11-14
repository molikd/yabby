# sprot_fetch.pl

use yabby_sys;
use yabby_seq;

# sprot_fetch sprot_test.dat 104K_THEAN
# OS: Theileria annulata.
  
# sprot_fetch sprot_test.dat 13S1_FAGES
# OS: Fagopyrum esculentum (Common buckwheat).

# sprot_fetch sprot_test.dat 1433T_RABIT
# OS: Oryctolagus cuniculus (Rabbit).

$USAGE = "
 Fetches a sequence from a SWISS-PROT database by its ID.

 Usage:
 	sprot_fetch <DBA_FILE> <SPROT_ID>

 Where <DBA_FILE> is the database is the Swiss-Prot format,
 and <SPROT_ID> is the swiss-prot sequence ID. Prints the
 sequence ID, organism, and sequence letters.
";

# options
# initialization
@argl = sys_init( @ARGV );

check_call( @argl, [ 2 ] );
$sprot_dba  = $argl[0];
$sprot_id  = $argl[1];

# requirements
# body
$file = open_for_reading( $sprot_dba );

$sprot_entry = 0;
$seq_start = 0;
$cntr = 0;

while( <$file> ) {

  $line = $_;
  chomp($line);

  @fields = split " ", $line;

  if ( $fields[0] eq $SPROT_ID ) {
    $sprot_entry = 1;
  } 

  if ( $fields[0] eq "//" ) {

    $sprot_entry = 0;
    $seq_start = 0;

    if ( $sprot_hash{$SPROT_ID} eq $sprot_id ) {

      printf " Sequence ID: '%s'\n", $sprot_hash{$SPROT_ID};
      printf " Organism: '%s'\n", $sprot_hash{$SPROT_OS};
      print " Sequence:\n";

      print_seq( *STDOUT, $sprot_hash{$SPROT_SEQ}, $PRINT_WIDTH );

      exit(0);
    }
  }

  if ( $sprot_entry ) {

    # new entry, initialize the entry hash
    if ( $sprot_entry == 1 ) {

      %sprot_hash = ();
      $sprot_hash{$SPROT_ID} = $fields[1];
      $sprot_entry++; # increment entry line counter
      $cntr++; # increments entries counter

    } else { # fill in entries for the current sequence

      # organism
      if ( $fields[0] eq $SPROT_OS ) {

        @fields2 = split " ", $line;
        shift @fields2;
        $sprot_hash{$SPROT_OS} = join " ", @fields2;
      }

      # start sequence
      if ( $fields[0] eq $SPROT_SEQ ) { $seq_start++; }

      if ( $seq_start ) {

        # the first line; just initialize the sequence string
        if ( $seq_start == 1 ) {
          $sprot_hash{$SPROT_SEQ} = "";
        } else {
          @fields2 = split " ", $line;
          $seqstr = join "", @fields2;
          $sprot_hash{$SPROT_SEQ} = $sprot_hash{$SPROT_SEQ} . $seqstr;
        }
        $seq_start++;
      }
    }
  }
}

close_file( $file );

printf " Entry with ID '%s' not found.\n", $sprot_id;
printf " A total of %d sequences processed\n", $cntr;

