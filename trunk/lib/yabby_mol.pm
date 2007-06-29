# yabby_mol.pm

$MOLECULE = "mol";
$COORDINATES = "crd";

# split the PDB ATOM or HETATM record strictly as defined by
# the Protain Data Bank-- residue name is maximum of three
# characters long, given in columns 18,19,20
sub split_pdb_strict {

  my ( $pdb_record ) = @_;

  my $record_name = trim_end_blanks( substr( $pdb_record,  0,  6 ) );
  my $atom_number = trim_end_blanks( substr( $pdb_record,  6,  5 ) );
  my $undefined_1 = trim_end_blanks( substr( $pdb_record, 11,  1 ) );
  my $atom_name   = trim_end_blanks( substr( $pdb_record, 12,  4 ) );
  my $alt_loc     = trim_end_blanks( substr( $pdb_record, 16,  1 ) );
  my $resi_name   = trim_end_blanks( substr( $pdb_record, 17,  3 ) );
  my $undefined_2 = trim_end_blanks( substr( $pdb_record, 20,  1 ) );
  my $chain_id    = trim_end_blanks( substr( $pdb_record, 21,  1 ) );
  my $resi_num    = trim_end_blanks( substr( $pdb_record, 22,  4 ) );
  my $insert_code = trim_end_blanks( substr( $pdb_record, 26,  1 ) );
  my $undefined_3 = trim_end_blanks( substr( $pdb_record, 27,  3 ) );
  my $x_coor      = trim_end_blanks( substr( $pdb_record, 30,  8 ) );
  my $y_coor      = trim_end_blanks( substr( $pdb_record, 38,  8 ) );
  my $z_coor      = trim_end_blanks( substr( $pdb_record, 46,  8 ) );
  my $occupancy   = trim_end_blanks( substr( $pdb_record, 54,  6 ) );
  my $temp_factor = trim_end_blanks( substr( $pdb_record, 60,  6 ) );
  my $undefined_4 = trim_end_blanks( substr( $pdb_record, 66,  6 ) );
  my $segmentID   = trim_end_blanks( substr( $pdb_record, 72,  4 ) );
  # -optional-
  #my $element     = substr( $pdb_record, 76,  2 );
  #my $charge      = substr( $pdb_record, 78,  2 );

  my $pdb_fields = [];

  push @$pdb_fields, $record_name, $atom_name, $resi_num, $resi_name,
    $x_coor, $y_coor, $z_coor, $occupancy, $temp_factor, $segmentID,
    $chain_id, $alt_loc;

  return $pdb_fields;
  }

# split Protein Data Bank ATOM or HETATM record, XPLOR format 
sub split_pdb_xplor {

  my ( $pdb_record ) = @_;

  my $record_name = trim_end_blanks( substr( $pdb_record,  0,  6 ) );
  my $atom_number = trim_end_blanks( substr( $pdb_record,  6,  5 ) );
  my $undefined_1 = trim_end_blanks( substr( $pdb_record, 11,  1 ) );
  my $atom_name   = trim_end_blanks( substr( $pdb_record, 12,  4 ) );
  my $alt_loc     = trim_end_blanks( substr( $pdb_record, 16,  1 ) );
  my $resi_name   = trim_end_blanks( substr( $pdb_record, 17,  4 ) );
  my $chain_id    = trim_end_blanks( substr( $pdb_record, 21,  1 ) );
  my $resi_num    = trim_end_blanks( substr( $pdb_record, 22,  4 ) );
  my $insert_code = trim_end_blanks( substr( $pdb_record, 26,  1 ) );
  my $undefined_3 = trim_end_blanks( substr( $pdb_record, 27,  3 ) );
  my $x_coor      = trim_end_blanks( substr( $pdb_record, 30,  8 ) );
  my $y_coor      = trim_end_blanks( substr( $pdb_record, 38,  8 ) );
  my $z_coor      = trim_end_blanks( substr( $pdb_record, 46,  8 ) );
  my $occupancy   = trim_end_blanks( substr( $pdb_record, 54,  6 ) );
  my $temp_factor = trim_end_blanks( substr( $pdb_record, 60,  6 ) );
  my $undefined_4 = trim_end_blanks( substr( $pdb_record, 66,  6 ) );
  my $segmentID   = trim_end_blanks( substr( $pdb_record, 72,  4 ) );
  # -optional-
  #my $element     = substr( $pdb_record, 76,  2 );
  #my $charge      = substr( $pdb_record, 78,  2 );

  my $pdb_fields = [];

  push @$pdb_fields, $record_name, $atom_name, $resi_num, $resi_name,
    $x_coor, $y_coor, $z_coor, $occupancy, $temp_factor, $segmentID,
    $chain_id, $alt_loc;

  return $pdb_fields;
}

