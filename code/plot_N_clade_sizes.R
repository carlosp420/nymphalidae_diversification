library(RSvgDevice)

devSVG(file="Rplot.svg")

# plot Number sizes of times a split has been found across 1000 trees
x <- read.csv("Nymp_multiMEDUSA_1000trees_summary2.csv", sep=" ")

n <- x$sample.size..N.
n <- as.table(n)
names(n) <- x$index
n <- sort(n, decreasing=T)
par(mar=c(5,4,4,2) + 0.1)   

barplot(n, border=NA, ylim=c(0,1000), 
        ylab="Number of trees with diversification event",
        xlim=c(0,100), xlab="Clade or tip index", axes=T)
abline(h="950")

# indexes appearing in more than 950 trees
# background rate: 1
# tips: 224
# clades: 49 15
#sig <- which(n > 950)

legend.txt <- c("1:\troot", "224:\tCharaxes",    "49:\tTirumala, Danaus, Amauris, Parantica, Ideopsis, Euploea, Idea",                "15:\tOleriina, Ithomiina, Napeogenina, Dircennina, Godyrina")

legend("right", legend.txt, pch=19,        title="Indexes that appear in more than 950 trees:", cex=0.9)

dev.off()