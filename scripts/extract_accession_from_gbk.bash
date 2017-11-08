#!/bin/bash

#--------------------------------------------------------------------------------------
# Extracts the accession numbers for a particular list of gbk files from the respective
# gbk files.
# $1 = path to directory with all the run list inputs
# Note: the output directory points to inputfiles, and should be created before the code
# is executed 
#--------------------------------------------------------------------------------------

for y in {1..100}
	do 
		for x in `cat $1/run$y`
			do
				grep -oP '(?<=ACCESSION)\s{3}[A-Z]{2}\d{6}' $x >> inputfiles/accessioninput$y
			done
	done 


# Removal of space limiter
if [ `ls ./inputfiles/* | wc -l` == 100 ]
then 
	for x in ./inputfiles/accessioninput{1..100}
	do
		vim -c ":%s/\s\{3}//g" -c ":wq" $x
	done
fi 

			 
