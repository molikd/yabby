# sprot_os.pl

use yabby_sys;
use yabby_utils;
use POSIX;
use yabby_seq;

use Getopt::Std;

$USAGE = "
 Extracts sequence ID and organism name from the Swiss-Prot
 sequence database file.

 Usage:
 	sprot_os DBA_FILE OUT_FILE

 Where DBA_FILE is the name of the sequence database file
 in the Swiss-Prot format, and OUT_FILE is the name of the
 output file to be created, containing pairs (sequence ID,
 organism name).
";

# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 2 ] );
$dba_file  = $argl[0];
$out_file  = $argl[1];

# requirements
# body
$DOTCOUNT = 10000;
print " Processing the database file '$dba_file' ..\n";
printf " Printing a dot per %d processed sequences:\n", $DOTCOUNT;

$fp_in = open_for_reading( $dba_file );
$fp_out = open_for_writing( $out_file );

$cntr = 0;
$cntr_adj = $cntr;
$newseq = 0;

print " ";

while ( <$fp_in> ) {

  $tag = substr($_, 0, 5);

  if ( $tag eq $SPROT_ID ) {
     @fields = split " ", $_;
     print $fp_out "$fields[1]";
     $new_seq = 1;
  }

  if ( $tag eq $SPROT_OS ) {

     if ( $new_seq ) {
       $slice = substr( $_, 5 );
       printf $fp_out " %s", $slice;
       $cntr++;
       $cntr_adj_prev = $cntr_adj;
       $cntr_adj = int($cntr/$DOTCOUNT);
       if ($cntr_adj > $cntr_adj_prev) {
          if ( ($cntr_adj % 60) == 0 ) {print ".\n " } else { print "." };
       }
       $new_seq = 0;
     }
  }

}

close_file( $fp_in );
close_file( $fp_out );

print "\n\n All done.\n\n";

