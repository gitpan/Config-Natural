use Test;
BEGIN { plan tests => 28 }
use Config::Natural;

# check that the following class methods are available
ok( defined Config::Natural->can('new') );      #01
ok( defined Config::Natural->can('options') );  #02

# create an object
my $obj = new Config::Natural;
ok( defined $obj and $obj->isa('Config::Natural') );  #03

# check that the following object methods are available
ok( defined $obj->can('options') );         #04
ok( defined $obj->can('read_source') );     #05
ok( defined $obj->can('write_source') );    #06
ok( defined $obj->can('param') );           #07
ok( defined $obj->can('all_parameters') );  #08
ok( defined $obj->can('delete') );          #09
ok( defined $obj->can('delete_all') );      #10
ok( defined $obj->can('clear') );           #11
ok( defined $obj->can('clear_params') );    #12
ok( defined $obj->can('dump_param') );      #13
ok( defined $obj->can('set_handler') );     #14
ok( defined $obj->can('has_handler') );     #15
ok( defined $obj->can('delete_handler') );  #16
ok( defined $obj->can('filter') );          #17

# check that all the accessors are present
ok( defined $obj->can('comment_line_symbol') );     #18
ok( defined $obj->can('affectation_symbol') );      #19
ok( defined $obj->can('multiline_begin_symbol') );  #20
ok( defined $obj->can('multiline_end_symbol') );    #21
ok( defined $obj->can('list_begin_symbol') );       #22
ok( defined $obj->can('list_end_symbol') );         #23
ok( defined $obj->can('include_symbol') );          #24
ok( defined $obj->can('case_sensitive') );          #25
ok( defined $obj->can('auto_create_surrounding_list') );  #26
ok( defined $obj->can('read_hidden_files') );       #27

# delete an object
undef $obj;
ok( $obj, undef );  #28
