#!/usr/bin/perl -w
use strict;
use Config::Natural;
use Data::Dumper;

$|=1;

my $t = new Config::Natural \*DATA;
print Dumper($t->{'param'});


__END__

foo = machin

bar = chose


element {
    name = root
    attr = attribut specifique a l'item
    
    node {
        name = node one
        attr = attribut specifique au noeud
        
        leaf {
            name = leaf
            attr = attribut specifique a la feuille
        }
    }
    
    iterm {
        name = intermedaire
    }
    
    node {
        name = second node
    }
    
    tail = fin de non recevoir
}

