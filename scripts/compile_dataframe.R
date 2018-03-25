#!/usr/local/bin/R
#--------------------------------------------------------------------------------------
# Given input files for distance, indelmiss rates and pangenome sizes. This simple code
# concatenates those three elements into a single large dataframe.
# args[1] = distance.csv
# args[2] = pangenome.csv
# args[3] = indelrates.csv
# --------------------------------------------------------------------------------------

rm(list=ls())

library(indelmiss)
library(ape)

args = commandArgs(trailingOnly=TRUE)

dist <- read.csv("distance.csv")
pange <- read.csv("pangenome.csv")
indelrates <- read.csv("indelrates.csv")

df <- data.frame(dist,pange,indelrates)

write.csv(df, "dataframe.csv")
