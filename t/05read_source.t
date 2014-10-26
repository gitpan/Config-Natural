use Test;
use File::Spec;
BEGIN { plan tests => 26 }
use Config::Natural;
Config::Natural->options(-quiet => 1);
my $obj = new Config::Natural;

# read the data from a file
$obj->read_source(File::Spec->catfile('t','children.txt'));
# check the internal filename
ok( $obj->{'state'}{'filename'}, File::Spec->catfile('t','children.txt') );  #01
# check the number of actual parameters
ok( scalar $obj->param, 5 );  #02

# check the data is as expected
ok( $obj->param('First_Children' ), 'Ayanami Rei'         );  #03
ok( $obj->param('Second_Children'), 'Soryu Asuka Langley' );  #04
ok( $obj->param('Third_Children' ), 'Ikari Shinji'        );  #05
ok( $obj->param('Fourth_Children'), 'Suzuhara Toji'       );  #06
ok( $obj->param('Fifth_Children' ), 'Nagisa Kaoru'        );  #07


# read additionnal data from another file
$obj->read_source(File::Spec->catfile('t','eva.txt'));
# the internal filename must be the last given to read_source()
ok( $obj->{'state'}{'filename'}, File::Spec->catfile('t','eva.txt') );  #08
ok( scalar $obj->param, 11 );  #08

# check the children are still here
ok( $obj->param('First_Children' ), 'Ayanami Rei'         );  #03
ok( $obj->param('Second_Children'), 'Soryu Asuka Langley' );  #04
ok( $obj->param('Third_Children' ), 'Ikari Shinji'        );  #05
ok( $obj->param('Fourth_Children'), 'Suzuhara Toji'       );  #06
ok( $obj->param('Fifth_Children' ), 'Nagisa Kaoru'        );  #07

# now check the Evas are also here
ok( $obj->param('Eva_00'), 'Prototype Unit' );  #08
ok( $obj->param('Eva_01'), 'Test Unit' );  #09
ok( $obj->param('Eva_02'), 'First Unit of Production Serie 1' );  #10
ok( $obj->param('Eva_03'), 'Second Unit of Production Serie 1' );  #11
ok( $obj->param('Eva_04'), 'Third Unit of Production Serie 1' );  #12
ok( $obj->param('Eva_05'), 'First Unit of Production Serie 2' );  #12


undef $obj;
$obj = new Config::Natural;

# read the data from a filehandle
$obj->read_source(\*DATA);
ok( scalar $obj->param, 5 );  #13

# check the data is as expected
ok( $obj->param('First_Children' ), 'Ayanami Rei'         );  #14
ok( $obj->param('Second_Children'), 'Soryu Asuka Langley' );  #15
ok( $obj->param('Third_Children' ), 'Ikari Shinji'        );  #16
ok( $obj->param('Fourth_Children'), 'Suzuhara Toji'       );  #17
ok( $obj->param('Fifth_Children' ), 'Nagisa Kaoru'        );  #18

__END__
First_Children = Ayanami Rei
Second_Children = Soryu Asuka Langley
Third_Children = Ikari Shinji
Fourth_Children = Suzuhara Toji
Fifth_Children = Nagisa Kaoru
