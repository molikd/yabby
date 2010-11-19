# help.pl

use yabby_sys;

$USAGE = "
 Lists available commands or prints help about a specific
 command.

 Usage:
	help [ COMMAND ]
";

# options
# initialization
@argl = sys_init( @ARGV );

# arguments
check_call( @argl, [ 0, 1 ] );
$command = $argl[0];

# requirements
# body
$cmd_hash = load_cmd_hash();
@cmd_list = sort keys %$cmd_hash;

$CMDS_PER_LINE = 4;

if ( $#argl == -1 ) {

  printf " %d commands ready.\n\n", $#cmd_list+1;

  if ( @cmd_list ) {

    $cntr = 0;
    foreach ( @cmd_list ) {
      $cntr++; printf " %-18s", $_;
      if ( ( $cntr % $CMDS_PER_LINE ) == 0  ) { print "\n" }
    }
    if ( ( ($#cmd_list+1) % $CMDS_PER_LINE ) != 0  ) { print "\n" }

    print "\n For info about a particular command try: 'help COMMAND'\n";
  } else {
    print " [ none ]\n";
  }
} else {

  if ( ($command eq "quit") || ($command eq "exit") ) {
    print " Exits Yabby\n"

  } elsif ( defined($cmd_hash->{$command}) ) {
    call( $command, "help" );

  } else {
    error( "command '$command' does not exist" );
  }
}

