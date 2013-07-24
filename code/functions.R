library(ape)
library(phytools)
library(turboMEDUSA)

source("read.nexus.R")

# get nodes with significant shifts and their descendants for our MCT
phy <- read.nexus("../data/supp_mat01_genus.nex")
load("../output/medusa_on_mct.txt")
sum <- capture.output(summarize.turboMEDUSA(res))

nodes_with_breaks <- c()
pattern <- '[0-9]{1,2}\\s+([0-9]{3})\\s.+'
for( i in 1:length(sum)) {
    if( length(grep(pattern, sum[i])) > 0) {
        node <- sub(pattern, "\\1", sum[i])
        nodes_with_breaks <- c(nodes_with_breaks, as.integer(node))
    }
}

############
# function #
############
# for a given tree, get its descendant tips for a given node
get_descendant_tips <- function(phy, node) {
    tips <- c()
    desc <- getDescendants(phy, node)
    for( j in which(desc < 399) ) {
        tips <- c(tips, desc[j])
    }
    tips
}

# for each node with splits in our MCT get their descendant tips
# and keep them in variable tips_for_split_nodes
tips_for_split_nodes <- list()
for( i in 1:length(nodes_with_breaks)) {
    node <- nodes_with_breaks[i]
    print("node")
    print(node)
    tips_for_split_nodes[[i]] <- get_descendant_tips(phy, node)
}
# add tips to a vector and then a list
phy2 <- read.nexus("../data/supp_mat_02_1000_random_trees_no_outgroups.nex", count=13)

phy2$tip.label[79]
write.nexus(phy2, file="~/Desktop/13.nex")