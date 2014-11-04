library(ape)
phy <- read.nexus("ancillary/Supporting_Information_S01.nex");
phy <- ladderize(phy)

# we have to remove the tips
tips <- c("Achlyodes", "Graphium", "Parnassius", "Baronia", "Troides", "Papilio1", "Papilio2", "Pieris", "Aporia", "Styx", "Hamearis", "Euselasia", "Nymphidium", "Emesis", "Crocozona", "Riodina", "Amarynthis", "Baliochila", "Poritia", "Miletus", "Liphyra", "Lycaena", "Celastrina", "Thecla", "Lucia", "Curetis", "Eurema", "Colias", "Leptidea", "Pseudopontia", "Libyt")
phy <- drop.tip(phy, tip=tips)

is.ultrametric(phy)
is.binary.tree(phy)
# Now to check min branch length:
min(phy$edge.length)

write.tree(phy, file="bamm/mcc.tre")
