use Test;
BEGIN { plan tests => 32 }
use Config::Natural;
Config::Natural->options(-quiet => 1);
my $obj = new Config::Natural;

# read information about the Nerv
$obj->read_source(File::Spec->catdir('t','nerv'));

# read information about the Evangelions
$obj->read_source(File::Spec->catfile('t','eva.txt'));

# read information about the Angels
$obj->read_source(File::Spec->catfile('t','shito.txt'));

# check that information about MAGI is present
ok( defined $obj->param('magi') );                                  #01
ok( $obj->param('magi')->[0]{name}, 'MAGI' );                       #02
ok( $obj->param('magi')->[0]{brain}[0]{name}, 'Melchior-1' );       #03
ok( $obj->param('magi')->[0]{brain}[0]{personality}, 'scientist' ); #04
ok( $obj->param('magi')->[0]{brain}[1]{name}, 'Balthasar-2' );      #05
ok( $obj->param('magi')->[0]{brain}[1]{personality}, 'mother' );    #06
ok( $obj->param('magi')->[0]{brain}[2]{name}, 'Casper-3' );         #07
ok( $obj->param('magi')->[0]{brain}[2]{personality}, 'woman' );     #08

# check that the information about the Children is present
ok( $obj->param('First_Children' ), 'Ayanami Rei'         );  #09
ok( $obj->param('Second_Children'), 'Soryu Asuka Langley' );  #10
ok( $obj->param('Third_Children' ), 'Ikari Shinji'        );  #11
ok( $obj->param('Fourth_Children'), 'Suzuhara Toji'       );  #12
ok( $obj->param('Fifth_Children' ), 'Nagisa Kaoru'        );  #13

# check that the information about Nerv staff is present
ok( defined $obj->param('staff') );            #14
my $staff = $obj->param('staff');
ok( scalar @$staff, 4 );                      #15
for my $person (@$staff) {                     #16,17,18,19
    ok( $person->{role}, "Nerv director and commander" )
        if $person->{name} eq "Ikari Gendo";
    ok( $person->{role}, "Nerv second commander" )
        if $person->{name} eq "Fuyutsuki Kozo";
    ok( $person->{role}, "Project E director" )
        if $person->{name} eq "Akagi Ritsuko";
    ok( $person->{role}, "executive officer" )
        if $person->{name} eq "Katsuragi Misato";
}

# now check the information about the Evangelions is also here
ok( $obj->param('Eva_00'), 'Prototype Unit'                    );  #20
ok( $obj->param('Eva_01'), 'Test Unit'                         );  #21
ok( $obj->param('Eva_02'), 'First Unit of Production Serie 1'  );  #22
ok( $obj->param('Eva_03'), 'Second Unit of Production Serie 1' );  #23
ok( $obj->param('Eva_04'), 'Third Unit of Production Serie 1'  );  #24
ok( $obj->param('Eva_05'), 'First Unit of Production Serie 2'  );  #25


# check that a hidden file was *not* read
ok( $obj->param('Marduk'), $obj->read_hidden_files ? 'Nerv' : undef );  #26


# now updating information...
# Episode 0:17, Yonninme no tekikakusha
$obj->delete('Eva_04');  # Destroyed in the explosion of the Nerv base in the USA
ok( $obj->param('Eva_04'), undef );  #27
$obj->param({
    Eva_03 => $obj->param('Eva_03')." - Became the 13th Angel when possessed by Bardiel", 
});
ok( $obj->param('Eva_03'), 'Second Unit of Production Serie 1 - Became the 13th Angel when possessed by Bardiel' );  #28

# Episode 0:23, Namida
$obj->delete('Eva_00');
ok( $obj->param('Eva_00'), undef );  #29
$obj->param(-First_Children => 'Ayanami Rei III');
ok( $obj->param('First_Children'), 'Ayanami Rei III' ); #30


# now trying to clone this object using dump_param()
eval {
  require Data::Dumper;
  require POSIX;
};
if($@) {
    ok(1);
    print "# skip Data::Dumper or POSIX not available";
    ok(1);
    print "# skip Data::Dumper or POSIX not available";

} else {
    $Data::Dumper::Sortkeys = 1 if defined $Data::Dumper::Sortkeys;

    # first check that dump_param() works
    my $data = Data::Dumper::Dumper($obj->{'param'});
    my $dump = $obj->dump_param();
    ok( Data::Dumper::Dumper($obj->{'param'}), $data );  #31

    # now write the object to a file...
    my $file_obj = POSIX::tmpnam();
    $obj->write_source($file_obj);
  
    # read that file in another object
    my $dup = new Config::Natural $file_obj;
    
    # check that both are identical
    ok( Data::Dumper::Dumper($obj->{param}), Data::Dumper::Dumper($dup->{param}) );  #32
    
    unlink $file_obj;
}
