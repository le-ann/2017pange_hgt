#!/bin/bash

# Just a for loop for running indelmiss because I'm too lazy to type it out every time :D
# $1 = tree name
# $2 = psA matrix directory + name (e.g. ~/blahmatrix)
# $3 = runlist directories

mkdir indelmissout

for x in {1..100}
	do 
		Rscript ~/scripts/indelmisstestscript.R /home/ann/github/2017pange_hgt/trees/$1 $2$x $3/run$x > indelmissout/indelmissout$x.txt 
		mv outputforindelmiss.tree outputforindelmiss$x.tree
	done


