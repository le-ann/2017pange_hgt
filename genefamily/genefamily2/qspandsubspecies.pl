#!/usr/bin/perl
#This will break the output of a tabular blast so that the query species
#name and subject species name are in separate columns.
use strict;
use warnings;
use diagnostics;

unless(@ARGV)
{
die "No input.";
}

open(FILE,">output.txt");

while(<>){
$_ =~
    s/[lcl\|]*(\w+[\.]*[\d]*)_cdsid_(\w+[\.]*\w+)/$1\t$2/g;
print FILE $_;
}
close FILE;
