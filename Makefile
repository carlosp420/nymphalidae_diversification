TREEANNOTATOR = /home/carlosp420/Desktop/phylo_software/BEASTv1.7.5/bin/treeannotator

####################################################################
# Create a set of 1000 trees that have each of the trees
# replaced with the MCT
tree_sets: output/set_1000.nex output/set_1000.nex_mct.nex
	
output/set_1000.nex: code/create_sets_of_1000_trees.R data/supp_mat01_genus.nex data/supp_mat_02_1000_random_trees_no_outgroups.nex
	R --save < code/create_sets_of_1000_trees.R
	# correct start of tree so that it can be read by BEAST
	sed -i 's/TREE\s\*\s*[tree]*\s*/tree /g' output/set_*nex

# use Treeannotator to get MCT for each set of 1000 trees
output/set_1000.nex_mct.nex: output/set_1000.nex
	ls output/set_*.nex | parallel $(TREEANNOTATOR) -burnin 0 -heights mean {} {}_mct.nex; done
	



####################################################################
# Run MEDUSA on our MCT tree
#
medusa_run: output/medusa_on_mct.txt output/medusa_on_mct.pdf

output/medusa_on_mct.txt output/medusa_on_mct.pdf: code/run_medusa_on_mct.R data/supp_mat01_genus.nex data/supp_mat_03_richness.csv
	Rscript code/run_medusa_on_mct.R data/supp_mat01_genus.nex output/medusa_on_mct.txt output/medusa_on_mct.pdf



####################################################################
# Run multiMEDUSA on our data
#
multiMEDUSA_run: output/raw_data.csv output/raw_data_summary.csv

output/raw_data.csv output/raw_data_summary.csv: data/supp_mat_02_1000_random_trees_no_outgroups.nex data/supp_mat01_genus.nex code/supp_mat_06_multiMEDUSA.R
	Rscript code/supp_mat_06_multiMEDUSA.R data/supp_mat_02_1000_random_trees_no_outgroups.nex data/supp_mat01_genus.nex output/raw_data_summary.csv output/raw_data.csv



####################################################################
# run MEDUSA on each of the 1000 MCTs and save some statistics
# * % high posterior probabilities
# breaks in mct
#
# number of breaks found in more than 95% of the trees
1000_medusa_runs: output/set_9.nex_mct.nex_medusa.txt output/set_9.nex_mct.nex_medusa.pdf
output/set_9.nex_mct.nex_medusa.txt output/set_9.nex_mct.nex_medusa.pdf: code/run_medusa_on_mct.R output/set_9.nex_mct.nex data/supp_mat_03_richness.csv
	for f in output/*_mct.nex; do Rscript code/run_medusa_on_mct.R $$f "$$f""_medusa.txt" "$$f""_medusa.pdf"; done
	cat output/percentage_nodes_high_post_prob.csv | sed 's/output\/set_//g' | sed 's/\.nex_mct\.nex//g' | sort -n > tmp
	mv tmp output/percentage_nodes_high_post_prob.csv



####################################################################
# run multiMEDUSA on each of the 1000 set of trees and save
#
# raw_output raw_output_summary to folder output/
# also save a file with the number of consistently recovered nodes
# meaning those split nodes that were found in more than 950 trees
# of the set of 1000
1000_multiMEDUSA_runs: output/set_9.nex_raw_data.csv output/set_9.nex_raw_data_summary.csv output/multimedusa_output.csv

output/set_9.nex_raw_data.csv output/set_9.nex_raw_data_summary.csv output/multimedusa_output.csv: output/set_9.nex output/set_9.nex_mct.nex code/supp_mat_06_multiMEDUSA.R 
	ls output/set*nex | grep -v mct | while read MYFILE; do Rscript code/supp_mat_06_multiMEDUSA.R "$${MYFILE}" "$${MYFILE}""_mct.nex" "$${MYFILE}""_raw_data_summary.csv" "$${MYFILE}""_raw_data.csv"; done




####################################################################
# plot MEDUSA and multiMEDUSA tests 
#
#
plot_medusa_tests: code/plot_medusa_tests.R output/multimedusa_output.csv output/percentage_nodes_high_post_prob.csv figures/plot_medusa_multimedusa_tests.png figures/plot_medusa_multimedusa_tests_2.png
	sed -i -r 's/output\/set_([0-9]{1,4})\.nex/\1/g' output/multimedusa_output.csv
	cat output/multimedusa_output.csv | sort -n > tmp
	mv tmp output/multimedusa_output.csv

figures/plot_medusa_multimedusa_tests_2.png figures/plot_medusa_multimedusa_tests.png: code/plot_medusa_tests.R
	R --no-save < code/plot_medusa_tests.R
