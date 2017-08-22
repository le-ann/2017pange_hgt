#!/usr/bin/perl
#This script creates a file with every gene from a fna file.
use strict;
use warnings;
use diagnostics;

unless(@ARGV)
{
  die "No input.";
}

open(FILE,">listofallgenes.txt");

while(<>){
  if($_ =~ m/\w+\|(\w+[\.]*\w+)_cdsid_([^\s]*)/){
#print $1 . "\t". $2 . "\n";
print FILE $1 . "\t" . $2 . "\n";
 }
}
close FILE;
