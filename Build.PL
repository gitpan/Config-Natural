#!/usr/bin/perl
use Module::Build;
Module::Build->new(
    'module_name' => 'Config::Natural', 
    'license' => 'perl', 
)->create_build_script;
