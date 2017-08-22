#EXTRACTING TIP LABELS
args = commandArgs(trailingOnly=TRUE)


library(ape)
tree <- read.tree(args[1])

write(tree$tip.label, file = "tiplabels.txt", sep = "\n") 

#q()

#vim -c ":%s/'//g" -c ":%s/fna/gff/g" -c ":wq" tiplabels.txt 
