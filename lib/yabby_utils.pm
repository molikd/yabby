# yabby_utils.pm

$METACHARS = quotemeta( "\\|()[]{}^\$+?." );
$INFINITY = 1e99;

# Returns
#  1 if argument is positive or negative integer
#  0 otherwise
sub signed_int {
  my ( $string ) = @_;
  if ( $string =~ /^[+-]?\d+$/ ) {
    return 1;
  } else {
    return 0;
  }
}

# Returns
#  1 if argument is an unsigned integer
#  0 otherwise
sub unsig_int {
  my ( $string ) = @_;
  if ( $string =~ /^\d+$/ ) {
    return 1;
  } else {
    return 0;
  }
}

# Returns union, intersection, and difference
# of two sets given as arrays ref.
sub unindi {
  my ( $a, $b ) = @_;
  my %count = ();
  my $union = [];
  my $isect = [];
  my $diff = [];
  foreach my $e ( @$a, @$b ) { $count{$e}++ }
  foreach $e ( keys %count ) {
    push @$union, $e;
    if ( $count{$e} == 2 ) {
      push @$isect, $e;
    } else {
      push @$diff, $e;
    }
  }
  return [ $union, $isect, $diff ];
}

# Returns input string with end blanks trimmed.
sub trim_end_blanks {
  my ( $string ) = @_;
  $string =~ s/^\s+//;
  $string =~ s/\s+$//;
  return $string; 
}

# Splits the input string on colons and return
# the resulting parts.
sub split_on_colon {
  my ( $colon_string ) = @_;
  my ( @fields );
  if ( $colon_string =~ /:/ ) {
    @fields = split ":", $colon_string;
  } else {
    error( "The string must contain ':'" );
  }
  return \@fields;
}

return 1;

