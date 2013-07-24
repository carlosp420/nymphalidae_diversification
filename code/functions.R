library(ape)
library(phytools)
library(turboMEDUSA)


## Generate a set of 1000 trees
# each set will be the random 1000 trees minus one,
# that should be replaced by the MCT tree.
# The idea is incrementally "improve" the set of trees,
# so that the nodes with high posterior probabilities will 
# increase in number in the MCT tree of each set.

# In this way, we can test whether the failure to recover
# most of the splits of the MCT on more than 95% of the trees
# from the posterior is due to having nodes with low 
# posterior probability.
# This will be useful for answering the Asociate Editor and Reviewer 3 in part.

## TODO:
    # get mct for each set
    # test if the percentage of nodes recovered in set improves
    # test if this might also be influenced by having narrower confidence intervals
    # but how???

# read original set of 1000 trees
mct <- read.nexus("../data/supp_mat01_genus.nex")
orig_set <- read.nexus("../data/supp_mat_02_1000_random_trees_no_outgroups.nex")

for( i in 1:1000 ) {
    # drop i
    j <- i + 1
    set <- orig_set[j:1000]
    
    # append mct
    set[[1000]] <- mct
    
    # save set as set_i.nex
    write.nexus(set, file=paste0("set_", i, ".nex", sep=""))
}
    

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