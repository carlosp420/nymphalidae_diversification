library(ape)

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
