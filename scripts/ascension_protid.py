#!/usr/local/bin/python3.5
# ---------------------------------------------------------------------------------------
# This code extracts protein IDs and the respective accession numbers of their corresponding species. The code first extracts the ACCESSION numbers and protein IDs from the GenBankfiles through the use of regular expressions. Then, the output file was reopened and reformatted into a dual column format containing the protein ids and their respective ascession numbers.
# WARNING: outputfile.txt file is written under the append("a") function and will be over written should the code be run twice. This has been altered by importing os and removing the transition file after every run, leaving only the final output. 
# ---------------------------------------------------------------------------------------

import re
import sys
import os

compil_asn = re.compile('^ACCESSION.*$')
compil_protID = re.compile('protein_id') 

with open(sys.argv[1]) as file:
	for line in file.readlines(): 
		asn_num  = re.match(compil_asn,line)
		prot_id = re.search(compil_protID, line)
		if asn_num != None:
			with open("outputfile.txt","a") as output:
				output.write(line)
		if prot_id != None:
			with open("outputfile.txt","a") as output:
				output.write(line)

asn_pattern = re.compile('(?<=ACCESSION)\s+[A-Z]+\d+')
prot_pattern = re.compile('(?<=protein_id=\")[A-Z]+\d+.\d+')

with open("outputfile.txt","r") as file2:
	for line in file2.readlines():
		asn_num_only = re.search(asn_pattern, line)
		prot_id_only = re.search(prot_pattern, line)
		if asn_num_only != None:
			accession = "".join(asn_num_only.group(0).split())
		if prot_id_only != None:
			print(accession,"\t",prot_id_only.group(0))

os.remove("outputfile.txt")	
