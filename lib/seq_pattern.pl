# seq_pattern.pl

use yabby_sys;
use yabby_seq;
use yabby_utils;

use Getopt::Std;

$USAGE = "
 Searches for letter pattern in a sequence object.

 Usage:
 	seq_pattern [ options ] PATTERN OBJ_NAME

 Searches for pattern PATTERN in sequences OBJ_NAME, where
 OBJ_NAME is the name of an existing sequence object.

 Options:

 -c -- Match the comment not the sequence.
 -s NAME -- Extract the matching sequences and save under
    the name NAME.
 -n -- Print the matching sequences and the residue position
    where the pattern matches.
";

# options
getopt('s');

if ( defined( $opt_s ) ) {
  $opt_s_flag = 1;
  $opt_s_value = $opt_s;
} else {
  $opt_s_flag = 0;
}

getopts('cn');

if ( defined( $opt_c ) ) {
  $opt_c_flag = 1;
} else {
  $opt_c_flag = 0;
}

if ( defined( $opt_n ) ) {
  $opt_n_flag = 1;
} else {
  $opt_n_flag = 0;
}

if ( $opt_c_flag && $opt_n_flag ) {
  error( "option -n cannot be used with option -c" );
}

# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 2 ] );
$pattern = $argl[0];
$obj_name = $argl[1];

# requirements
requirements( $obj_name, $SEQUENCE );
$xmldoc = load_ip_xml( $obj_name, $SEQUENCE );
$seq_hash = xml2seq( $xmldoc );

# body
if ( $pattern =~ /[$METACHARS]/ ) {
  print " [ metacharacters detected, using pattern matching ]\n\n";
}

$keys = get_seq_keys( $seq_hash );

$seq_hash2 = {};
$cntr = 0;

for $key ( @$keys ) {

  $seq_item = $seq_hash->{$key};
  $seq_id = $seq_item->{$DBA_SEQID};

  if ( $opt_c_flag ) {
    $search_string = $seq_item->{$DBA_COMMENT};
  } else {
    $search_string = $seq_item->{$DBA_SEQUENCE}
  }

  if ( $search_string =~ /$pattern/g ) {

    $cntr++;
    $match_string = $&;

    if ( $opt_n_flag ) {
      printf " pattern '%s' matches sequence '%s' at position %d\n",
          $match_string, $seq_id, pos($search_string)+1-length($match_string);
    } else {
      printf " '%s' matches in '%s'\n", $match_string, $seq_id;
    }

    $seq_hash2->{$cntr} = $seq_item;
  }
}

$hits_keys = get_seq_keys( $seq_hash2 );

printf " %d sequences examined, %d match(es) found\n", $#{$keys}+1,
    $#{$hits_keys}+1; 

if ( $opt_s_flag ) {
  printf " Saving matches as '%s'\n", $opt_s_value;
  $xmldoc = seq2xml( $seq_hash2 );
  save_ip_xml( $xmldoc, $opt_s_value, $SEQUENCE, $WARN_OVERW );
}

