#!/bin/bash
# Run this series of codes from the directory containing getfeatures 
# and all the gbff files. 
#-------------------------------------------------------------------
# PART I: renameInputList.bash
# Renames the inputlist extensions and names to desired GBK format
# 
# Relevant arguments
# $1 = path to directory with all run list inputs
# $2 = old extension
# $3 = new, desired extension
# $4 = name of PAmatrix
# $5 = bacteria name
#------------------------------------------------------------------

for x in $1/*
	do
		vim -c ":%s/GCF/GCA/g" -c ":%s/$2/$3/g" -c ":wq" $x
	done

mkdir inputfiles

#-------------------------------------------------------------------
# PART II: extractingAccessionNumbers
# Extracts the accession numbers for a particular list of gbk files
# from the respective gbk files
# $1 = path to directory with all run list inputs
#-------------------------------------------------------------------

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

#---------------------------------------------------------------------------
# PART III: extractmatricesof20
# Extract list of smaller matrix from larger presenceAbsence matrix given a list
# of relevant accession numbers. The code will extract only the rows corresponding to numbers
# given in list. 
# Incorporates R code at absolute path destination so verify the absolute path
# $4 - name of presenceAbsencematrix  
# $5 - bacteria name
#-----------------------------------------------------------------------------

mkdir getfeatures/20PAmatrix

for z in {1..100}
	do
		Rscript ~/scripts/extractSmallerMtrx.R ./inputfiles/accessioninput$z getfeatures/$4 getfeatures/20PAmatrix/$5matrix$z.csv
	done 



