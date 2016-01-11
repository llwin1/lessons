#!/usr/bin/perl

use warnings;
use strict;

my $url = <STDIN>;
my $d = '0-9';
my $a = 'a-zA-Z';

$url =~m/(([$a]+[$a,$d,\+,\-,\.]*))/; 
print ("$1\n"); 

#print ("$i\n");