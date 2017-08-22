#!/usr/local/bin/R

library(ggplot2)
args = commandArgs(trailingOnly=TRUE)

raredata <- read.csv(args[1]) 
head(raredata)

raredata$genomes <- as.numeric(raredata$genomes)

pdf(args[3], width = 8, height = 6)

ggplot(raredata, aes(x = raredata$genomes,y = raredata$pangenome_size)) +
 geom_point(colour = "purple") +
 labs(title = paste(args[2]," Rarefaction"),
	x = "Number of Genomes",
	y = "Pangenome Size") +
 theme(plot.title=element_text(hjust=0, vjust = 0.12, size = 16, colour = "grey50"),
 axis.title.x = element_text(size = 12,face = "bold",colour = "grey20"),
 axis.title.y = element_text(face = "bold", colour = "grey20"))

dev.off()
