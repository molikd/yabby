# blast.pl

use yabby_sys;
use yabby_seq;
use yabby_blast;

use Getopt::Std;

$USAGE = "
 Runs NCBI BLAST against a database.

 Usage:
 	blast [ options ] DBA_FILE OBJ_NAME

 Where DBA_FILE is the sequence database and OBJ_NAME is the
 name of the sequence object which contains the query sequence.
 If OBJ_NAME contains more than one sequence, all will be used
 in turn as a query sequence.

 Options:

 -E E_VALUE - Sets the expectation value for BLAST (default=0.01)

 Notes:

 1. This command runs NCBI program 'blastall'
 2. The full PATH to 'blastall' is defined in yabby_blast.pm
";

# options
getopt('E');

if ( defined($opt_E) ) {
  $opt_E_value = $opt_E;
} else {
  $opt_E_value = $BLAST_DEFAULT_THRESH;
}

# initialization
@argl = sys_init( @ARGV );

# arguments
check_call( @argl, [ 2 ] );

$dba_name = $argl[0];
$obj_name = $argl[1];

# requirements
requirements( $obj_name, $SEQUENCE );

$xmldoc = load_ip_xml( $obj_name, $SEQUENCE );
$seq_hash = xml2seq( $xmldoc );

# body
$keys = get_seq_keys( $seq_hash );
$nseq = $#{$keys}+1;

printf " %d sequence(s) found in the object '%s'\n\n", $nseq, $obj_name;
print " Now running BLAST ..\n";

@cmd = ();
push @cmd, $BLASTALL;
push @cmd, "-p blastp";
push @cmd, "-d $dba_name";
push @cmd, "-e $opt_E_value"; # set the E-value threshold
push @cmd, "-m 7"; # set XML output

for $key ( @$keys ) {

  $seq_item = $seq_hash->{$key};

  $seqid = $seq_item->{$DBA_SEQID};
  $seque = $seq_item->{$DBA_SEQUENCE};

  if ( $nseq == 1 ) {

    $item_name = $obj_name;
    $multi_seq = 0;

  } else {

    $item_name = $obj_name . "_" . "$key";
    $multi_seq = 1;
  }

  if ( $multi_seq ) {

    printf " BLASTing sequence %d of %d (%s)\n",
      $key, $#{$keys}+1, $seqid;
  }

  $blast_out = "";

  if ( $pid = open(CHILD, "-|") ) {

    @blast_out = <CHILD>;
    close( CHILD );

    # coerce BLAST output into a single string
    $xmldoc = "";

    for $line ( @blast_out ) {
      chomp( $line );
      $xmldoc = $xmldoc . $line;
    }

    print_blast_info( $xmldoc );

    if ( $multi_seq ) { print "\n"; }
     
    save_ip_xml( $xmldoc, $item_name, $BLAST, $NOWARN_OVERW );

  } else {

    die "cannot fork: $!" unless defined $pid;
    STDOUT->autoflush(1);

    $blast_pid = open( BLAST_HANDLE, "| @cmd" )
      or die "Couldn't fork BLAST: $!\n";

    print BLAST_HANDLE ">$seqid\n";
    print BLAST_HANDLE "$seque\n";
    close BLAST_HANDLE;

    exit(0);
  }
}

