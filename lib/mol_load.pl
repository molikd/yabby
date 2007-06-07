# mol_load.pl

use yabby_sys;
use yabby_mol;
use yabby_utils;

use Getopt::Std;

$USAGE = "
 Loads a molecule from the PDB file.

 Usage:
 	load_pdb [ options ] PDB_FILE OBJ_NAME

 Loads the molecule from the PDB_FILE and saves it under
 the name OBJ_NAME. 

 Options:

 -u -- require strict Protein Data Bank format when reading
 the PDB file. This amounts to requiring that residue names
 have maximum of three characters (columns 18,19, and 20) of
 an ATOM or HETATM record. By default this behavior is disabled,
 and four letter residue names are expected (columns 18,19,20
 and 21). This is safe in most cases as the extra column 21 is
 actually not defined in the strict Protein Data Bank format.
";

# options

getopts('u');

if ( defined( $opt_u ) ) {
   $opt_u_flag = 1;
} else {
   $opt_u_flag = 0;
}

# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 2 ] );
$file_name = $argl[0];
$obj_name  = $argl[1];

# requirements
# body
$mol = load_mol_pdb( $file_name, $opt_u_flag );
printf " %d atoms found in the molecule '$obj_name'\n", $#{$mol}+1;
save_ip( $mol, $obj_name, $MOLECULE, $WARN_OVERW );

