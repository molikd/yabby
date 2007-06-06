# _print_seq.pl

use yabby_sys;
use yabby_seq;

use Getopt::Std;

# options
getopt('fnt');

if ( defined($opt_f) ) {
  $opt_f_flag = 1;
  $file_name = $opt_f;
} else {
  $opt_f_flag = 0;
}

if ( defined($opt_n) ) {
  $print_width_flag = 1;
  $print_width = $opt_n;
} else {
  $print_width_flag = 0;
}

if ( defined($opt_t) ) {
  $cutoff_seq_flag = 1;
  $cutoff_seq = $opt_t;
} else {
  $cutoff_seq_flag = 0;
}

getopts('lc');

if ( defined($opt_l) ) {
  $three_letter_code = 1;
  if (! $print_width_flag) {
    $print_width = $PRINT_WIDTH3;
  }
} else {
  $three_letter_code = 0;
  if (! $print_width_flag) {
    $print_width = $PRINT_WIDTH;
  }
}

if ( defined($opt_c) ) {
  $print_csv_table = 1;
} else {
  $print_csv_table = 0;
}

# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [1] );
$obj_name = $argl[0];
requirements( $obj_name, $SEQUENCE );
$xmldoc = load_ip_xml( $obj_name, $SEQUENCE );
$seq_hash = xml2seq( $xmldoc );

# body
if ( $opt_f_flag ) {
  $fp = open_for_writing( $file_name );
} else {
  $fp = *STDOUT;
}

$keys = get_seq_keys( $seq_hash );

if ( $three_letter_code ) {

  for $key ( @$keys ) {
    $seq_item = $seq_hash->{$key};
    print_seq_3lett( $fp, $seq_item, $print_width );
  }
} else {
  for $key ( @$keys ) {
    $seq_item = $seq_hash->{$key};
    if ( $print_csv_table ) { # print as CSV table 
      if ( $cutoff_seq_flag ) {
        $sequence = $seq_item->{$DBA_SEQUENCE};
        $seq_item->{$DBA_SEQUENCE} = substr( $sequence,0,$cutoff_seq );
      }
      # remove commas from the comment
      ( $seq_item->{$DBA_COMMENT} = $seq_item->{$DBA_COMMENT} ) =~ s/\,//g;
      ( $seq_item->{$DBA_COMMENT} = $seq_item->{$DBA_COMMENT} ) =~ s/\|\|\|/ /g;
      printf $fp "%s,%s\n", $seq_item->{$DBA_COMMENT},
         $seq_item->{$DBA_SEQUENCE};
    } else { # print as FASTA file
      if ( $cutoff_seq_flag ) {
        $sequence = $seq_item->{$DBA_SEQUENCE};
        $seq_item->{$DBA_SEQUENCE} = substr( $sequence, 0, $cutoff_seq );
      }
      print_seq_fasta( $fp, $seq_item, $print_width );
    }
  }
}

if ( $opt_f_flag ) {
  close_file( $fp );
  print " '$obj_name.$SEQUENCE' written to the file '$file_name'\n";
}

