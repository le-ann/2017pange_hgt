rm(list=ls())
load("gfcode1.Rdata")

a <- readr::read_delim("./NRresults/NRaddcolfiltered.txt", delim = "\t", col_names = FALSE)
#View(a)
a <- as.matrix(a)
validind <- NULL
for(i in 1:nrow(a)){
  if(grepl(pattern = "MULTISPECIES", fixed = TRUE, x = a[i, 14])) {
    validind[i] <- i
    next
  } else{
    #tmp <- strsplit(a[i, 14], split = "<>", fixed = TRUE)
    if(!all(grepl(pattern = a[i, 15], fixed = TRUE, x = unlist(strsplit(a[i, 14], split = "<>", fixed = TRUE))))) {
      validind[i] <- i
    }
  }
}
validind <- as.numeric(na.omit(validind))
hitstoitself_filtered <- a[validind, ]

NRuniquehits   <- as.vector(unique(hitstoitself_filtered[,1]))
NRuniquefamily <- matrix(NA, nrow=length(NRuniquehits), ncol = 2)
NRuniquefamily[,1] <- NRuniquehits
NRuniquefamily[,1] <- gsub(pattern = "_cdsid_", replacement = " ", x = NRuniquefamily[,1], fixed = TRUE)

#sgfl2 <- lengths(gfnames_unique) #lengths does the same thing as #sapply(gfnames[1:gfind], length). Need R 3.2.0 and above though. Check ?lengths for lists.
sgfl2 <- NULL
if(!compareVersion(rvers, "3.2.0") < 0) {
  sgfl2 <- lengths(gfnames_unique) #lengths does the same thing as
#sapply(gfnames[1:gfind], length). Check ?lengths for lists.
} else {
  sgfl2 <- sapply(gfnames_unique, length)
}
ungf2 <- unlist(gfnames_unique, use.names = FALSE)
s2 <- seq_along(gfnames_unique)

for(i in 1:length(NRuniquefamily[,1])){
  NRuniquefamily[i, 2]  <- rep(s2, sgfl2)[match(NRuniquefamily[i, 1], ungf2)]
} #needed in case of orthologs that don't hit anything else...

# sort(table(NRuniquefamily[,2], useNA = "ifany"))

gfnamescomplete    <- gnamfamwosing
genefamilycomplete <- gfamwosing
startc <- length(gnamfamwosing) + 1
endc   <- length(gnamfamwosing) + length(table(NRuniquefamily[,2], useNA = "no")) + sum(is.na(NRuniquefamily[,2]))

#length of valid genes from vgnf
len_valid_vgnf <- sum(is.na(NRuniquefamily[,2])) #these are the NAs
splitvgnfvalid <- strsplit(as.character(NRuniquefamily[1:len_valid_vgnf, 1]),fixed=TRUE,split=" ")
gfnamescomplete[ startc:(startc - 1 + len_valid_vgnf) ] <- lapply(splitvgnfvalid, "[[", 2)
genefamilycomplete[ startc:(startc - 1 + len_valid_vgnf) ] <- lapply(splitvgnfvalid, "[[", 1)

pos_orth_valid <- NRuniquefamily[-(1:len_valid_vgnf),] #valid gene subset which could hold possible orthologs

unique_genefam <- !duplicated(pos_orth_valid[,2])
taxaandgene <- strsplit(as.character(pos_orth_valid[unique_genefam,1]), fixed = TRUE,split = " ")
gfnamescomplete[(startc - 1 + len_valid_vgnf + 1):endc]    <- lapply(taxaandgene, "[[", 2)
genefamilycomplete[(startc - 1 + len_valid_vgnf + 1):endc] <- lapply(taxaandgene, "[[", 1)

genefamilymat <- matrix(0, length(genefamilycomplete), length(taxanames))
colnames(genefamilymat) <- taxanames
#
for(i in 1:length(genefamilycomplete)){
  cols <- na.omit(match(genefamilycomplete[[i]], table = taxanames))
  genefamilymat[i, cols] <- 1
}
# # mg <- NULL #gene families with more genes than total number of taxa
# # for(i in 1:length(gfnames_unique)){
# #   if(length(gfnames_unique[[i]])>3) mg[i] <- i
# # }
# # mg<-na.omit(mg)

# datab      <- t(genefamilymat)
# phyl       <- ncol(datab)
# nooftaxa   <- nrow(datab)
# datab[which(datab>1)] <- 1
# databp     <- datab
# w          <- summary(as.factor(apply(databp,2,paste,collapse="")),maxsum=ncol(databp))
# b          <- attr(w,"names")
# ww         <- unname(cbind(b,w))
# databp_red <- matrix(na.omit(as.numeric(unlist(stringr::str_split(ww[,1],"")))),ncol=nooftaxa,byrow=T)
# databp_red <- rbind(databp_red,rep(0,nooftaxa))
# w
# sum(w)

write.table(genefamilymat, "geneconR.txt", row.names = FALSE)
save.image("gfcode2.Rdata")
