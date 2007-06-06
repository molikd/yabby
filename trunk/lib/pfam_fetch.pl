# pfam_fetch.pl

use yabby_sys;

$USAGE = "
 Fetches an entry from the PFAM database file.

 Usage:
 	pfam_fetch PFAM_CODE PFAM_DBA FILE_NAME

 Where PFAM_CODE is the PFAM accession code, PFAM_DBA is
 the PFAM database, and FILE_NAME is the file to save
 the entry. For example, to fetch the entry PF00293
 from the PFAM database Pfam-A.seed, and save it as
 PF00293.seed:

 pfam_fetch PF00293 Pfam-A.seed PF00293.full
";

# options
# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 3 ] );
$pfam_code = $argl[0];
$pfam_dba = $argl[1];
$output_file = $argl[2];

# requirements
# body
printf " Searching '$pfam_dba' for the entry '$pfam_code'\n";

$file = open_for_reading( $pfam_dba );

@entry_lines = ();

$line2 = "";
$line1 = "";
$line0 = "";

$on_reading_cntr = 0;

while ( <$file> ) {

  # buffer two preceeding lines
  $line2 = $line1; # the current-2 line
  $line1 = $line0; # the current-1 line
  $line0 = $_; # the current line

  @fields = split " ", $line0;

  if ( ($fields[0] eq "#=GF") && ($fields[1] eq "AC") &&
       ($fields[2] eq $pfam_code) ) {
  
     push @entry_lines, $line2;
     push @entry_lines, $line1;

     $on_reading = 1;
     $on_reading_cntr++;
  }

  if ( $on_reading && ($line0 eq "//\n") ) {

    push @entry_lines, $line0;
    $on_reading = 0;
  }

  if ( $on_reading ) {

    push @entry_lines, $line0;
  }
}

close_file( $file );

if ( $on_reading_cntr > 1 ) {

   error( "on_reading turned on $on_reading_cntr times" );
}

if ( $#entry_lines == -1 ) {

  print " PFAM entry '$pfam_code' not found\n";

} else {

  $file = open_for_writing( $output_file );
  foreach $line ( @entry_lines ) { print $file "$line"; }
  close_file( $file );

  print " PFAM entry '$pfam_code' written to '$output_file' \n";
}

