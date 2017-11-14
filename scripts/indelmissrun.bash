#!/bin/bash

# Just a for loop for running indelmiss because I'm too lazy to type it out every time :D
# $1 = tree name
# $2 = psA matrix directory + name (e.g. ~/blahmatrix)
# $3 = runlist directories
# $4 = accession directory

mkdir indelmissout
mkdir treesout 
mkdir indelmissimages
touch murates.txt nurates.txt

for x in {1..100}
	do
		echo $x >> murates.txt	
		echo $x >> nurates.txt # remove these two lines when errors have been solved   
		Rscript ~/scripts/indelmisstestscript.R /home/ann/github/2017pange_hgt/trees/$1 $2$x.csv $3run$x > indelmissout/indelmissout$x.txt $4accessioninput$x 
		if [ -f outputforindelmiss.tree ]
		then
			mv outputforindelmiss.tree outputforindelmiss$x.tree
			mv outputforindelmiss$x.tree treesout/
		fi
		if [ -f image.RData ]
		then 
			mv image.RData image$x.RData
			mv image$x.RData indelmissimages/
		fi    
	done


