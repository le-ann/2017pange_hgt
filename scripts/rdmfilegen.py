#!/usr/local/bin/python3

import csv
import random

file_list = [] #empty list

with open("roaryfile.txt", "r") as roaryfile:              #opens up the file as a readable, CSV file
	file_reader = csv.reader(roaryfile, delimiter=",") #csv reader 
	for row in file_reader:
		file_list.append(row[0])                   #adds element of (only) row into a list

random.shuffle(file_list)                              #shuffles and overwrites former list
randomized = file_list[0:20]                           #pick list of required elements (shorter list)


for x in randomized:
	print(x)
