package Data::Config;
use Carp qw(carp);
use Config::Natural;
{ no strict;
  @ISA = qw(Config::Natural);
  $VERSION = $Config::Natural::VERSION;
}
carp "This module has been renamed to Config::Natural.\nYou should use the new name";
1
