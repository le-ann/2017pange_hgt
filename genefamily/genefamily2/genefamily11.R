rm(list=ls())
ptm <- proc.time()
y <- as.matrix(read.table("output.txt"))
taxanames <- attr(table(y[,1]), "dimnames")[[1]] #for genefamilycomplete2.R
y[, 1] = paste(y[, 1], y[, 2], sep=" ")
y[, 7] = paste(y[, 7], y[, 8], sep=" ")

gfnames <- vector(mode = "list", length = length(y[, 1]))
gfind <- 1
gfnames[[gfind]]    <- y[1, 1]
#the first query initializes the first component of the list
rvers <- as.character(getRversion())

for(i in 1:nrow(y)){
  if(i %% 5000 == 0) cat(i, "       ")
  gene <- y[i, 1]
  genehit <- y[i, 7]
  if(!compareVersion(rvers, "3.2.0") < 0) {
    sgfl <- lengths(gfnames[1:gfind]) #lengths does the same thing as #sapply(gfnames[1:gfind], length). Check ?lengths for lists.
  } else {
    sgfl <- sapply(gfnames[1:gfind], length)
  }
  ungf <- unlist(gfnames[1:gfind], use.names = FALSE)
  s <- seq_along(gfnames[1:gfind])

  le  <- rep(s, sgfl)[match(gene, ungf)]
  #le is the gene family number (if any) that gene already is known to belong to
  gle <- rep(s, sgfl)[match(genehit, ungf)]
  #gle is the gene family number (if any) that genehit already is known to belong to.

  if(!is.na(le) & !is.na(gle)){ #if both le and gle exist
    ind <- grep(genehit, x = y[, 1], fixed = TRUE)
    if(gene %in% y[ind, 7])  #reciprocal best hit is TRUE
    {
      if(le != gle){ #if gene and genehit have previously been recorded in different gene families.
        #because they are reciprocal best hits, the le and gle gene families need to be merged.
        #The genefamily (list component) into which the values are merged will also have gene and
        #genehit. The other component should be assigned NA.
        min_le <- min(le, gle)
        max_le <- max(le, gle)
        gfnames[[min_le]]    <- c(gfnames[[min_le]], c(gene, genehit, gfnames[[max_le]]))
        gfnames[[max_le]]    <- NULL
      } #else #if gene and genehit have previously been recorded in the same gene family, nothing is needed
    } #else #if reciprocal best hit is not TRUE, nothing is needed as gene is already in le.
  } else if(!is.na(le) & is.na(gle)){ #if only le exists
    ind <- grep(genehit, x = y[, 1], fixed = TRUE)
    if(gene %in% y[ind, 7])  #reciprocal hit is TRUE, add genehit to le
    {
      gfnames[[le]]    <- c(gfnames[[le]], genehit)
    }
  } else if(is.na(le) & !is.na(gle)){ #if only gle exists
    ind <- grep(genehit, x = y[, 1], fixed = TRUE)
    if(gene %in% y[ind, 7])  #reciprocal hit is TRUE, add gene to gle
    {
      gfnames[[gle]]    <- c(gfnames[[gle]], gene)
    } else { #reciprocal hit is not TRUE, add gene to a new family.
      gfind               <- gfind + 1 #add additional gene family
      gfnames[[gfind]]    <- gene #add gene name
    }
  } else { #else if(is.na(le) & is.na(gle)){ #would a simple else suffice?
    gfind               <- gfind + 1 #add additional gene family
    gfnames[[gfind]]    <- gene #add gene name
  }
}
save.image("gfcode1.Rdata")
gfnames           <- gfnames[!unlist(lapply(gfnames, is.null))]
#Remove NULL components if any

gfnames_unique    <- lapply(X = gfnames, FUN = unique)
#Unique names only

allgenes          <- as.matrix(read.table("listofallgenes.txt"))
allgenes[, 1] <- paste(allgenes[, 1], allgenes[, 2], sep=" ")
genesnotfound     <- setdiff(allgenes[, 1], y[, 1]) #compare with y[,1] because every gene in y[,1] will end up in gfnames_unique and genefamily_unique.

#Add in genes that did not meet the gene family criteria

vgnf <- gsub(pattern = " ", replacement = "_cdsid_", x = genesnotfound, fixed = TRUE)
#vector of names of genes not found as compared to list of all genes.

gnamfam <- list()
gfam <- list()
for(i in 1:length(gfnames_unique)){
  temp_1 <- NULL
  temp_2 <- NULL
  for(j in 1:length(gfnames_unique[[i]])){
    temp <- stringr::str_split_fixed(gfnames_unique[[i]][j], " ", n = 2)
    temp_1 <- c(temp_1, temp[,1])
    temp_2 <- c(temp_2, temp[,2])
  }
  gfam[[i]] <- temp_1 #taxa names; for the gene family list constructed overall
  gnamfam[[i]] <- temp_2 #gene names; for the gene family list constructed overall
}
gfam_unique    <- lapply(X = gfam, FUN = unique) #for genesforalignment_individualgenes
# split_taxa_gene <- lapply(gfnames_unique, function(y){stringr::str_split_fixed(y, " ", n = 2)})
#If there are orthologs from 1 taxa that never
#hit anything from any other species, all the orthologs are checked against
#NR database. Now, orthologs should be in one gene family. So, if any are valid when checked against NR, one row should be added to the gene family matrix with a 1 for this taxa. If more than one are valid, it should still be only 1 row being added. Basically, valid ortholog genes not being hit against the other taxa should only counted as 1 gene family.

pos_singletons <- which(sapply(X = gfam_unique, FUN = length) == 1)
#supplement this with singleton genes unique to only one species. This list also includes orthologs unique to a single species.
singletons <- unlist(gfnames_unique[pos_singletons])
singletons_cd <- gsub(pattern = " ", replacement = "_cdsid_", x = singletons, fixed = TRUE)

genesforNR <- c(vgnf, singletons_cd) #includes all genes that didn't make the cut

gfnameswosing           <- gfnames_unique[-pos_singletons]#gfnames_unique[!unlist(lapply(gfnames_unique, length)==1)]
gfamwosing <- gfam[-pos_singletons]#Without singletons - for genefamilycomplete2
gnamfamwosing <- gnamfam[-pos_singletons]#Without singletons - for genefamilycomplete2

write.table(genesforNR,"genesforNR.txt",quote=FALSE,row.names=FALSE,col.names=FALSE)
timetaken <- proc.time() - ptm
save.image("gfcode1.Rdata")
