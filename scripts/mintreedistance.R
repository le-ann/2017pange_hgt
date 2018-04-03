#E.COLI TREE DISTANCES
args = commandArgs(trailingOnly=TRUE)

library(ape)
tree <- read.tree(args[1])
#tree <- read.tree("/home/ann/bacteria/coli/fixed_tree.tree")

#plot(tree, no.margin = TRUE)
#edgelabels(round(tree$edge.length,2), adj = c(0.5,-0.5), bg = "white", frame = "none", font = 0.5)

run_list <- read.table(args[2], sep="\n")
#run1_list <-read.table("/home/ann/bacteria/coli/run1_coli.txt", sep="\n")

#tiplab <- data.frame(tree$tip.label)
#class(tiplabs)

tiplabs <- tree$tip.label

tiplab_remove <- substr(tiplabs,2, nchar(tiplabs)-1) #removes the quotations from tiplab

#str(tiplabs)    
#str(run1_list)

#match(tiplab_remove, as.character(run1_list[,1])) #wrong order

to_keep<-match(as.character(run_list[,1]), tiplab_remove) #matches where object in run1_list is to tiplab_remove

#to_keep<- to_keep[!is.na(to_keep)] #removes NA (if applicable)

#complement <- tiplab[is.na(pmatch(tiplab,to_keepcopy))] #doesn't work

drop <- tiplabs[-(to_keep)] #finds the complement of the given indices

newtree <- drop.tip(tree, drop) #drops everything within the "drop" vector

plot(newtree, no.margin = TRUE)
edgelabels(round(newtree$edge.length,4), adj = c(0.5,-0.5), bg = "white", frame = "none", font = 0.5)

#write.tree(newtree, "run1_tree.tree")
print(min(newtree$edge.length))

#print("The total distance of the run is") 
#print(sum(newtree$edge.length))

#print(run_list)
#print(tiplabs)



