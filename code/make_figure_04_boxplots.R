library("ape");
library("geiger");
library(RSvgDevice)

#x <- read.csv("Nymp_multiMEDUSA_1000trees_raw.csv", header=T, sep=",", quote="\"")
#x <- read.csv("Nymp_multiMEDUSA_1000trees_raw_clades.csv", header=T, sep=",", quote="\"")
#x <- read.csv("ancillary/supp_mat_11_multiMEDUSA_raw_data.csv", header=T, sep=" ", quote="\"")
x <- read.csv("data/boxplot.txt", header=T, sep=" ", quote="\"")

devSVG(file="ancillary/fig04.svg", width=10)
boxplot(varwidth=T, r~index, data=x, outline=T, pars=list(outcex=0.8, outcol=rgb(0,0,1,1/4)), ylab="r value", xlab="index", main="Boxplot of r values for each node\n with significant bursts as found by MEDUSA\nonly clades present in mct");
#boxplot(epsilon~index, data=x, outline=T, pars=list(outcex=0.8, outcol=rgb(0,0,1,1/4)), ylab="epsilon value", xlab="index", main="Boxplot of epsilon values for each node\n with significant bursts as found by MEDUSA");
dev.off()
