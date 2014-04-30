library("MEDUSA")
library("multicore")

mct <- read.nexus("ancillary/supp_mat_06_mcc_tree_from_random_sample_of_1000.tree")
phy <- read.nexus("ancillary/supp_mat_05_1000_random_trees_no_outgroups.nex")

richness <- read.csv("ancillary/supp_mat_03_richness.csv")

res <- MEDUSA(phy, richness, stop="threshold", model="mixed", modelLimit=27, mc=TRUE)


pdf(file="output/medusa_on_mct.pdf", width=9, height=19)
summ <- multiMedusaSummary(res, conTree=mct, cex=0.3)
dev.off()


save(res, file="ancillary/supp_mat_07_multimedusa_on_1000_trees.txt", ascii=TRUE)
