#!/usr/local/bin/R
#---------------------------------------
# Reference file on how to run indelmiss
#---------------------------------------
rm(list=ls())

library(indelmiss)
library(ape)

args = commandArgs(trailingOnly=TRUE)

#args[1] = tree
#args[2] = presence-absence matrix
#args[3] = run list 
#args[4] = accession numbers list 

#--------------Customized Laptop Files-----------------------
# Comment out for for loop use 

setwd("~/thesis/2017pange_hgt/indelmiss")
# 
# ogtree <- read.tree("spyogenes_rooted.tree")
# data <- read.csv("noquotesspyognesout.csv")
# run_list <- read.table("run1", sep = "\n")
# acces_list <- read.table("accessioninput1", sep = "\n")
#------------------------------------------------------------


ogtree <- read.tree("../trees/rooted_pestis.tree")
data <- read.csv("ypestismatrix1.csv")
run_list <- read.table("ypestisrun1", sep = "\n")
acces_list <- read.table("accessioninput1", sep = "\n")

#------------------------------------------------------------

ogtree <- read.tree(args[1]) # reads in original unclipped tree, names listed as "GCF...etc.", with roary run list
data <- read.csv(args[2]) # reads in matrix of twenty species, labelled by accession 
run_list <- read.table(args[3], sep="\n") # roary run list "GCF...fna" format
acc_list <- read.table(args[4], sep="\n") # accession numbers



#-----------------Tree Trimmer-----------------------------------#

tiplabs <- ogtree$tip.label
tiplab_remove <- substr(tiplabs,2,nchar(tiplabs)-1) # removes quotations

to_keep <- match(as.character(run_list[,1]), tiplab_remove) # matches where object is in run_list 

drop <- tiplabs[-(to_keep)] # finds the complement of the given indices

outtree <- drop.tip(ogtree, drop) # drops everything within the "drop" vector 

plot(outtree, no.margin = TRUE)
edgelabels(round(outtree$edge.length,4), adj = c(0.5,-0.5), bg = "white", frame = "none", font = 0.5)

write.tree(outtree, "outputforindelmiss.tree")

tree <- read.tree("outputforindelmiss.tree")

#--------------------------------------------------------------------------------#
# plot(tree)
# Reorder data matrix into correct matrix from bottom to top of tree
data$X.1 <- NULL #include only if there exists an extra column of numbers at the beginning (to be modified)c
data[,1] <- run_list[,1]
tree$tip.label <- substr(tree$tip.label,2,nchar(tree$tip.label)-1) # remove quotes

library(dplyr)
#ogdata <- data
data <- data %>% slice(match(c(tree$tip.label),X)) # rearranges the factors into order matching tree

#------------------------------------------------------------------------------#

#set.seed(123) # set a seed
#datab <-  # convert to matrix
#userphyl <- t(datab) # transpose the matrix

# Converting data into userphyl format, which is JUST a matrix of 0s and 1s
nums <- sapply(data, is.numeric) # Denotes which are numeric elements in the original matrix
numonlydata <- data[,nums] # Subsets elements that are TRUE only
userphyl <- t(numonlydata) # Transpose to fit with indelrates format

# Run indelrates
set.seed(123)
indel_user <- indelrates(usertree = tree, userphyl = userphyl)

print(indel_user)

#-------------------------------------------------------------------



# Documentation notes:
# M1 - estimates indel rates where both insertion and deletion rates are the same
# M2 - accounts for possible missing data while estimating indel rates
# M3 - estimates insertion and deletion rates separately 
# M4 - accounts for possible missing data while estimating insertion and deletion rates separately  


