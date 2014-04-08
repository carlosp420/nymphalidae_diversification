# run MEDUSA 0.93-4-33

library("MEDUSA")
library("multicore")
phy <- read.nexus("data/supp_mat_01_genus.nex");
phy <- ladderize(phy)

# we have to remove the tips
tips <- c("Achlyodes", "Graphium", "Parnassius", "Baronia", "Troides", "Papilio1", "Papilio2", "Pieris", "Aporia", "Styx", "Hamearis", "Euselasia", "Nymphidium", "Emesis", "Crocozona", "Riodina", "Amarynthis", "Baliochila", "Poritia", "Miletus", "Liphyra", "Lycaena", "Celastrina", "Thecla", "Lucia", "Curetis", "Eurema", "Colias", "Leptidea", "Pseudopontia", "Libyt")
phy <- drop.tip(phy, tip=tips)


richness <- read.csv("data/supp_mat_03_richness.csv")

res <- MEDUSA(phy, richness, stop="threshold", model="mixed", modelLimit=25, mc=TRUE)


pdf(file="output/medusa_on_mct.pdf", width=9, height=19)
summ <- medusaSummary(res, cex=0.3)
dev.off()


save(res, file="output/medusa_on_mct.txt", ascii=TRUE)

