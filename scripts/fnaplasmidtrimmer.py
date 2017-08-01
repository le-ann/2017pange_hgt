#!/usr/local/bin/python3

import sys

file = open(sys.argv[1],'r')

read = ""
new_read = ""
title_location = []
i = 1



for line in file:
	read = read + line

for character in read:
	if character == "\n":
		 i+=1
	if character == ">":
		title_location.append(i)
		#print(i)

#print(title_location[1])

if len(title_location) > 1:
	a = 1
	for x in read:
	#	print(x)
		new_read = new_read + x
		if x == "\n":
			a+=1
		if a >= title_location[1]:
			break			
	print(new_read)
else:
	print(read)
	
