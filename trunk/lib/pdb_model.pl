# pdb_model.pl

use yabby_sys;
use yabby_mol;
use yabby_utils;

use Getopt::Std;

$USAGE = "
 Splits Protein Data Bank file with multiple models into
 multiple XPLOR PDB files

 Usage
	pdb_model [ options ] PDB_INPUT MODEL_ROOT

 PDB_INPUT is the Protein Data Bank file which contains
 multiple models (separated with MODEL/ENDMDL statements),
 and MODEL_ROOT is the root name for the CHARMM/XPLOR
 PDB files to be created (one file per model). The final
 file names will be MODEL_ROOT_1.pdb, MODEL_ROOT_2.pdb,
 etc. until all models are exausted.

 Options:

 -u -- require strict Protein Data Bank format when reading
 the PDB file. This amounts to requiring that residue names
 have maximum of three characters (columns 18,19, and 20) of
 an ATOM or HETATM record. By default this behavior is disabled,
 and four letter residue names are expected (columns 18,19,20
 and 21). This is safe in most cases as the extra column 21 is
 actually not defined in the strict Protein Data Bank format

 -f FORMAT -- use the format FORMAT when writing the PDB
 output file. Allowed formats are 'xplor' (default) or 'charmm'.
 The difference between the two is subtle, and occurs only for
 residues which have a residue number greater than 999

 -l ALT_LOC -- write atoms with the alternative location
 field equal to ALT_LOC, together with those without ALT_LOC
 label. In some structures only a subset of atoms is found in
 two alternative locations, and therefore only a subset of atoms
 has ALT_LOC fields set to distinguish the two positions

 -m CHAIN_ID -- write only the molecule with the chain ID
 equal to CHAIN_ID

 -i SEGID -- replace the segment name with SEGID

 -h -- discard hydrogens, i.e. all atoms whose names begin with
 either the letter 'H' (case insensitive) or a number

 -e -- discard HEATM records (by default HEATM records are
 included, and rewritten as ATOM records)

 -r RBEGIN:OFFSET -- Add offset OFFSET to reside numbers
 starting with the residue number RBEGIN
";

# options

getopt('filmr');

if ( defined( $opt_f ) ) {
  $opt_f_flag = $opt_f;
} else {
  $opt_f_flag = "xplor"; 
}

if ( defined( $opt_i ) ) {
  $opt_i_flag = 1;
  $opt_i_value = $opt_i; 
} else {
  $opt_i_flag = 0;
}

if ( defined( $opt_l ) ) {
  $opt_l_flag = 1;
  $opt_l_value = $opt_l;
} else {
  $opt_l_flag = 0;
}

if ( defined( $opt_m ) ) {
  $opt_m_flag = 1;
  $opt_m_value = $opt_m;
} else {
  $opt_m_flag = 0;
}

if ( defined( $opt_r ) ) {

  $opt_r_flag = 1;

  if ( $opt_r =~ /:/ ) {
    @fields = split /:/, $opt_r;
    $resi_begin = $fields[0];
    $resi_offset = $fields[1];
   } else {
     error( "residue offset must be of the form <RBEGIN>:<OFFSET>" );
   }
} else {
  $opt_r_flag = 0;
}

getopts('uhe');

if ( defined( $opt_u ) ) {
  $opt_u_flag = 1;
} else {
  $opt_u_flag = 0;
}

if ( defined( $opt_h ) ) {
  $opt_h_flag = 1;
} else {
  $opt_h_flag = 0;
}

if ( defined( $opt_e ) ) {
  $opt_e_flag = 1;
} else {
  $opt_e_flag = 0;
}

# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 2 ] );
$input_file = $argl[0];
$model_root = $argl[1];

# requirements: None
# body
if ( ($opt_f_flag ne "charmm") && ($opt_f_flag ne "xplor") ) {
  error( "output format must be either 'charmm' or 'xplor'" );
}

if ( $opt_r_flag && ( ! signed_int($resi_offset) ) ) {
  error( "residue offset must be an integer" );
}

