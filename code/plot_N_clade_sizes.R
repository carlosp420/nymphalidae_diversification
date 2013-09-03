library(RSvgDevice)

devSVG(file="ancillary/fig03.svg", width=10)

# plot Number sizes of times a split has been found across 1000 trees
x <- read.csv("ancillary/supp_mat_12_multiMEDUSA_summary.csv", sep=" ")

n <- x$sample.size..N./1000
n <- as.table(n)
names(n) <- x$index
n <- sort(n, decreasing=T)
par(mar=c(6,6,4,2) + 0.1)   

ypos <- c(0.02,0.02,0.02,0.02)
b <- barplot(n, border=NA, ylim=c(0,1), width=4,
        main="Nodes estimated as diversification events in more than 95%\n of the posterior distribution of trees",
        cex.main=1.8,
        ylab="Proportion of trees with diversification event", axisname=FALSE,
        xlim=c(0,200), xlab="Nodes of MCC phylogenetic tree", axes=F, cex.lab=1.5, mgp=c(4,1,1))
axis(2, cex.axis=1.5, las=1)
b <- b[1:4,1] + 1.5;
b[2] <- b[2] + 0.2
b[3] <- b[3] + 0.2
b[4] <- b[4] + 0.2
text(b, ypos, c("root", "224: Charaxes", "49: Tirumala, Danaus, Amauris, Parantica, Ideopsis, Euploea, Idea", "15: Oleriina, Ithomiina, Napeogenina, Dircennina, Godyridina"),
     srt=90, cex=1.5, family="Verdana", font=2, adj=0)
abline(h="0.950")

# indexes appearing in more than 950 trees
# background rate: 1
# tips: 224
# clades: 49 15
#sig <- which(n > 950)

#legend.txt <- c("224:\tCharaxes","49:\tTirumala, Danaus, Amauris, Parantica, Ideopsis, Euploea, Idea","15:\tOleriina, Ithomiina, Napeogenina, Dircennina, Godyridina")

#legend("right", legend.txt, pch=19,        
 #      title="Diversification events estimated in more 95% of trees:", cex=1.5)

dev.off()

