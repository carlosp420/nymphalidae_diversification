x <- read.csv("~/Desktop/benchmark2.txt");

png(filename="cluster_benchmark.png")
boxplot(x, xlab="number of processors", ylab="time in seconds", 
        main="Running MrBayes in cluster, 10 chains on primates.nex, \n 20 000 generations", xaxt="n");
axis(1, labels=c(2,5,10), at=c(1,2,3))
dev.off()
