#!/usr/local/bin/python3
#--------------------------------------------------------
# This code was created because I'm an idiot. To be used in line with attempt.bash, which
# generates the csv required for this code to convert it into a dictionary in order
# to map the accession file names back into the file names.
# You probably won't need it
#----------------------------------------------------------

import csv
import sys

#file = open(sys.argv[1],'r')

namelist = '/home/ann/bacteria_assembly/s_pyogenes/gbk/ncbi-genomes-2017-07-13/namelist.txt' 

namemap = {} # initiates dictionary

with open(namelist,'r') as csvfile:
	reader=csv.reader(csvfile)
	for rows in reader:
		namemap.update({rows[0]:rows[1]})


with open('accessioninput17','r') as file:
	for line in file:
		print(namemap[line.rstrip()])


