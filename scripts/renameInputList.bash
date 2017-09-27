#!/bin/bash
#------------------------------------------------------------------------------------------
# Simple code to rename the GFF formatted file name into GBK formatted file names using vim
# This code can be adjusted for different file names (e.g. fna to GBK..etc.)
# $1 = path to directory with all run list inputs
# $2 = old extension
# $3 = new, desired extension 
#------------------------------------------------------------------------------------------

for x in $1/*
	do
		vim -c "%s/GCA/GCF/g" -c ":%s/$2/$3/g" -c ":wq" $x
	done