$file_i = open_for_reading( $input_file );

$model_cntr = 0;
$model_on = 0;
$model_begin = 0;
$print_info = 1;

while ( <$file_i> ) {

  $line = $_; chomp( $line );
  @fields = split ' ', $line;

  if ( defined($fields[0]) && ($fields[0] eq "MODEL") ) {
    $model_cntr++;
    $model_on = 1; 
    $model_begin = 1;
  }

  if ( defined($fields[0]) && ($fields[0] eq "ENDMDL") ) {
    $model_on = 0; 
    close_file( $file_o );
  }

  if ( $model_on ) {

    if ( $model_begin ) {
      $output_file = $model_root . $model_cntr . ".pdb";
      printf " working on model %2d (creating '%s')\n",
        $model_cntr, $output_file;
      $file_o = open_for_writing( $output_file );
      $atom_cntr = 0;
      $rec_cntr = 0;
      $model_begin = 0;
    }

    if ( defined($fields[0]) &&
         ( ($fields[0] eq "ATOM") || ($fields[0] eq "HETATM") ) ) {

      if ( $opt_u_flag ) {
        $pdb_fields = split_pdb_strict( $line );
      } else {
        $pdb_fields = split_pdb_xplor( $line );
      }

      $rec_cntr++;

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

      if ( $opt_i_flag ) {

        $segid = $opt_i_value;

      } else {

        $segid = $segmentID;
      }

      if ( $opt_r_flag && ($resi_num>=$resi_begin) ) {

        $resi_num = $resi_num + $resi_offset;
      }

      @pdb_fields = ( $atom_name, $resi_name, $resi_num, $x_coor,
        $y_coor, $z_coor, $occupancy, $temp_factor, $segid );

      if ( ($alt_loc ne "") && $opt_l_flag ) {

        if ( $alt_loc eq $opt_l_value ) {
          $alt_loc_ok = 1;
        } else {
          $alt_loc_ok = 0;
        }

      } else {
        $alt_loc_ok = 1;
      }

      if ( $opt_m_flag ) {

        if ( $chain_id eq $opt_m_value ) {
          $chain_ok = 1;
        } else {
          $chain_ok = 0;
        }

      } else {
        $chain_ok = 1;
      }

      if ( $opt_h_flag ) {

        if ( ! ( ($atom_name =~ /^[hH]/) || ($atom_name =~ /^\d/) ) ) {
          $hydro_ok = 1;
        } else {
          $hydro_ok = 0;
        }

      } else {
        $hydro_ok = 1;
      }

      if ( $opt_e_flag ) {

        if ( $record_name eq "HETATM" ) {
          $hetatm_ok = 0;
        } else {
          $hetatm_ok = 1;
        }

      } else {
        $hetatm_ok = 1;
      }

      if ( $chain_ok && $hydro_ok && $hetatm_ok ) {

        $atom_cntr++;

        if ( $opt_f_flag eq "charmm" ) {
          out_pdb_charmm( $file_o, $atom_cntr, @pdb_fields );
        } else {
          out_pdb_xplor( $file_o, $atom_cntr, @pdb_fields );
        }
      }
    }
  }

  if ( $print_info ) {

    if ( $opt_i_flag ) {
      print " [ using '$opt_i_value' for the segment name ]\n";
    }

    if ( $opt_r_flag ) {
      print " [ using $resi_offset for the residue offset,";
      print " starting from residue $resi_begin ]\n";
    }

    if ( $opt_l_flag ) {
      print " [ filtering alt location field '$opt_l_value']\n";
    }

    if ( $opt_m_flag ) {
      print " [ filtering chain '$opt_m_value']\n";
    }

    if ( $opt_h_flag ) {
      print " [ discarding hydrogens ]\n";
    }

    if ( $opt_e_flag ) {
      print " [ excluding HETATM records ]\n";
    }

    $print_info = 0;
  }
}

close_file( $file_i );

if ( $model_cntr == 0 ) {
  print " no models found\n";
} else {
  printf "\n %d models found\n", $model_cntr;
}

