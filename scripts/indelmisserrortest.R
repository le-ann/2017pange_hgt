rm(list=ls())

library(indelmiss)
library(ape)

args = commandArgs(trailingOnly=TRUE)

#--------------------------------------------------------------

# Salmonella error files
# 100: 4, 11, 34, 45, 64, 79, 85 
# 0.9: 38, 92 
setwd("/Users/ann/thesis/2017pange_hgt/indelmiss/salmonella/")
tree <- read.tree("treesout/outputforindelmiss38.tree")
data <- read.csv("salm20PAmatrix/salmmatrix38.csv") # reads in matrix of twenty species, labelled by accession 
run_list <- read.table("plasmid_roaryinput/run38", sep="\n")


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
indel_user <- indelrates(usertree = tree, userphyl = userphyl, lowlim=0.0000001, uplim = 500)

#print(indel_user)
write(indel_user$results$M1$parsep$rates[1,1],file="murates.txt",append=TRUE)
write(indel_user$results$M1$parsep$rates[2,1],file="nurates.txt",append=TRUE)
save.image("image.RData")

