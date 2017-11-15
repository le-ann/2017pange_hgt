#!/bin/bash

#---------------------------------------------------------------------------------------------
# Extracts core genes, soft genes...etc. info from roary summary statistic files
# $1 = present working directory with all the roary run outputs 
#---------------------------------------------------------------------------------------------



for a in {1..100}
	do 
		grep -oP '(?<=Core genes\t\(99\% \<\= strains \<\= 100\%\)\t)\d{1,6}' $1/run$a/summary_statistics.txt >> core_gene_list.txt
	done 

for b in {1..100}
	do 
		grep -oP '(?<=Soft core genes\t\(95\% \<\= strains \< 99\%\)\t)\d{1,6}' $1/run$b/summary_statistics.txt >> soft_core_gene_list.txt
	done

for c in {1..100}
	do 
 		grep -oP '(?<=Shell genes\t\(15\% \<\= strains \< 95\%\)\t)\d{1,6}' $1/run$c/summary_statistics.txt >> shell_gene_list.txt
 	done 

for d in {1..100}
	do 
		grep -oP '(?<=Cloud genes\t\(0\% \<\= strains \< 15\%\)\t)\d{1,6}' $1/run$d/summary_statistics.txt >> cloud_gene_list.txt
	done

for e in {1..100}
	do 
		grep -oP '(?<=Total genes\t\(0\% \<\= strains \<\= 100\%\)\t)\d{1,6}' $1/run$e/summary_statistics.txt >> total_genes_list.txt
	done



# Concatenate files into the correct columns as a csv  using "paste"
# ORDER = [ core genes, soft core genes, shell genes, cloud genes, total genes ]

paste -d , core_gene_list.txt soft_core_gene_list.txt shell_gene_list.txt cloud_gene_list.txt total_genes_list.txt > roaryframe.csv
 
