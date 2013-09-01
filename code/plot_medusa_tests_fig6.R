# This code plots for each of the set of 1000 trees:
# * the percentage of node splits with hight posterior probability (> 0.95)
# * the number of nodes consistenly recovered across the set of 1000 trees, which 
#   is the number of node splits found in more than 950 trees.
library(ggplot2)

## plot width of confidence intervals for estimated ages versus consistently recovered nodes
multimedusa <- read.csv(
        "ancillary/supp_mat_16-multimedusa_output_nodes_confidence_intervals.csv", 
        header=FALSE)
par(new=TRUE)
svg(filename="ancillary/fig06.svg")
p <- qplot(multimedusa$V1, multimedusa$V2, geom="line",  size=I(1),
            main="Effect of confidence interval width of estimated ages
            on multiMEDUSA results",
            xlab="sets of trees with decreasing width of confidence intervals",
            ylab="number of nodes consistenly recovered from the
            multiMEDUSA analyses")
p + scale_y_continuous(breaks=c(5, 7.5, 10, 12.5, 15), 
                       labels=c("5", "7.5", "10", "12.5", "15")) + theme_bw()
dev.off()
