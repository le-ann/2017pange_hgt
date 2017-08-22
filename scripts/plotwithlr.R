#!/usr/local/bin/R

#-------------------------------------------------------------
#DISTANCE VS PANGENOME SIZE PLOTS WITH LINEAR REGRESSION TITLE
#-------------------------------------------------------------

print("args[1] = distance, args[2] = pangenome_size, args[3] = Plot Title, args[4] = output file name")


args = commandArgs(trailingOnly=TRUE)


library(ggplot2)


dist <- read.csv(args[1], header = FALSE)
pange <- read.csv(args[2], header = FALSE)

dist_pange <- data.frame(dist$V1,pange$V1)
colnames(dist_pange) <- c("distance","pange_size")

#print(dist_pange)

fit1 <- lm(pange_size ~ distance, data=dist_pange)

summary(fit1)

#maintitle <- substitute(paste(italic("Salmonella"), "Distance and Pangenome Size (No Plasmids)"))


#--------------thanks susane----------------------------------------------------------------------#
#https://susanejohnston.wordpress.com/2012/08/09/a-quick-and-easy-function-to-plot-lm-results-in-r/
#-------------------------------------adjusted function to plot with linear regression title------# 

ggplotRegression <- function (fit) {

require(ggplot2)

ggplot(fit$model, aes_string(x = names(fit$model)[2], y = names(fit$model)[1])) + 
  geom_point(colour = "royalblue") +
  stat_smooth(method = "lm", col = "red") +
  labs(title = paste(args[3],"\n",
		     "Adj R2 = ",signif(summary(fit)$adj.r.squared, 5),
                     "Intercept =",signif(fit$coef[[1]],5 ),
                     " Slope =",signif(fit$coef[[2]], 5),
                     " P =",signif(summary(fit)$coef[2,4], 5)),
	x = "Distance (Expected Number of Nucleotide Substitutions per Site)",
	y = "Pangenome Size (Total Genes)") + 
  theme(plot.title=element_text(hjust=0, vjust = 0.12, size = 16, colour = "grey50"),
	axis.title.x = element_text(size = 12,face = "bold",colour = "grey20"),
	axis.title.y = element_text(face = "bold", colour = "grey20"))
}

#--------------------------------------------------------------------------------------------------

pdf(args[4], width = 8, height = 6)
ggplotRegression(fit1)
dev.off()
