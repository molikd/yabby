# blastg.pl

use yabby_sys;
use yabby_seq;
use yabby_blast;

$USAGE = "
 Runs NCBI BLAST against a database and saves the best
 hit for each sequence. 

 Usage:
 	blastg DBA_FILE OBJ_NAME

 Where DBA_FILE is the sequence database and OBJ_NAME
 is the name of the sequence object which contains
 sequences to be blasted. Each sequence is in turnx
 blasted against the database, and the top hit is stored
 as BLASG object. This object contains the list of:

 SEQ_ID DBA_SEQ_ID E-VALUE

 Where SEQ_ID is the sequence ID, DBA_SEQ_ID is the
 best hits database sequence ID, and E-VALUE is the
 E-value of the match.
";

# options
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
push @cmd, "-e 0.1"; # set the E-value threshold
push @cmd, "-m 7"; # set XML output

$top_hits = [];

for $key ( @$keys ) {

  $seq_item = $seq_hash->{$key};
  $seqid = $seq_item->{$DBA_SEQID};
  $seque = $seq_item->{$DBA_SEQUENCE};

  printf " BLASTing sequence %d of %d (%s)\n",
    $key, $#{$keys}+1, $seqid;

  if ( $pid = open(CHILD, "-|") ) {

    @blast_out = <CHILD>;
    close( CHILD );

    # coerce BLAST output into a single string
    $xmldoc = "";

    for $line ( @blast_out ) {
      chomp( $line );
      $xmldoc = $xmldoc . $line;
    }

    $top_hit = fetch_top_hit( $xmldoc );

    unshift @$top_hit, $seqid; 
    push @$top_hits, $top_hit;

    printf "  top hit %s, E-score = %.2e\n", $top_hit->[1], $top_hit->[2];

    undef $xmldoc;
    undef @blast_out;

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

save_ip( $top_hits, $obj_name, $BLASTG, $WARN_OVERW );

