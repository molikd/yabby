# what.pl 

use yabby_sys;

$USAGE = "
 Shows objects currently in the workspace.

 Usage: 
 	what
";

# options
# initialization
@argl = sys_init( @ARGV );
check_call( @argl, [ 0 ] );

# requirements
# body
$ip_hash = load_ip_hash();
@item_sorted = sort keys %$ip_hash;

printf "    objects        properties\n";
printf "  ------------------------------\n";

if ( @item_sorted ) {
  foreach $item ( @item_sorted ) {
    printf "    %-14s ", $item;
    $cntr = 0;
    foreach ( @{ $ip_hash->{$item} } ) {
      $cntr++; $property = $_;
      if ( $cntr == 1 ) {
         printf "%-14s\n", $property;
      } else {
         printf "    %-14s ", "";
         printf "%-14s\n", $property;
      }
    } 
  }
} else {
  print "   [ none ]\n";
}

