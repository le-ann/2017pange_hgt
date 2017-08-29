# This code takes in a space delimited txt file of all thee genefamilies for a set of orgnaisms
# and files with an accession number as the name and the contetns being all the protein IDs for that
# organism. It then creates a presence absence matrix for each organim and genefamily
#needs a list of each organism and all genes belonging to that organism
#This can be made with getTaxaNamesandGenes.bash

## command I used to format filtere blast table in vim was 
##        /||[A-Za-z0-9\._\/=\-\,():\[\]+]\+|\(|[A-Za-z0-9\.]\+\t\)
##        :%s//\t\1/g

rm(list=ls()) #removes all objects in current R environment

args=commandArgs(trailingOnly=TRUE)
# args = [path to dir with of protein list files, path to genefamilies.txt, name of family of organisms being fed in]
# args[1] = '~/summer2017/bacillusProteinList'
# args[2] = '~/summer2017/bacillusGeneFamilies.txt'
# args[2] = 'bacillus'

# *just in case, vim command to convert non terse protein name to terse form is 
# %s/\(\s[A-Z0-9]{8}\)\@<=.\+\{-1,}\([A-Z0-9\.]\{10}\s\)\@=/:/g
# %s/\(\s[A-Z0-9]{8}\)\@<=[^ ]\+\{-1,}\([A-Z0-9\.]\{10}$\)\@=/:/g





#--------------------------Setting Up Col values (organisms)----------------
path=toString(args[1]) #path to dir that contians list of files, each name is an accession # and thefile contains all the protein IDs associated with the organism

file.names <- dir(path, pattern='.prots') #gets all file names (which are accession #s ) in path
orgenes <- data.frame() 
for (i in 1:length(file.names)){
    name <-toString(gsub(".prots$","",file.names[i])) #strips the .prots from the filename
    orgenes <- c(orgenes,assign(name,read.table(paste(path,toString(file.names[i]), sep=''), header=FALSE))) #creates a variable whose name is the acc# and which contains a list of all the protIDs for that acc#
}  
#---------------------------------------------------------------------------





#--------------------------Setting Up Row Values (genefams)-----------------
##all the hard work was done in the famcreator.R code, which create the gene families and is loaded into the session
#load(args[2])

famstxt <- read.table(args[2], header=FALSE, sep=' ', fill=TRUE) #read in gene families from txt file
charfams <- sapply(famstxt[,3:ncol(famstxt)], as.character) #converts factors to strings
listcharfam <- split(charfams, seq(nrow(charfams))) # converts dataframe to list of lists
genefamilies<- vector("list", length(listcharfam)) # initializes empty list of lists
for (gf in 1:length(listcharfam)){ 
    tmp <- listcharfam[[gf]]
    genefamilies[[gf]] <- tmp[tmp != ""] # filters out empty string from each family
}

#---------------------------------------------------------------------------






#-------------------------Building Presence/Absence Matrix------------------

presenceAbsence <- matrix(2,nrow=length(orgenes), ncol=length(genefamilies)) #initializes a matrix full of 2's, if there is an error, will show up as 2, not 1 or 0 in final matrix

colnames(presenceAbsence) <- colnames(presenceAbsence, do.NULL=FALSE, prefix="genefam") #set colum names too be genefam1, genefam2 etc. for readability

rnams <- list()
for (i in 1:length(file.names)){
    rnams <-c(rnams,toString(gsub(".prots$","",file.names[i]))) # creates a list of accession numbers read into R in part one
}

rownames(presenceAbsence) <- rnams # set the row names of the matrix to be the accession numbers of the orgnisms

for (fam in 1:length(genefamilies)){ # for each gene family
    for (org in 1:length(orgenes)){ # for each organism
        numberOfMatches<- 0 # number of genes in organism that are also in gene family
        for (gene in 1:length(orgenes[[org]])){ # for each gene (protein ID) in the organism
            if (as.character(orgenes[[org]][gene]) %in% genefamilies[[fam]]){ # if the gene is in the current family
                numberOfMatches<- i+1 # increment
            }
        }
        if (numberOfMatches == 0) { # if no genes are found in the current family
            presenceAbsence[org,fam] <- 0   
        } else { # if >1 genes are founf in the current family
            presenceAbsence[org,fam] <- 1
        }
    }
}

save.image(c(str(args[3]),"PAmatrix.RData"))
write.table(presenceAbsence, file=c(str(args[3]),"PAmatrix.txt"), row.names=TRUE col.names=TRUE)


#----------------------------------------Extracting Families to Create Tree-----------------------------------------

eqs <- function(x,y) if (x==y) x else FALSE #function for checking if two elemnts are equal
cols <- list() #initializes empty list
for (cl in 1:ncol(presenceAbsence)){ #for each family in the PA matrix (families are colums)
    if (presenceAbsence[1,cl]==1){ # if the value of the matrix for the first row in that colum is 1
        cols <- c(cols,ifelse(Reduce(eqs,presenceAbsence[,cl]),cl,FALSE)) # check if every other row is 1, if so append the colum number to cols
    } else { # otherwise append FALSE
        cols <- c(cols,FALSE)
    }
}

treefamilies <- genefamilies[unlist(cols)] # gets all the families present in every organism
treeMembers <- data.frame() # initalize empty df for the single members in the tree

for (fam in 1:length(treefamilies)){ # for every family in treefamilies
    treeMembers[fam,1] <- treefamilies[[fam]][1] # get the first protein in that family, put it in tree members
}

write.table(treefamilies, file=c(str(args[3]), "TreeMembers.txt"), row.names=FALSE, col.names=FALSE, quote=FALSE) #write all the treeMembers as a txt file
