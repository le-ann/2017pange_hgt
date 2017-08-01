#!/usr/bin/perl
#This script will add a column of taxa names

use strict;
use warnings;
use diagnostics;

unless(@ARGV)
{
  die "No input.";
}

open(FILE,">NRaddcolfiltered.txt");

while(<>){
  if($_ =~ m/^(\w+[\.]*[\d]*)/){
      chomp $_;
    if($1 eq "CP000656.1") {
      print FILE $_ . "\t" . "Mycobacterium gilvum PYR-GCK" . "\n";
     #print FILE $_;
    } elsif($1 eq "CP000854.1") {
      print FILE $_ . "\t" . "Mycobacterium marinum M" . "\n";
    } elsif($1 eq "NC_000962.3") {
      print FILE $_ . "\t" . "Mycobacterium tuberculosis H37Rv" . "\n";
    } elsif($1 eq "NC_002677.1") {
      print FILE $_ . "\t" . "Mycobacterium leprae TN" . "\n";
    } elsif($1 eq "NC_002945.3") {
      print FILE $_ . "\t" . "Mycobacterium bovis AF2122/97" . "\n";
    } elsif($1 eq "NC_008611.1") {
      print FILE $_ . "\t" . "Mycobacterium ulcerans Agy99" . "\n";
    } elsif($1 eq "NC_015758.1") {
      print FILE $_ . "\t" . "Mycobacterium africanum GM041182" . "\n";
    } elsif($1 eq "NC_015848.1") {
      print FILE $_ . "\t" . "Mycobacterium canettii CIPT 140010059" . "\n";
    } elsif($1 eq "NC_021200.1") {
      print FILE $_ . "\t" . "Mycobacterium avium subsp. paratuberculosis MAP4" . "\n";
    } elsif($1 eq "NC_022663.1") {
      print FILE $_ . "\t" . "Mycobacterium kansasii ATCC 12478" . "\n";
    } 
  }
}
close FILE;
