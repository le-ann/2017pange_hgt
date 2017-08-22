#!/usr/bin/perl
#This script will find seqs with transposase in them. It misses the
#lcl in the first sequence and adds an >lcl at the end of the file
#with no sequence after. Correct manually.
use strict;
use warnings;
use diagnostics;

unless(@ARGV)
{
  die "No input.";
}

open(FILE,">10mycogenomeswotransposase_seqs.fna");
local $/;
local $/ = ">lcl";

while(<>){
  if($_ !~
	  m/transposase/){
#      print $_. "\n";
  print FILE $_;
}
}
close FILE;
