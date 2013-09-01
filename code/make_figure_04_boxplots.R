library("ape");
library("geiger");
library(RSvgDevice)

#x <- read.csv("Nymp_multiMEDUSA_1000trees_raw.csv", header=T, sep=",", quote="\"")
#x <- read.csv("Nymp_multiMEDUSA_1000trees_raw_clades.csv", header=T, sep=",", quote="\"")
#x <- read.csv("ancillary/supp_mat_11_multiMEDUSA_raw_data.csv", header=T, sep=" ", quote="\"")
x <- read.csv("data/boxplot.txt", header=T, sep=" ", quote="\"")
plot.new()
par(mar=c(5,3,3,2))
par(oma=c(8,3,3,3))

#par(xpd=FALSE)
svg(file="ancillary/fig04.svg", width=10)
#pdf(file="ancillary/fig04.pdf",width=10, height=12)
boxplot(varwidth=T, r~index, data=x, outline=T, pars=list(outcex=0.8, outcol=rgb(0,0,1,1/4)), 
        ylab="diversification rate", xlab="", 
        main="Boxplot of diversification values for each node with significant bursts \n as found by MEDUSA, only clades/tips present in MCC tree",
        axes=F, cex.lab=1.5, cex.axis=1.5, cex.main=1.5);
axis(2, at=seq(0,0.4,0.1), las=1)
axis(1, at=1:14, labels=c("root","Ithomiini","Danaini","Limenitidinae \n + Heliconiinae","Phyciodina",
 "Callicore \n + Diaethria","Charaxes","Lethina + Mycalesina",
 "Euptychiina + Pronophilina \n + Maniolina + Satyrina",
  "Caeruleuptychia \n + Magneuptychia",
 "Ypthima","Satyrina","Pedaliodes","Taenaris"),las=3)
text(7.5,0,"clade/tip", cex=1.5)

dev.off()
