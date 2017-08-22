load("gfcode1.Rdata")
geneind <- which(unlist(lapply(gnamfam,length))==10 & unlist(lapply(gfam_unique,length))==10)
#Using gnamfam guarantees 10 genes overall, i.e., no paralogues, etc. 
#We are going after core genes here.
#However, because there could be multiple genes from the same
#genome and the length equal to 10 condition can still be satisfied,
#gfam_unique is also used. This means that 10 unique genes
#from each of the 10 genomes will be found.
no <- 50
geneind[1:no]
genesforalign <- list()
genesforalign_s <- list() #sorted

for(r in 1:length(geneind[1:no])){
  genesforalign[[r]] <- sort(paste(gfam[[geneind[r]]],gnamfam[[geneind[r]]],sep="_cdsid_"))
}
genesforalign_s <- lapply(genesforalign, sort)
genesmat <- matrix(unlist(genesforalign_s[1:no]),10,no,byrow=F)

for(l in 1:ncol(genesmat)){
  write.table(genesmat[,l], file=paste("Gfagenome_ind_", l, sep = ""),
              sep="\n",quote=FALSE,row.names=FALSE,col.names=FALSE)
}
