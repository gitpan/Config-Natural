use Test;
BEGIN { plan tests => 11 }
use Config::Natural;
Config::Natural->options(-quiet => 1);
my $obj = new Config::Natural;

# there must be no param
ok( $obj->param, 0 );  #01

# these params are not defined
ok( not defined $obj->param('') );  #02
ok( not defined $obj->param('Adam') );  #03

# affecting a param (Tk-style), then checking it's there
$obj->param(-shito_3 => 'Sachiel');
ok( $obj->param('shito_3'), 'Sachiel');  #04

# affecting a param (hashref), then checking it's there
$obj->param({shito_5 => 'Ramiel'});
ok( $obj->param('shito_5'), 'Ramiel');  #05

# there must be two params
ok( $obj->param == 2 );  #06

# affecting three params (Tk-style), then checking they're there
$obj->param(-shito_4 => 'Samsiel', -shito_6 => 'Gagiel', -shito_8 => 'Sandalfon');
ok( @p = $obj->param(qw(shito_4 shito_6 shito_8)) 
    and $p[0] eq 'Samsiel' 
    and $p[1] eq 'Gagiel' 
    and $p[2] eq 'Sandalfon' );  #07

# affecting three params (hashref), then checking they're there
$obj->param({shito_7 => 'Israfel', shito_9 => 'Matarael', shito_10 => 'Saraqiel'});
ok( @p = $obj->param(qw(shito_7 shito_9 shito_10)) 
    and $p[0] eq 'Israfel' 
    and $p[1] eq 'Matarael' 
    and $p[2] eq 'Saraqiel' );  #08

# affecting some params (Tk-style) while reading the value of others
@p = $obj->param(shito_7, -shito_11 => 'Iroel', shito_5, -shito_12 => 'Leliel');
ok( $p[0] eq 'Israfel' and $p[1] eq 'Ramiel');  #09

# affecting some params (hashref) while reading the value of others
@p = $obj->param(shito_9, {shito_13 => 'Bardiel'}, shito_3, {shito_14 => 'Zeruel'});
ok( $p[0] eq 'Matarael' and $p[1] eq 'Sachiel' 
    and $obj->param('shito_13') eq 'Bardiel' 
    and $obj->param('shito_14') eq 'Zeruel');  #10

# affectiong some params (both styles) while reading the value of others
@p = $obj->param(shito_14, -shito_15 => 'Arael', shito_10, 
     {shito_16 => 'Armisael', shito_17 => 'Tabris'}, shito_6);
ok( $p[0] eq 'Zeruel' and $p[1] eq 'Saraqiel' and $p[2] eq 'Gagiel'
    and $obj->param('shito_15') eq 'Arael' 
    and $obj->param('shito_16') eq 'Armisael' 
    and $obj->param('shito_17') eq 'Tabris');  #11

