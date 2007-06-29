# mol_crd.pl

use yabby_sys;
use yabby_utils;
use yabby_mol;

$USAGE = "
 Loads coordinates for a molecule.

 Usage:
	mol_crd FILE_NAME OBJ_NAME

 where FILE_NAME is file with coordinates, and OBJ_NAME is the
 name of an existing molecule object.

 Notes:

 1. Currently coordinates can be read only from the PDB file.
";

# options
# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 2 ] );
$file_name = $argl[0];
$obj_name = $argl[1];

# requirements
requirements( $obj_name, $MOLECULE );
$mol = load_ip( $obj_name, $MOLECULE );

# body
$crd = read_crd_pdb( $mol, $file_name );

printf " Coordinates for '%s' created\n", $obj_name;

save_ip( $crd, $obj_name, $COORDINATES, $WARN_OVERW );