# split Protein Data Bank ATOM or HETATM record CHARMM format
sub split_pdb_charmm {

  my ( $pdb_record ) = @_;

  my $record_name = trim_end_blanks( substr( $pdb_record,  0,  6 ) );
  my $atom_number = trim_end_blanks( substr( $pdb_record,  6,  5 ) );
  my $undefined_1 = trim_end_blanks( substr( $pdb_record, 11,  1 ) );
  my $atom_name   = trim_end_blanks( substr( $pdb_record, 12,  4 ) );
  my $alt_loc     = trim_end_blanks( substr( $pdb_record, 16,  1 ) );
  my $resi_name   = trim_end_blanks( substr( $pdb_record, 17,  4 ) );
  my $chain_id    = trim_end_blanks( substr( $pdb_record, 21,  2 ) );
  my $resi_num    = trim_end_blanks( substr( $pdb_record, 23,  4 ) );
  my $insert_code = trim_end_blanks( substr( $pdb_record, 26,  1 ) );
  my $undefined_3 = trim_end_blanks( substr( $pdb_record, 27,  3 ) );
  my $x_coor      = trim_end_blanks( substr( $pdb_record, 30,  8 ) );
  my $y_coor      = trim_end_blanks( substr( $pdb_record, 38,  8 ) );
  my $z_coor      = trim_end_blanks( substr( $pdb_record, 46,  8 ) );
  my $occupancy   = trim_end_blanks( substr( $pdb_record, 54,  6 ) );
  my $temp_factor = trim_end_blanks( substr( $pdb_record, 60,  6 ) );
  my $undefined_4 = trim_end_blanks( substr( $pdb_record, 66,  6 ) );
  my $segmentID   = trim_end_blanks( substr( $pdb_record, 72,  4 ) );
  # -optional-
  #my $element     = substr( $pdb_record, 76,  2 );
  #my $charge      = substr( $pdb_record, 78,  2 );

  my $pdb_fields = [];

  push @$pdb_fields, $record_name, $atom_name, $resi_num, $resi_name,
    $x_coor, $y_coor, $z_coor, $occupancy, $temp_factor, $segmentID,
    $chain_id, $alt_loc;

  return $pdb_fields;
}

# output an XPLOR PDB record to a file
sub out_pdb_xplor {

  my ( $file, $atom_cntr, @pdb_fields ) = @_;

  my ( $fs ); 

  my $atom_name   = $pdb_fields[0];
  my $resi_name   = $pdb_fields[1];
  my $resi_num    = $pdb_fields[2];
  my $x_coor      = $pdb_fields[3];
  my $y_coor      = $pdb_fields[4];
  my $z_coor      = $pdb_fields[5];
  my $occupancy   = $pdb_fields[6];
  my $temp_factor = $pdb_fields[7];
  my $segid       = $pdb_fields[8];

  # the dependency on the atom name length
  if ( length($atom_name) < 4 ) {

    $fs = "ATOM  %5d  %-3s %-4s";

  } else {

    $fs = "ATOM  %5d %4s %-4s";
  }

  $fs = $fs . " %4d    %8.3f%8.3f%8.3f%6.2f%6.2f      %-4s\n";

  printf $file $fs, $atom_cntr, $atom_name, $resi_name, $resi_num,
        $x_coor, $y_coor, $z_coor, $occupancy, $temp_factor, $segid;
}

# output a CHARMM PDB record to a file
sub out_pdb_charmm {

  my ( $file, $atom_cntr, @pdb_fields ) = @_;

  my ( $fs ); 

  my $atom_name   = $pdb_fields[0];
  my $resi_name   = $pdb_fields[1];
  my $resi_num    = $pdb_fields[2];
  my $x_coor      = $pdb_fields[3];
  my $y_coor      = $pdb_fields[4];
  my $z_coor      = $pdb_fields[5];
  my $occupancy   = $pdb_fields[6];
  my $temp_factor = $pdb_fields[7];
  my $segid       = $pdb_fields[8];

  # the dependency on atom name length
  if ( length($atom_name) < 4 ) {

   $fs = "ATOM  %5d  %-3s %-4s";

  } else {

   $fs = "ATOM  %5d %4s %-4s";
  }

  # the dependency on residue number
  if ( $resi_num < 1000 ) {

    $fs = $fs . "  %3d    %8.3f%8.3f%8.3f%6.2f%6.2f      %-4s\n";

  } else {

    $fs = $fs . "  %4d   %8.3f%8.3f%8.3f%6.2f%6.2f      %-4s\n";
  }

  printf $file $fs, $atom_cntr, $atom_name, $resi_name, $resi_num,
        $x_coor, $y_coor, $z_coor, $occupancy, $temp_factor, $segid;
}

