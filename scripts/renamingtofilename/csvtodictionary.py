#!/usr/local/bin/python3

import csv
import sys

#file = open(sys.argv[1],'r')

path = '/home/ann/bacteria_assembly/s_pyogenes/gbk/ncbi-genomes-2017-07-13/namelist.csv' 

with open('/home/ann/bacteria_assembly/s_pyogenes/gbk/ncbi-genomes-2017-07-13/namelist.csv','rb') as infile:
	reader=csv.reader(infile)
	with open('/home/ann/bacteria_assembly/s_pyogenes/gbk/ncbi-genomes-2017-07-13/namelist.csv', mode='wb') as outfile:
		mydict = {rows[0]:rows[1] for rows in reader}

with open(sys.argv[1],'r') as file:
	for line in file:
		if line 
