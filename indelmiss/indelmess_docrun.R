# Indelmiss Documentation Sample Documentation Run

rm(list=ls())
library(phangorn)

set.seed(1)

docusertree <- rtree(n=7, br = rbeta(n=7,shape1=1, shape2=7))
plot(docusertree)
docdata <- simSeq(docusertree, l = 5000, type = "USER", levels = c(0, 1), bf=c(1/(1+5), 5/(1+5)), Q=1)
#1 and 5 correspond to unstandardized rates. See item descriptions on mu and nu

docdatab <- matrix(as.numeric(as.character(docdata)), nrow=7)
docuserphyl <- t(docdatab) # Transpose

docindel_user <- indelrates(datasource="user", usertree=docusertree, userphyl = docuserphyl, toi = 1, zerocorrection = TRUE, rootprob = "stationary", modelnames = c("M3","M4"), optmethod = "nlminb", control = list(trace=10))

#------Reordering for 'test' data----------------#
# Apparently order needs to be from bottom to top of tree but here are the commands to test if order
# has an effect on the final output (it does.)

# set.seed(1)

# test <- docuserphyl
# test[,c(1,2,3,4,5,6,7)] <- test[,c(7,2,5,4,6,3,1)] # Rearrange the columns

# testindel <- indelrates(datasource="user", usertree=docusertree, userphyl = test, toi = 1, zerocorrection = TRUE, rootprob = "stationary", modelnames = c("M3","M4"), optmethod = "nlminb", control = list(trace=10))


#------------------------------------------------#

print(docindel_user)


# Original output:
# 
# Call:
#   indelrates(usertree = docusertree, userphyl = docuserphyl, datasource = "user", 
#              toi = 1, zerocorrection = TRUE, rootprob = "stationary", 
#              optmethod = "nlminb", modelnames = c("M3", "M4"), control = list(trace = 10))
# 
# 7 taxa with 4991 gene families and 107 different phyletic gene patterns.
# -----------------------------------
#   Groups of nodes with the same rates:
#   [[1]]
# [1]  1  2  3  4  5  6  7  8  9 10 11 12 13
# 
# -----------------------------------
#   M3 
# $rates
# [,1]
# mu 0.5873599
# nu 2.9485821
# 
# $se
# $se$rates
# [,1]
# mu 0.01421325
# nu 0.07401306
# 
# 
# 
# Loglikelihood for model M3 : -13080.63 
# AIC           for model M3 : -26165.27 
# BIC           for model M3 : -26178.3 
# -----------------------------------
#   M4 
# $rates
# [,1]
# mu 0.587360
# nu 2.948583
# 
# $p
# [1] 0
# 
# $se
# $se$rates
# [,1]
# mu 0.01489754
# nu 0.07513470
# 
# $se$p
# [1] 0.003728937
# 
# 
# Number of genes estimated as missing corresponding to the missing data proportions is:
#   [1] 0
# 
# Loglikelihood for model M4 : -13080.63 
# AIC           for model M4 : -26167.27 
# BIC           for model M4 : -26186.82 
# -----------------------------------
#   Time taken: 1.185 seconds.

# SEED 1 - UNORDERED
# 
# Call:
#   indelrates(usertree = docusertree, userphyl = docuserphyl, datasource = "user", 
#              toi = 1, zerocorrection = TRUE, rootprob = "stationary", 
#              optmethod = "nlminb", modelnames = c("M3", "M4"), control = list(trace = 10))
# 
# 7 taxa with 4991 gene families and 107 different phyletic gene patterns.
# -----------------------------------
#   Groups of nodes with the same rates:
#   [[1]]
# [1]  1  2  3  4  5  6  7  8  9 10 11 12 13
# 
# -----------------------------------
#   M3 
# $rates
# [,1]
# mu 0.5873599
# nu 2.9485821
# 
# $se
# $se$rates
# [,1]
# mu 0.01421325
# nu 0.07401306
# 
# 
# 
# Loglikelihood for model M3 : -13080.63 
# AIC           for model M3 : -26165.27 
# BIC           for model M3 : -26178.3 
# -----------------------------------
#   M4 
# $rates
# [,1]
# mu 0.587360
# nu 2.948583
# 
# $p
# [1] 0
# 
# $se
# $se$rates
# [,1]
# mu 0.01489754
# nu 0.07513470
# 
# $se$p
# [1] 0.003728937
# 
# 
# Number of genes estimated as missing corresponding to the missing data proportions is:
#   [1] 0
# 
# Loglikelihood for model M4 : -13080.63 
# AIC           for model M4 : -26167.27 
# BIC           for model M4 : -26186.82 
# -----------------------------------
#   Time taken: 0.861 seconds.
# 
# SEED 1 - RANDOM ORDER
# 
# Call:
#   indelrates(usertree = docusertree, userphyl = docuserphyl, datasource = "user", 
#              toi = 1, zerocorrection = TRUE, rootprob = "stationary", 
#              optmethod = "nlminb", modelnames = c("M3", "M4"), control = list(trace = 10))
# 
# 7 taxa with 4991 gene families and 107 different phyletic gene patterns.
# -----------------------------------
#   Groups of nodes with the same rates:
#   [[1]]
# [1]  1  2  3  4  5  6  7  8  9 10 11 12 13
# 
# -----------------------------------
#   M3 
# $rates
# [,1]
# mu 0.5873599
# nu 2.9485821
# 
# $se
# $se$rates
# [,1]
# mu 0.01421325
# nu 0.07401306
# 
# 
# 
# Loglikelihood for model M3 : -13080.63 
# AIC           for model M3 : -26165.27 
# BIC           for model M3 : -26178.3 
# -----------------------------------
#   M4 
# $rates
# [,1]
# mu 0.587360
# nu 2.948583
# 
# $p
# [1] 0
# 
# $se
# $se$rates
# [,1]
# mu 0.01489754
# nu 0.07513470
# 
# $se$p
# [1] 0.003728937
# 
# 
# Number of genes estimated as missing corresponding to the missing data proportions is:
#   [1] 0
# 
# Loglikelihood for model M4 : -13080.63 
# AIC           for model M4 : -26167.27 
# BIC           for model M4 : -26186.82 
# -----------------------------------
#   Time taken: 0.861 seconds.