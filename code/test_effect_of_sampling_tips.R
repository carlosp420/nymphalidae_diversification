# See if sampling richness data has effect on MEDUSA by using cut-off
# at tribe-subtribe level

library(ape)
library(phytools)

phy <- read.nexus("ancillary/supp_mat_01_genus.nex")
tips <- c("Achlyodes", "Graphium", "Parnassius", "Baronia", "Troides", "Papilio1", "Papilio2", "Pieris", "Aporia", "Styx", "Hamearis", "Euselasia", "Nymphidium", "Emesis", "Crocozona", "Riodina", "Amarynthis", "Baliochila", "Poritia", "Miletus", "Liphyra", "Lycaena", "Celastrina", "Thecla", "Lucia", "Curetis", "Eurema", "Colias", "Leptidea", "Pseudopontia", "Libyt");
phy  <- drop.tip(phy, tips)

# node 609, time 48.757892 Mya
node_to_collapse <- findMRCA(phy, tips=c("Agatasa", "Polygrapha"))
# node 787  time 26.193458 Mya
node_to_collapse <- findMRCA(phy, tips=c("Paralethe", "Tarsocera"))