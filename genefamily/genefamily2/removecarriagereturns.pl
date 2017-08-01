#!/usr/bin/perl
use strict;
use warnings;
use diagnostics;

unless(@ARGV)
{
  die "No input.";
}

open(FILE,">$ARGV[0]wocr");

#print FILE ">";
while(<>){
    if($_ =~ m/^(>.+)/){
	print FILE "\n". $1. "\n";
    }
    unless($_ =~ m/^>/){
#      print $_;
  chomp $_;
  print FILE $_;
}
}
print FILE "\n";
close FILE;
