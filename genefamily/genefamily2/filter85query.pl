#!/usr/bin/perl
#This script will remove entries where the match lengths are not
#more than 85% of the query length.
use strict;
use warnings;
use diagnostics;

unless(@ARGV)
{
  die "No input.";
}

open(FILE,">outputwolessthan85.txt");

while(<>){
  if($_ =~
	  m/^\w+\|\w+[\.]*[\d]*_cdsid_\w+[\.]*\w+\t(\d+)\t(\d+)(\t\d+)\t\d+\t\w+[\.]*[\d]*_cdsid_\w+[\.]*\w+/){
      if(($3 - $2 + 1)/$1 >= 0.85) {
#	  print $3 - $2 + 1;
#         print $1." ". $2 . " " . $3."\n";
	  print FILE $_;
      }
  }
}
close FILE;
