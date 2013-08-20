library("ape");
library("geiger");
library(RSvgDevice)

#x <- read.csv("Nymp_multiMEDUSA_1000trees_raw.csv", header=T, sep=",", quote="\"")
#x <- read.csv("Nymp_multiMEDUSA_1000trees_raw_clades.csv", header=T, sep=",", quote="\"")
#x <- read.csv("ancillary/supp_mat_11_multiMEDUSA_raw_data.csv", header=T, sep=" ", quote="\"")
x <- read.csv("data/boxplot.txt", header=T, sep=" ", quote="\"")

par(mar=c(5,4,3,2))
par(oma=c(3,3,3,3))
par(xpd=NA)
pdf(file="ancillary/fig04.pdf", width=10)
boxplot(varwidth=T, r~index, data=x, outline=T, pars=list(outcex=0.8, outcol=rgb(0,0,1,1/4)), 
        ylab="diversification rate", xlab="clade", 
        main="Boxplot of r values for each node with significant bursts as found by MEDUSA\nonly clades present in mct",
        axes=F, cex.lab=1.5, cex.axis=1.5, cex.main=1.5);
axis(2, at=seq(0,0.4,0.1))
axis(1, at=1:14, labels=c("root","2","3","4","5","6","7","8","9","10","11","12","13","14"),las=3)
#boxplot(epsilon~index, data=x, outline=T, pars=list(outcex=0.8, outcol=rgb(0,0,1,1/4)), ylab="epsilon value", xlab="index", main="Boxplot of epsilon values for each node\n with significant bursts as found by MEDUSA");
dev.off()
