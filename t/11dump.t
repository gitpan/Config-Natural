use Test;
BEGIN { 
  # In order to make this test, we need Data::Dumper, but it 
  # is not required for normal use of Config::Natural, therefore 
  # it the module is not available, the test is skipped. 
  eval {
    require Data::Dumper;
    require IO::File;
  };
  $do_test = $@ ? 0 : 1;
  plan tests => 2;
}
use Config::Natural;
Config::Natural->options(-quiet => 1);

if($do_test) {
    $Data::Dumper::Sortkeys = 1 if defined $Data::Dumper::Sortkeys;

    my $obj = new Config::Natural;
    $obj->read_source(File::Spec->catfile('t','nerv.txt'));

    # save the data of the object
    my $data = Data::Dumper::Dumper($obj->{'param'});
    
    # dump $obj in a temp file
    $fh = IO::File->new_tmpfile() or die "Unable to make new temporary file: $!";
    print $fh $obj->dump_param;
    seek($fh, 0, 0);  # rewind

    # checking that calling ->dump_param() didn't mess up anything
    # (fixed in 0.98)
    ok( Data::Dumper::Dumper($obj->{'param'}) , $data );  #01
    
    # create $dup reading the temp file; $dup should be a clone of $obj
    my $dup = new Config::Natural;
    $dup->read_source($fh);
    
    # check the clones are real twins
    ok( Data::Dumper::Dumper($obj->{'param'}) , Data::Dumper::Dumper($dup->{'param'}) );  #02

} else {
    print "# Data::Dumper and/or IO::File are not available\n";
    ok(1);
}
