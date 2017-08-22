#!/usr/local/bin/python3

#----------------------------------------------------------------------------------------
# GENBANK TRIMMER

# This code trims genbank files after the first record, thereby eliminating any plasmids from the data
#----------------------------------------------------------------------------------------

import sys
import re

break_compile = re.compile('^//')

with open(sys.argv[1],'r') as file:
	for line in file.readlines():
		file_break = re.match(break_compile, line)
		print(line)
		if file_break != None:
			break
		
