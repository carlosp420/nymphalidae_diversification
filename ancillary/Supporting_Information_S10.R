# run MEDUSA 0.93-4-33

library("MEDUSA")
library("multicore")
phy <- read.nexus("ancillary/supp_mat_09_mcc_tree_from_random_sample_of_1000.tree");
phy <- ladderize(phy)



richness <- read.csv("ancillary/supp_mat_03_richness.csv")

res <- MEDUSA(phy, richness, stop="threshold", model="mixed", modelLimit=25, mc=TRUE)


pdf(file="ancillary/supp_mat_12_MEDUSA_mcc_tree_from_random_sample_of_1000_trees.pdf", width=9, height=23)
summ <- medusaSummary(res, cex=0.3)
dev.off()
