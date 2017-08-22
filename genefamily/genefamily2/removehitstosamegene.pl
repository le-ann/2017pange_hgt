#!/usr/bin/perl
#This script will remove hits from a species to itself in an all vs
#all blast.
use strict;
use warnings;
use diagnostics;

unless(@ARGV)
{
  die "No input.";
}

open(FILE,">outputwohitstosamegene.txt");

while(<>){
  if($_ =~
	  m/\w+\|\w+[\.]*[\d]*_cdsid_(\w+[\.]*\w+)\t\d+\t\d+\t\d+\t\d+\t\w+[\.]*[\d]*_cdsid_(\w+[\.]*\w+)\t.+/){
  if($1 ne $2) {
#    print $1." ". $2 . "\n";
  #}
print FILE $_;
 }
}
}
close FILE;
