# Create a set of 1000 trees that have each of the trees
# replaced with the MCT
tree_sets: output/set_1000.nex
	
output/set_1000.nex: code/create_sets_of_1000_trees.R data/supp_mat01_genus.nex data/supp_mat_02_1000_random_trees_no_outgroups.nex
	R --save < code/create_sets_of_1000_trees.R
	# correct start of tree so that it can be read by BEAST
	sed -i 's/TREE\s\*\s*[tree]*\s*/tree /g' output/set*nex
	
