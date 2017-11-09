#!/usr/local/bin/R
# Extracts list of smaller matrix from the larger presenceAbsence matrix given a list of relevant 
# accession numbers. The code will extract only the rows corresponding to the numbers given in the
# list. 
# args[1] - read in list of accession numbers
# args[2] - read in presence absence matrix
# args[3] - desired_name.csv

rm(list=ls())
args = commandArgs(trailingOnly=TRUE) # use to read arguments later

listofacc <- read.table(args[1])
psAmatrix <- as.matrix(read.csv(args[2]))


# listofacc <- read.table("testlist.txt")
# psAmatrix <- as.matrix(read.csv("perlmatrixoutput.csv"))

toExtract <- match(as.vector(listofacc[,1]), psAmatrix)

smallpsAMatrix <- psAmatrix[c(toExtract),]

# print(smallpsAMatrix)

 write.csv(smallpsAMatrix, as.character(args[3]), quote = FALSE) 
