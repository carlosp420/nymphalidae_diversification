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