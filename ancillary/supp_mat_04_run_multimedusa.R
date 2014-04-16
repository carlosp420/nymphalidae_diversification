library("MEDUSA")
library("multicore")

mct <- read.nexus("ancillary/supp_mat_02_genus.nex")
phy <- read.nexus("ancillary/supp_mat_05_1000_random_trees_no_outgroups.nex");

# we have to remove the tips
tips <- c("Achlyodes", "Graphium", "Parnassius", "Baronia", "Troides", "Papilio1", "Papilio2", "Pieris", "Aporia", "Styx", "Hamearis", "Euselasia", "Nymphidium", "Emesis", "Crocozona", "Riodina", "Amarynthis", "Baliochila", "Poritia", "Miletus", "Liphyra", "Lycaena", "Celastrina", "Thecla", "Lucia", "Curetis", "Eurema", "Colias", "Leptidea", "Pseudopontia", "Libyt")
mct <- drop.tip(mct, tip=tips)


richness <- read.csv("ancillary/supp_mat_03_richness.csv")

res <- MEDUSA(phy, richness, stop="threshold", model="mixed", modelLimit=25, mc=TRUE)


pdf(file="output/medusa_on_mct.pdf", width=9, height=19)
summ <- multiMedusaSummary(res, conTree=mct, cex=0.3)
dev.off()


save(res, file="output/multimedusa_on_1000_trees.txt", ascii=TRUE)

