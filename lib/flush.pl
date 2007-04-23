# flush.pl

use yabby_sys;

$USAGE = "
 Deletes everything from the workspace

 Usage:
	flush
";

# options
# initialization
@argl = sys_init( @ARGV );

# arguments
check_call( @argl, [ 0 ] );

# body
$ip_hash = load_ip_hash();

for $object ( keys %$ip_hash ) {
  foreach $property ( @{ $ip_hash->{$object} } ) {
    delete_ip( $object, $property );
  }
}
print " [ workspace flushed ]\n";

