# Script to run MEDUSA on the MCC Nymphalidae tree from Wahlberg et al., 2009
# This script removes the outgroup taxa and loads the richness data for the tree terminals.

# run MEDUSA 0.93-4-33

library("MEDUSA")
library("multicore")
phy <- read.nexus("ancillary/Supporting_Information_S01.nex");
phy <- ladderize(phy)

# we have to remove the tips
tips <- c("Achlyodes", "Graphium", "Parnassius", "Baronia", "Troides", "Papilio1", "Papilio2", "Pieris", "Aporia", "Styx", "Hamearis", "Euselasia", "Nymphidium", "Emesis", "Crocozona", "Riodina", "Amarynthis", "Baliochila", "Poritia", "Miletus", "Liphyra", "Lycaena", "Celastrina", "Thecla", "Lucia", "Curetis", "Eurema", "Colias", "Leptidea", "Pseudopontia", "Libyt")
phy <- drop.tip(phy, tip=tips)


richness <- read.csv("ancillary/Supporting_Information_S03.csv")

res <- MEDUSA(phy, richness, stop="threshold", model="mixed", modelLimit=25, mc=TRUE)


pdf(file="output/medusa_on_mct.pdf", width=9, height=19)
summ <- medusaSummary(res, cex=0.3)
dev.off()


# save(res, file="ancillary/supp_mat_04_MEDUSA_results.txt", ascii=TRUE)

