#!/usr/bin/perl
use Test;
BEGIN { plan test => 20 }
END { ok(0) unless $loaded }

# try to load the module
use Data::Config;
$loaded = 1;
ok(1);  #01

# check if the version is defined
ok( defined $Data::Config::VERSION );  #02
ok( $Data::Config::VERSION > 0.01 );   #03

my $obj = new Data::Config '../t/pilots.txt';
ok( defined $obj );  #04
ok( ref $obj, 'Data::Config' ); #05

# check that the following object methods are available
ok( defined $obj->can('options') );         #06
ok( defined $obj->can('read_source') );     #07
ok( defined $obj->can('write_source') );    #08
ok( defined $obj->can('param') );           #09
ok( defined $obj->can('all_parameters') );  #10
ok( defined $obj->can('delete') );          #11
ok( defined $obj->can('delete_all') );      #12
ok( defined $obj->can('clear') );           #13
ok( defined $obj->can('clear_params') );    #14
ok( defined $obj->can('dump_param') );      #15

# check that the information about the Children is present
ok( $obj->param('First_Children' ), 'Ayanami Rei'         );  #16
ok( $obj->param('Second_Children'), 'Soryu Asuka Langley' );  #17
ok( $obj->param('Third_Children' ), 'Ikari Shinji'        );  #18
ok( $obj->param('Fourth_Children'), 'Suzuhara Toji'       );  #19
ok( $obj->param('Fifth_Children' ), 'Nagisa Kaoru'        );  #20

