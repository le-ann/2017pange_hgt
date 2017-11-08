#!/bin/bash

# Just a for loop for running indelmiss because I'm too lazy to type it out every time :D
# $1 = tree name
# $2 = psA matrix directory + name (e.g. ~/blahmatrix)
# $3 = runlist directories
# $4 = accession directory

mkdir indelmissout
mkdir treesout 

for x in {1..100}
	do 
		Rscript ~/scripts/indelmisstestscript.R /home/ann/github/2017pange_hgt/trees/$1 $2$x.csv $3/run$x > indelmissout/indelmissout$x.txt $4/accessioninput$x 
		if [ -f outputforindelmiss.tree ]
		then
			mv outputforindelmiss.tree outputforindelmiss$x.tree
			mv outputforindelmiss$x.tree treesout/
		
		fi    
	done


