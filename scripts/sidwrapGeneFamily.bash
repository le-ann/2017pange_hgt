#!/bin/bash

# wrapper script for the genefamily perl code because I always forget to grep the blast file first
# $2 is the blast file you want to get gene families from
# $1 is the name of the output file
# $3 is the concatenated faa file with all of the protiein seqs

grep -v '^#' $2 > blast.tmp
perl ~/github/2017pange_hgt/scripts/sidgenefamily11SplitSingletons.pl $1 blast.tmp 
\rm blast.tmp

mv genesForNR.txt nr.tmp
cut -d':' -f2 nr.tmp > genesForNR.txt
rm nr.tmp

~/github/2017pange_hgt/scripts/matchingprotid.py $3 genesForNR.txt > NRgenes.faa &
