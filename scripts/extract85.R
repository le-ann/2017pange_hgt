#!/usr/local/bin/R

args = commandArgs(trailingOnly = TRUE) 

#---filter85query equivalent - removes any hits with match lengths less than 85%---#

sw_file <- read.table(args[1], sep = "\t")

sw_file$V1 <- as.character(sw_file$V1)
sw_file$V6 <- as.character(sw_file$V6) # converts the query and subject ids into stringsi


# take subset of rows that have column 8 (% hit column) greater than 85%
weeded_sw_file <- sw_file[(sw_file[,8]>=85),]

write.table(weeded_sw_file,"outputwolessthan85.txt", sep="\t", row.names = FALSE, col.names = FALSE, quote = FALSE)

#---removehitstosamegene.pl equivalent - removes any hits to itself i.e. query and subject are the same---#

norepeats_sw_file <- weeded_sw_file[(weeded_sw_file[,1]!=weeded_sw_file[,6]),]

write.table(norepeats_sw_file, "outputwohitstosamegene.txt", sep="\t", row.names = FALSE, col.names = FALSE, quote = FALSE)

