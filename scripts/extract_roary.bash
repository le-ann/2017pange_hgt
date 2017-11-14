#!/bin/bash

#---------------------------------------------------------------------------------------------
# Extracts core genes, soft genes...etc. info from roary summary statistic files
# $1 = present working directory with all the roary run outputs 
#---------------------------------------------------------------------------------------------



for a in {1..100}
	do 
		grep -oP '(?<=Core genes\t\(99\% \<\= strains \<\= 100\%\)\t)\d{3,4}' $1/run$a/summary_statistics.txt >> core_gene_list.txt
	done 

for b in {1..100}
	do 
		grep -oP '(?<=Core genes\t\(99\% \<\= strains \<\= 100\%\)\t)\d{3,4}' $1/run$a/summary_statistics.txt >> core_gene_list.txt
	done

for c in {1..100}
	do 
 		grep -oP '(?<=Core genes\t\(99\% \<\= strains \<\= 100\%\)\t)\d{3,4}' $1/run$a/summary_statistics.txt >> core_gene_list.txt
 	done 

for d in {1..100}
	do 
		grep -oP '(?<=Core genes\t\(99\% \<\= strains \<\= 100\%\)\t)\d{3,4}' $1/run$a/summary_statistics.txt >> core_gene_list.txt
	done 
