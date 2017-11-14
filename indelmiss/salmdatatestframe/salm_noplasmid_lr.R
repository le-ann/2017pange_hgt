#!/usr/local/bin/R

#----------------------------------------
#SALMONELLA LINEAR REGRESSION (no plasmid)
#----------------------------------------

dist <- read.csv("salm_noplasmid_dist.txt", header = FALSE)
pange <- read.csv("salm_noplasmid_pange.txt", header = FALSE)

dist_pange <- data.frame(dist$V1,pange$V1)
colnames(dist_pange) <- c("distance", "pange_size")

title <- expression(paste(italic("Salmonella"), "Distance and Pangenome Size (No Plasmids)")

ggplot(data=dist_pange, aes(x=dist_pange$distance,y=dist_pange$pange_size)) + geom_point(colour="royalblue")+ ggtitle(title) + labs(x="Distance (Expected Number of Nucleotide Substitutions per Site",y="Pangenome Size") + geom_smooth(method='lm', se=FALSE, colour="red", size=0.8) + theme(plot.title = element_text(hjust = 0, vjust = 0.12, size = 16, colour = "grey50"),axis.title.x=element_text(size=12,face="bold",colour="grey20"), axis.title.y=element_text(face="bold", colour="grey20"))

set.seed(519)
lr1 <- lim(pange_size ~ distance, data = dist_pange)
plot(dist_pange$pange_size ~ dist_pange$distance, data=dist_pange, xlab = "Distance", ylab="Pangenome Size", main = "Salmonella (Without Plasmids) Distance and Pangenome Size"
)
abline(lr1, col="red")

#Residuals:
#    Min      1Q  Median      3Q     Max 
#-890.36 -247.15  -16.13  232.67  733.39 
#
#Coefficients:
#            Estimate Std. Error t value Pr(>|t|)    
#(Intercept)   6690.0      192.3  34.789  < 2e-16 ***
#distance       707.3      147.1   4.808 5.51e-06 ***
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
#Residual standard error: 323.1 on 98 degrees of freedom
#Multiple R-squared:  0.1909,    Adjusted R-squared:  0.1826 
#F-statistic: 23.12 on 1 and 98 DF,  p-value: 5.507e-06


