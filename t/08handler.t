use Test;
BEGIN { plan tests => 3 }
use Config::Natural;
Config::Natural->options(-quiet => 1);
my $obj = new Config::Natural;

# hook up an (Asuka-like) handler
$obj->set_handler('Third_Children', sub{"baka ".(split' ',$_[1])[1]."!!"});
ok( $obj->has_handler('Third_Children') );  #01

# read the data from a file
$obj->read_source(File::Spec->catfile('t','children.txt'));
ok( $obj->param('Third_Children'), "baka Shinji!!" );  #02

# delete the handler
$obj->delete_handler('Third_Children');
ok( not $obj->has_handler('Third_Children') );  #03
