#!/usr/bin/perl
#This script will concatenate gene sequences.
use strict;
use warnings;
use diagnostics;

unless(@ARGV)
{
  die "No input.";
}

open(FILE,">$ARGV[0]_cat");
#local $/;
#local $/ = ">";

print FILE ">";
while(<>){
    chomp $_;
  unless($_ =~ m/^>.+/){
#      print $_;
  print FILE $_;
}
}
print FILE "\n";
close FILE;