# sample output 
# Call:
# indelrates(usertree = tree, userphyl = userphyl)
# 
#  5 taxa with 4818 gene families and 32 different phyletic gene patterns.
# -----------------------------------
# Groups of nodes with the same rates:
# [[1]]
# [1] 1 2 3 4 5 6 7 8 9
# 
# -----------------------------------
# M1 
# $rates
#         [,1]
# mu 0.8269211
# nu 0.8269211
# 
# $se
# $se$rates
#          [,1]
# mu 0.02280058
# nu 0.02280058
# 
# 
# 
# Loglikelihood for model M1 : -15138 
# AIC           for model M1 : -30278 
# BIC           for model M1 : -30277.61 
# -----------------------------------
# M2 
# $rates
#         [,1]
# mu 0.6838036
# nu 0.6838036
# 
# $p
# [1] 0.1164538
# 
# $se
# $se$rates
#          [,1]
# mu 0.01819685
# nu 0.01819685
# 
# $se$p
# [1] 0.005380595
# 
# 
# Number of genes estimated as missing corresponding to the missing data proportions is:
#  [1] 419
# 
# Loglikelihood for model M2 : -13700.91 
# AIC           for model M2 : -27405.82 
# BIC           for model M2 : -27405.04 
# -----------------------------------
# M3 
# $rates
#         [,1]
# mu 0.8277939
# nu 0.8337843
# 
# $se
# $se$rates
#          [,1]
# mu 0.02429750
# nu 0.06850801
# 
# 
# 
# Loglikelihood for model M3 : -15137.99 
# AIC           for model M3 : -30279.99 
# BIC           for model M3 : -30279.21 
# -----------------------------------
# M4 
# $rates
#         [,1]
# mu 0.6716713
# nu 0.5186157
# 
# $p
# [1] 0.1164697
# 
# $se
# $se$rates
#          [,1]
# mu 0.01766361
# nu 0.05162335
# 
# $se$p
# [1] 0.005380365
# 
# 
# Number of genes estimated as missing corresponding to the missing data proportions is:
#  [1] 419
# 
# Loglikelihood for model M4 : -13695.94 
# AIC           for model M4 : -27397.88 
# BIC           for model M4 : -27396.71 
# -----------------------------------
# Time taken: 1.977 seconds.

#S.pyogenes Sample Run
#
#Call:
#  indelrates(usertree = tree, userphyl = userphyl)
#
#20 taxa with 2673 gene families and 949 different phyletic gene patterns.
#-----------------------------------
#  Groups of nodes with the same rates:
#  [[1]]
#[1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
#[26] 26 27 28 29 30 31 32 33 34 35 36 37 38 39
#
#-----------------------------------
#  M1 
#$rates
#[,1]
#mu 1.369977
#nu 1.369977
#
#$se
#$se$rates
#[,1]
#mu 0.02252019
#nu 0.02252019
#
#
#
#Loglikelihood for model M1 : -28808.75 
#AIC           for model M1 : -57619.5 
#BIC           for model M1 : -57625.63 
#-----------------------------------
#  M2 
#$rates
#[,1]
#mu 1.332947
#nu 1.332947
#
#$p
#[1] 0.07563533
#
#$se
#$se$rates
#[,1]
#mu 0.02206596
#nu 0.02206596
#
#$se$p
#[1] 0.006699188
#
#
#Number of genes estimated as missing corresponding to the missing data proportions is:
#  [1] 123
#
#Loglikelihood for model M2 : -28499.02 
#AIC           for model M2 : -57002.03 
#BIC           for model M2 : -57014.28 
#-----------------------------------
#  M3 
#$rates
#[,1]
#mu 1.262131
#nu 1.607776
#
#$se
#$se$rates
#[,1]
#mu 0.02423150
#nu 0.03602354
#
#
#
#Loglikelihood for model M3 : -28766.18 
#AIC           for model M3 : -57536.36 
#BIC           for model M3 : -57548.61 
#-----------------------------------
#  M4 
#$rates
#[,1]
#mu 1.223477
#nu 1.577018
#
#$p
#[1] 0.07570527
#
#$se
#$se$rates
#[,1]
#mu 0.02366771
#nu 0.03556520
#
#$se$p
#[1] 0.006699509
#
#
#Number of genes estimated as missing corresponding to the missing data proportions is:
#  [1] 123
#
#Loglikelihood for model M4 : -28453.11 
#AIC           for model M4 : -56912.22 
#BIC           for model M4 : -56930.59 
#-----------------------------------
#  Time taken: 16.143 seconds.