# Loads molecule from the PDB file
sub load_mol_pdb {

  my ( $file_name, $strict_pdb_flag ) = @_;
  my ( $line, @fields, $pdb_fields );
  my ( $record_name, $atom_name, $resi_num, $resi_name,
    $x_coor, $y_coor, $z_coor, $occupancy, $temp_factor,
    $segmentID, $chain_id, $alt_loc );

  my $mol = [];

  my $file = open_for_reading( $file_name );

  my $cntr = 0;

  while ( <$file> ) {

    $cntr++;
    $line = $_; chomp( $line );
    @fields = split " ", $line;

    if ( defined($fields[0]) &&
	( ($fields[0] eq "ATOM") || ($fields[0] eq "HETATM") ) ) {

      if ( $strict_pdb_flag ) {

        $pdb_fields = split_pdb_strict( $line );
      } else {

        $pdb_fields = split_pdb_xplor( $line );
      }

    $record_name = $pdb_fields->[0];
    $atom_name   = $pdb_fields->[1];
    $resi_num    = $pdb_fields->[2];
    $resi_name   = $pdb_fields->[3];
    $x_coor      = $pdb_fields->[4];
    $y_coor      = $pdb_fields->[5];
    $z_coor      = $pdb_fields->[6];
    $occupancy   = $pdb_fields->[7];
    $temp_factor = $pdb_fields->[8];
    $segmentID   = $pdb_fields->[9];
    $chain_id    = $pdb_fields->[10];
    $alt_loc     = $pdb_fields->[11];

    push @$mol, [ $resi_num, $resi_name, $atom_name, $segmentID ];
    }
  }

  close_file( $file );
  return $mol;
}

sub read_crd_pdb {

  my ( $mol, $pdb_file ) = @_;
  my ( $mol2, $message, @p, $ii, $jj, $error_flag, $crd2, $crd );

  # -- 1. check if the PDB file contains coordinates of all atoms --

  # load the molecule in a temporary variable
  $mol2 = load_mol_pdb( $pdb_file, 1 );

  # coordinates may be in a different order
  # Index $mol2 relative to $mol 
  @p = ();
  for $ii ( 0 .. $#{$mol} ) { push( @p, "-1" ); }

  for $ii  ( 0 .. $#{$mol} ) {
    for $jj  ( 0 .. $#{$mol2} ) {

      if ( ( $mol->[$ii][0] == $mol2->[$jj][0] ) &&
           ( $mol->[$ii][1] eq $mol2->[$jj][1] ) && 
           ( $mol->[$ii][2] eq $mol2->[$jj][2] ) ) {

        $p[$ii] = $jj;
      }
    }
  }

  $error_flag = 0;

  for $ii ( 0 .. $#{$mol} ) {

    if ( $p[$ii] < 0 ) {
      if ( $error_flag == 0 ) {
        print "\n\n problem with the PDB file '$pdb_file'\n";
        print " missing coordinates of the following atom(s):\n";
      }

      printf "\t%4d %4s %4s\n", $mol->[$ii][0], $mol->[$ii][1],
          $mol->[$ii][2];

      $error_flag++;
    }
  }

  if ( $error_flag > 0 ) {
    error( "while reading coordinates" );
  }

  # -- passed, read coordinates --

  $crd2 = read_pdb_crd( $pdb_file );

  # re-order coordinates
  $crd = [];

  for $ii ( 0 .. $#{$mol} ) {
    push @{ $crd->[$ii] }, @{ $crd2->[ $p[$ii] ] };
  }

  return $crd;
}

sub read_pdb_crd {

  my ( $file_name, $strict_pdb_flag ) = @_;
  my ( $line, @fields, $pdb_fields );
  my ( $record_name, $atom_name, $resi_num, $resi_name,
    $x_coor, $y_coor, $z_coor, $occupancy, $temp_factor,
    $segmentID, $chain_id, $alt_loc );

  my $crd = [];
  my $file = open_for_reading( $file_name );
  my $cntr = 0;

  while ( <$file> ) {

    $cntr++;
    $line = $_; chomp( $line );
    @fields = split " ", $line;

    if ( defined($fields[0]) &&
	( ($fields[0] eq "ATOM") || ($fields[0] eq "HETATM") ) ) {

      if ( $strict_pdb_flag ) {
        $pdb_fields = split_pdb_strict( $line );
      } else {
        $pdb_fields = split_pdb_xplor( $line );
      }

    $record_name = $pdb_fields->[0];
    $atom_name   = $pdb_fields->[1];
    $resi_num    = $pdb_fields->[2];
    $resi_name   = $pdb_fields->[3];
    $x_coor      = $pdb_fields->[4];
    $y_coor      = $pdb_fields->[5];
    $z_coor      = $pdb_fields->[6];
    $occupancy   = $pdb_fields->[7];
    $temp_factor = $pdb_fields->[8];
    $segmentID   = $pdb_fields->[9];
    $chain_id    = $pdb_fields->[10];
    $alt_loc     = $pdb_fields->[11];

    push @$crd, [ $x_coor, $y_coor, $z_coor ];
    }
  }

  close_file( $file );
  return $crd;
}

return 1;

