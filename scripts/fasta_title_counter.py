#!/usr/local/bin/python3.5
import sys
file = open(sys.argv[1],'r')

title=0 

for line in file:
	for x in line:
		if x == ">":
			title+=1

print("The number of titles is", title)

