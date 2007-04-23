# delete.pl 

use yabby_sys;

$USAGE = "
 Deletes objects from the workspace.

 Usage: 
	delete OBJECT.PROPERTY

 Notes:

 1. If PROPERTY equals '*' (no quotes) all properties of
    OBJECT will be deleted
";

# options
# initialization

@argl = sys_init( @ARGV );
check_call( @argl, [ 1 ] );
$ip_string = $argl[0];

# requirements
# body

( $obj_targ, $prop_targ ) = split_ip_string( $ip_string );

if ( $prop_targ eq "*" ) {
  $ip_hash = load_ip_hash(); 
  for $object ( keys %$ip_hash ) {
    if ( $object eq $obj_targ ) {
      foreach $property ( @{ $ip_hash->{$object} } ) {
        delete_object( $obj_targ, $property );
      }
    }
  }
} else {

  if ( exists_ip( $obj_targ, $prop_targ ) ) {
    delete_object( $obj_targ, $prop_targ );
  } else {
    error( "'$obj_targ.$prop_targ' does not exist" );
  }
}

# subroutines

sub delete_object {
  my ( $obj_targ, $prop_targ ) = @_;
  delete_ip( $obj_targ, $prop_targ );
  print " [ '$obj_targ.$prop_targ' deleted ]\n"
}

