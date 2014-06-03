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


# plot the summary statistics usig a boxplot
# save as supp. mat. 15
library("ggplot2")
names <- c("Charaxes", "Ypthima", "Ithomiini", "Callicore + Diaethria", "Danaini", "Limenitidinae + Heliconiinae", "Caeruleuptychia + Magneuptychia", "Pedaliodes", "Taenaris", "Dryas + Dryadula", "551", "Coenonympha", "702", "740", "498", "616", "507", "Anaeomorpha + Hypna", "Mycalesina", "Pseudergolinae", "460", "545", "Phyciodina", "744", "535", "Satyrina", "Coenonymphina", "628", "629", "630", "627", "659", "Satyrini", "420", "651", "483", "443", "467", "478", "412", "457", "538", "639", "479", "458")

data <- as.data.frame(data)
x <- 1:45*2 - 1
limits <- aes(ymax=max.shift, ymin=min.shift)
p <- ggplot(data, aes(x=x, y=median.shift))
p + geom_errorbar(aes(ymax=max.shift, ymin=min.shift), position=dodge, width=2) +
  geom_point(aes(x=x, y=mean.shift),size=3,shape=21) +
  scale_x_continuous(breaks=x, labels=names) +
  ggtitle("Divesification rates estimated for nodes from a MultiMEDUSA analysis on 1000 trees") +
  xlab("Node number") + ylab("Diversification rate") +
  theme(axis.text.x = element_text(angle=45, hjust=1, size=10))


