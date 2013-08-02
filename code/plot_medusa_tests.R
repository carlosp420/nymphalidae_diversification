# This code plots for each of the set of 1000 trees:
# * the percentage of node splits with hight posterior probability (> 0.95)
# * the number of nodes consistenly recovered across the set of 1000 trees, which 
#   is the number of node splits found in more than 950 trees.
library(ggplot2)

multimedusa <- read.csv("output/multimedusa_output.csv", header=FALSE)
medusa      <- read.csv("output/percentage_nodes_high_post_prob.csv", header=FALSE)

png(filename="figures/plot_medusa_multimedusa_tests.png")
par(bty="l", cex.main=2, cex.lab=2)
par(mar=c(5,7,4,6)+0.1)

plot(multimedusa$V1, multimedusa$V2, col="red", type="l", xlab="set of 1000 trees",
      ylab="number of consistently\n recovered nodes")

par(new=TRUE)
plot(medusa$V1, medusa$V2, col="blue", type="l", xaxt="n", yaxt="n", xlab="", ylab="")
axis(4)
mtext("percentage of nodes with\n high posterior probability", side=4, line=3, cex=2)
legend("topleft", legend=c("MEDUSA","multiMEDUSA"), lty=1, pch=1, col=c("blue","red"), inset=0.2)

dev.off()


## plot percentage of good nodes versus consistently recovered nodes
par(new=TRUE)
png(filename="figures/plot_medusa_multimedusa_tests_2.png")
data <- as.data.frame(cbind(medusa$V2, multimedusa$V2))
p <- qplot(data$V1, data$V2, geom="point",  main="Effect of percentage of
            nodes with high posterior probability on multiMEDUSA results",
            xlab="percentage of nodes with post. prob. > 0.95",
            ylab="number of nodes consistenly recovered from the
            multiMEDUSA analyses")
p + geom_smooth(method="lm", se=FALSE, aes(data$V1)) + theme_bw()
dev.off()
