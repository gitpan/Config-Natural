#!/usr/bin/perl
use ExtUtils::MakeMaker;
WriteMakefile (
    'NAME' => 'Config::Natural', 
    'VERSION_FROM' => 'lib/Config/Natural.pm', 
    'PREREQ_PM' => {}, 
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'lib/Config/Natural.pm', # retrieve abstract from module
       AUTHOR => 'Sébastien Aperghis-Tramoni <sebastien@aperghis.net>') : ()),
);
