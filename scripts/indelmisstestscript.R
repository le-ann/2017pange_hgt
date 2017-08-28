#!/usr/local/bin/R
#---------------------------------------
# Reference file on how to run indelmiss
#---------------------------------------

args = commandArgs(trailingOnly=TRUE)

#args[1] = tree
#args[2] = presence-absence matrix
#args[3] = run list 

library(indelmiss)
library(ape)

ogtree <- read.tree(args[1])
data <- read.csv(args[2]) # read csv regularly with header
run_list <- read.table(args[3], sep="\n")

#-----------------Tree Trimmer-----------------------------------#

tiplabs <- ogtree$tip.label
tiplab_remove <- substr(tiplabs,2,nchar(tiplabs)-1) # removes quotations

to_keep <- match(as.character(run_list[,1]), tiplab_remove) # matches where object is in run_list 

drop <- tiplabs[-(to_keep)] # finds the complement of the given indices

outtree <- drop.tip(tree, drop) # drops everything within the "drop" vector 

plot(outtree, no.margin = TRUE)
edgelabels(round(tree$edge.length,4), adj = c(0.5,-0.5), bg = "white", frame = "none", font = 0.5)

write.tree(newtree, "outputforindelmiss.tree")

tree <- read.tree("outputforindelmiss.tree")
#----------------------------------------------------------------#


#set.seed(123) # set a seed
datab <- as.matrix(data) # convert to matrix
userphyl <- t(datab) # transpose the matrix

# Run indelrates
indel_user <- indelrates(usertree = tree, userphyl = userphyl)

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
