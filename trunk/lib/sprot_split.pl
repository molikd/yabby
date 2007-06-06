# sprot_split.pl

use yabby_sys;
use yabby_utils;

use Getopt::Std;

$USAGE = "
 Splits large sequence database written in SWISS-PROT format 
 into smaller files.

 Usage:
 	sprot_split [ options ] DBA_FILE

 Where DBA_FILE is the name of the sequence database file in
 the SWISS-PROT format. The output files are named DBA_FILE.1,
 DBA_FILE.2, etc.

 Options:

 -n NLINES -- split the database into files approx NLINES
 each (default: NLINES = 20000000).
";

# options
getopt('n');

if ( defined($opt_n) ) {
  if (! unsig_int($opt_n) ) {
    error('argument to -n option must be a positive integer');
  }
  $opt_n_value = $opt_n;
} else {
  $opt_n_value = 20000000; # default
}

# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 1 ] );
$dba_file  = $argl[0];

# requirements
# body
print " Reading the database file '$dba_file' ..\n";

$fp = open_for_reading( $dba_file );
$total_lines = 0;
while ( <$fp> ) { $total_lines++; }
close_file( $fp );

if ( $total_lines <= $opt_n_value ) {
  error( "total lines ($total_lines) less then requested
    chunk lines ($opt_n_value)" );
} else {
  print " The number of lines in the database: $total_lines\n";
}

$total_records = int( $total_lines/$opt_n_value ) + 1;

$record_start = 1; 
$record_break = -1;
$record_cntr = 0;

while ( $record_cntr < $total_records ) {

  $record_cntr++;
  $record_start_flag = 0;
  $search_record_end_flag = 0;

  $dba_file_chunk = $dba_file . "." . "$record_cntr";

  print " -> Creating '$dba_file_chunk'\n";

  $fp_out = open_for_writing( $dba_file_chunk );
  $fp_in = open_for_reading( $dba_file );
  $line_cntr = 0;
  while ( <$fp_in> ) {

    $line_cntr++;

    if ( $line_cntr == $record_start ) {
      $record_start_flag = 1;
    }

    if ( $line_cntr > ($record_cntr*$opt_n_value) ) {
      $search_record_end_flag = 1;
    }

    if ( $record_start_flag ) { print $fp_out $_; }

    if ( $record_start_flag && $search_record_end_flag ) {

      if ( substr($_,0,2) eq "//" ) {
        $record_break = $line_cntr;
        last;
      }
    }
  }
  close_file( $fp_in );
  close_file( $fp_out );

  $record_start = $record_break + 1;
}

