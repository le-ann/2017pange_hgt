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

open(FILE,">NR85filtered.txt");

while(<>){
  if($_ =~
	  m/^\w+[\.]*[\d]*_cdsid_\w+[\.]*[\d]*[_]*\w+\t(\d+)\t(\d+)\t(\d+)/){
     if(($3 - $2 + 1)/$1 >= 0.85) {
     #print $_;
# print $1 ." ". $2 . " " . $3 ."\n";
  print FILE $_;
   }
  }
}
close FILE;
