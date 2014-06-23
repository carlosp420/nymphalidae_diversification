library("MEDUSA")
library("multicore")

mct <- read.nexus("ancillary/supp_mat_09_mcc_tree_from_random_sample_of_1000.tree")
phy <- read.nexus("ancillary/supp_mat_05_1000_random_trees_no_outgroups.nex")

richness <- read.csv("ancillary/supp_mat_03_richness.csv")

res <- MEDUSA(phy, richness, stop="threshold", model="mixed", modelLimit=27, mc=TRUE)


pdf(file="ancillary/supp_mat_08_multimedusa_result01.pdf", width=9, height=22)
summ <- multiMedusaSummary(res, conTree=mct, cex=0.3)
dev.off()

source("code/alt_plotMultimedusa.R")
pdf(file="ancillary/supp_mat_14_multimedusa_result_rates_nodes.pdf", width=9, height=22)
plotMultiMedusa_alt(summ)
dev.off()

save(res, file="ancillary/supp_mat_07_multimedusa_on_1000_trees.txt", ascii=TRUE)


# plot the summary statistics usig a boxplot Fig. 02
# save as supp. mat. 15
library("ggplot2")
load("ancillary/supp_mat_07_multimedusa_on_1000_trees.txt")
summ <- multiMedusaSummary(res, conTree=mct, cex=0.3)
data <- summ$shift.summary
data <- as.data.frame(data)

names <- c("Charaxes", "Ypthima", "Ithomiini", "Callicore + Diaethria", 
           "Danaini", "Limenitidinae + Heliconiinae", "Caeruleuptychia + Magneuptychia", 
           "Pedaliodes", "Taenaris", "Dryas + Dryadula", "Coenonympha", 
           "Anaeomorpha + Hypna", "Mycalesina", "Pseudergolinae", 
           "Phyciodina", "Satyrina", "Coenonymphina", 
           "Satyrini")

# delete rows that are not too important
data <- data[c(1:33), 1:7]
data <- data[-32,]
data <- data[-31,]
data <- data[-30,]
data <- data[-29,]
data <- data[-28,]
data <- data[-25,]
data <- data[-24,]
data <- data[-22,]
data <- data[-21,]
data <- data[-17,]
data <- data[-16,]
data <- data[-15,]
data <- data[-14,]
data <- data[-13,]
data <- data[-11,]

lower_wisker <- data$min.shift
first_quartile <- qnorm(0.196, mean=data$mean.shift, sd=data$sd.shift)
median <- data$median.shift
third_quartile <- qnorm(0.804, mean=data$mean.shift, sd=data$sd.shift)
upper_wisker <- data$max.shift

sum_stats <- list(stats=matrix(c(lower_wisker, first_quartile, median, third_quartile, upper_wisker),
                               byrow=TRUE, nrow=5, ncol=18), n = 1:18)

par(mar = c(10, 4, 3, 2)  + 3)
mp <- bxp(sum_stats,  
    outline=T, pars=list(outcex=0.8, outcol=rgb(0,0,1,1/4)), 
    ylab="net diversification rate", xlab="", 
    main="Boxplot of diversification values for each node with significant bursts \n as found by MEDUSA, only clades/tips present in MCC tree",
    axes=F, cex.lab=1, cex.axis=1.5, cex.main=1.1)

end_point = 0.5 + 18 - 1
axis(2, at=seq(-0.1,0.5,0.1), las=1)
axis(1, at=mp, labels=FALSE, tick=TRUE)
text(mp, -0.16, srt=60, adj=1, xpd=TRUE, labels=names, cex=0.8)


# plot figure 3
library(RSvgDevice)
devSVG(file="ancillary/fig03.svg", width=10)

n <- as.numeric(data$sum.prop)
par(mar=c(6,6,4,4) + 0.1)   

ypos <- c(0.02)
b <- barplot(n, border=NA, ylim=c(0,1), width=4,
             main="Probability of finding nodes as diversification events by MultiMEDUSA\nin a random sample of the posterior distribution of trees",
             cex.main=1.6,
             ylab="Probability of node as diversification event", axisname=FALSE,
             xlim=c(0,85), xlab="Nodes of MCC phylogenetic tree", axes=F, cex.lab=1.6, mgp=c(4,1,1))
axis(2, cex.axis=1.6, las=1)
b <- seq(3,88,4.8)
text(b, ypos, names,
     srt=90, cex=1.4, family="Verdana", font=2, adj=0)
abline(h="0.90")
dev.off()



# find how many times a node is present in the 1000 trees
library("phytools")

# for a given tree, get its descendant tip names for a given node
mct <- read.nexus("ancillary/supp_mat_09_mcc_tree_from_random_sample_of_1000.tree")
phy <- read.nexus("ancillary/supp_mat_05_1000_random_trees_no_outgroups.nex")

get_descendant_tips <- function(phy, node) {
  tips <- c()
  desc <- getDescendants(phy, node)
  for( j in which(desc < 399) ) {
    tips <- c(tips, desc[j])
  }
  names <- c()
  for( i in tips ) {
    names <- c(names, phy$tip.label[i])
  }
  sort(names)
}

oldest.mrca<-function(tree,tips){
  H<-nodeHeights(tree)
  X<-mrca(tree)
  n<-length(tips)
  nodes<-height<-vector(); k<-1
  for(i in 1:(n-1)) for(j in (i+1):n){
    nodes[k]<-X[tips[i],tips[j]]
    height[k]<-H[match(nodes[k],tree$edge[,1]),1]
    k<-k+1
  }
  z<-match(min(height),height)
  return(nodes[z])
}


# node 458 ->  0.0 in all 1000 trees
# node 625

expected_tips <- get_descendant_tips(mct, 625)
results <- c()
for (i in 1:length(phy)) {
  this.mrca <- oldest.mrca(phy[[i]], expected_tips)
  tips <- get_descendant_tips(phy[[i]], this.mrca)
  
  # if the descendants are the same, the lenght of the difference between lists should be 0
  results <- c(results, setequal(sort(expected_tips), sort(tips)))
}
