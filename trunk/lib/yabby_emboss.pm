# yabby_emboss.pm

# needlX type objects
$NEEDL2 = "needl2";
$NEEDL3 = "needl3";

# globals for the EMBOSS program 'needle'
$NEEDLE_PATH = "/usr/local/bin/needle";
$TMP_FASTA_FILE = "/tmp/yabby.tmp";
$NEEDLE_GAP_OPEN = 10.0;
$NEEDLE_GAP_EXTEND = 0.5;

# returns $nn entries ordered by percent similarity as reported
# by the EMBOSS program 'water'
sub proc_water_output {

  # $water_file -- the water output file
  # $nn -- the number of top entries to be returned
  my ($water_file, $nn) = @_;

  my ($water_hash, $fp, $read_entry, $entry_lines, $entry_no, $record);
  my (@fields, $entry_pars, @keyarray, $key, $top_keys, $top_entries);

  $water_hash = {};

  $fp = open_for_reading($water_file);

  $read_entry = 0;
  $entry_lines = [];
  $entry_no = -1;

  while ( <$fp> ) {

    $record = $_;
    #chomp( $record );
    @fields = split " ", $record;

    if ( defined($fields[1]) && ($fields[1] eq "Aligned_sequences:") ) {
      if ( $read_entry == 1 ) {
        print " Error 1\n";
        exit 0;
      }
      $read_entry = 1;
      @$entry_lines = ();
    }

    if ( defined($fields[1]) && ($fields[1] eq "Score:") ) {
      if ( $read_entry == 0 ) {
        print " Error 0\n";
        exit 0;
      }
      $read_entry = 0;
      $entry_pars = extract_entry($entry_lines);
      $entry_no++;
      $water_hash{$entry_no} = $entry_pars;
    }

    if ( $read_entry ) {
      push @$entry_lines, $record;
    }
  }

  close_file($fp);

  # sort the hash by similarity
  @keyarray = ();

  for $key (sort { $water_hash{$b}->[2] <=> $water_hash{$a}->[2] }
      keys %water_hash) {
  push @keyarray, $key;
  }

  # $nn cannot be greater than the number of sequences in the database
  if ($nn > $#keyarray+1 ) { $nn = $#keyarray+1; }

  # take the top $nn hits
  @top_keys = splice @keyarray, 0, $nn;

  $top_entries = [];

  for $key ( @top_keys ) {
    push @$top_entries, $water_hash{$key};
  }

  return $top_entries;
}


# returns $nn entries ordered by percent similarity as reported
# by 'needle'
sub proc_needle_output {

  # $needle_file -- the needle file
  # $nn -- the number of top entries to be returned
  my ($needle_file, $nn) = @_;

  my ($needle_hash, $fp, $read_entry, $entry_lines, $entry_no, $record);
  my (@fields, $entry_pars, @keyarray, $key, $top_keys, $top_entries);

  $needle_hash = {};

  $fp = open_for_reading($needle_file);

  $read_entry = 0;
  $entry_lines = [];
  $entry_no = -1;

  while ( <$fp> ) {

    $record = $_;
    #chomp( $record );
    @fields = split " ", $record;

    if ( defined($fields[1]) && ($fields[1] eq "Aligned_sequences:") ) {
      if ( $read_entry == 1 ) {
        print " Error 1\n";
        exit 0;
      }
      $read_entry = 1;
      @$entry_lines = ();
    }

    if ( defined($fields[1]) && ($fields[1] eq "Score:") ) {
      if ( $read_entry == 0 ) {
        print " Error 0\n";
        exit 0;
      }
      $read_entry = 0;
      $entry_pars = extract_entry($entry_lines);
      $entry_no++;
      $needle_hash{$entry_no} = $entry_pars;
    }

    if ( $read_entry ) {
      push @$entry_lines, $record;
    }
  }

  close_file($fp);

  # sort the hash by similarity
  @keyarray = ();
  for $key (sort { $needle_hash{$b}->[2] <=> $needle_hash{$a}->[2] }
      keys %needle_hash) {
  push @keyarray, $key;
  }

  # $nn cannot be greater than the number of sequences in the database
  if ($nn > $#keyarray+1 ) { $nn = $#keyarray+1; }

  # take the top $nn hits
  @top_keys = splice @keyarray, 0, $nn;

  $top_entries = [];
  for $key ( @top_keys ) {
    push @$top_entries, $needle_hash{$key};
  }

  return $top_entries;
}

sub extract_entry {

  my ($entry_lines) = @_;

  my (@fields, $seq_name1, $seq_name2, $similarity, $entry_pars);

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
  @fields = split " ", $entry_lines->[9]; # the 'Similarity' report

  if ($#fields == 4) {

    $similarity = $fields[4];
    substr($similarity, -2) = "";

  } elsif ($#fields == 3) {

    $similarity = $fields[3];
    substr($similarity, 0, 1) = "";
    substr($similarity, -2) = "";

  } else {
    error("unexpected fields length")
  }

  $entry_pars = [];

  push @$entry_pars, $seq_name1;
  push @$entry_pars, $seq_name2;
  push @$entry_pars, $similarity;

  return $entry_pars;
}

return 1;

