use Test;
BEGIN {
  # In order to make this test, we need Data::Dumper,
  # but it is not required by Config::Natural, therefore
  # it the module is not available, the test is skipped.
  eval {
    require Data::Dumper;
    require POSIX;
  };
  $do_test = $@ ? 0 : 1;
  plan tests => 2;
}
use Config::Natural;

if($do_test) {
    my $obj = new Config::Natural;
    $obj->read_source('t/eva.txt');
    
    $obj->param({
      Eva_03 => $obj->param('Eva_03')." - Became the 13th Angel when possessed by Bardiel", 
      Eva_04 => $obj->param('Eva_04')." - Destroyed in the explosion of the Nerv base in the USA", 
    });
    
    # write $obj in a temp file
    my $file_obj = POSIX::tmpnam();
    $obj->write_source($file_obj);
    
    # read that file in another object
    my $dup = new Config::Natural $file_obj;
    
    # check that both are identical
    ok( Data::Dumper::Dumper($obj->{param}), Data::Dumper::Dumper($dup->{param}) );  #01
    
    # write $dup in a temp file
    my $file_dup = POSIX::tmpnam();
    $dup->write_source($file_dup);
    
    # read that file in $obj
    undef $obj;
    $obj = new Config::Natural $file_dup;
    
    # check that both are identical
    ok( Data::Dumper::Dumper($obj->{param}), Data::Dumper::Dumper($dup->{param}) );  #02

    # remove temp files
    unlink $file_obj, $file_dup;

} else {
    print "# Data::Dumper and/or POSIX are not available\n";
    ok(1);
    ok(1);
}
