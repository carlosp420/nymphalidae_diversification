TREEANNOTATOR = /home/carlosp420/Desktop/phylo_software/BEASTv1.7.5/bin/treeannotator

####################################################################
# Create a set of 1000 trees that have each of the trees
# replaced with the MCT
#
# Trees of variable topology
tree_sets: output/variable_topology/set_1000.nex output/variable_topology/set_1000.nex_mct.nex
	
output/variable_topology/set_1000.nex: code/create_sets_of_1000_trees.R data/supp_mat_01_genus.nex data/supp_mat_02_1000_random_trees_no_outgroups.nex
	R --save < code/create_sets_of_1000_trees.R

# use Treeannotator to get MCT for each set of 1000 trees
output/variable_topology/set_1000.nex_mct.nex: output/variable_topology/set_1000.nex
	# correct start of tree so that it can be read by BEAST
	ls output/variable_topology/set_*.nex | parallel sed -i -e 's/TREE\\s\*\\*/tree/g' {}
	ls output/variable_topology/set_*.nex | parallel sed -i -e 's/tree\\s\*tree/tree/g' {}
	ls output/variable_topology/set_*.nex | parallel $(TREEANNOTATOR) -burnin 0 -heights mean {} {}_mct.nex; done
	

tree_sets2: output/fixed_topology/set_1000.nex output/fixed_topology/set_1000.nex_mct.nex
	
output/fixed_topology/set_1000.nex: code/create_sets_of_1000_trees_2.R data/supp_mat_1000_trees_fixed_topology_mct.nex data/supp_mat_1000_trees_fixed_topology.nex
	R --save < code/create_sets_of_1000_trees_2.R

# use Treeannotator to get MCT for each set of 1000 trees
output/fixed_topology/set_1000.nex_mct.nex: output/fixed_topology/set_1000.nex
	# correct start of tree so that it can be read by BEAST
	ls output/fixed_topology/set_*.nex | parallel sed -i -e 's/TREE\\s\*\\*/tree/g' {}
	ls output/fixed_topology/set_*.nex | parallel sed -i -e 's/tree\\s\*tree/tree/g' {}
	ls output/fixed_topology/set_*.nex | parallel $(TREEANNOTATOR) -burnin 0 -heights mean {} {}_mct.nex; done
	



####################################################################
# Run MEDUSA on our MCT tree
#
medusa_run: output/medusa_on_mct.txt output/medusa_on_mct.pdf

output/medusa_on_mct.txt output/medusa_on_mct.pdf: code/run_medusa_on_mct.R data/supp_mat_01_genus.nex data/supp_mat_03_richness.csv
	Rscript code/run_medusa_on_mct.R data/supp_mat_01_genus.nex output/medusa_on_mct.txt output/medusa_on_mct.pdf



####################################################################
# Run multiMEDUSA on our data
#
multiMEDUSA_run: output/raw_data.csv output/raw_data_summary.csv

output/raw_data.csv output/raw_data_summary.csv: data/supp_mat_02_1000_random_trees_no_outgroups.nex data/supp_mat_01_genus.nex code/supp_mat_06_multiMEDUSA.R
	Rscript code/supp_mat_06_multiMEDUSA.R data/supp_mat_02_1000_random_trees_no_outgroups.nex data/supp_mat_01_genus.nex output/raw_data_summary.csv output/raw_data.csv



####################################################################
# run MEDUSA on each of the 1000 MCTs and save some statistics
# * % high posterior probabilities
# breaks in mct
#
# number of breaks found in more than 95% of the trees
1000_medusa_runs: output/variable_topology/set_9.nex_mct.nex_medusa.txt output/variable_topology/set_9.nex_mct.nex_medusa.pdf
output/variable_topology/set_9.nex_mct.nex_medusa.txt output/variable_topology/set_9.nex_mct.nex_medusa.pdf: code/run_medusa_on_mct2.R output/variable_topology/set_9.nex_mct.nex data/supp_mat_03_richness.csv
	for f in output/variable_topology/*_mct.nex; do Rscript code/run_medusa_on_mct2.R $$f "$$f""_medusa.txt" "$$f""_medusa.pdf"; done
	cat output/variable_topology/percentage_nodes_high_post_prob.csv | sed 's/output\/variable_topology\/set_//g' | sed 's/\.nex_mct\.nex//g' | sort -n > tmp
	mv tmp output/variable_topology/percentage_nodes_high_post_prob.csv


1000_medusa_runs2: output/fixed_topology/set_9.nex_mct.nex_medusa.txt output/fixed_topology/set_9.nex_mct.nex_medusa.pdf
output/fixed_topology/set_9.nex_mct.nex_medusa.txt output/fixed_topology/set_9.nex_mct.nex_medusa.pdf: code/run_medusa_on_mct2.R output/fixed_topology/set_9.nex_mct.nex data/supp_mat_03_richness.csv
	for f in output/fixed_topology/*_mct.nex; do Rscript code/run_medusa_on_mct2.R $$f "$$f""_medusa.txt" "$$f""_medusa.pdf"; done
	cat output/fixed_topology/percentage_nodes_high_post_prob.csv | sed 's/output\/fixed_topology\/set_//g' | sed 's/\.nex_mct\.nex//g' | sort -n > tmp
	mv tmp output/fixed_topology/percentage_nodes_high_post_prob.csv

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


1000_multiMEDUSA_runs2: output/fixed_topology/set_9.nex_raw_data.csv output/fixed_topology/set_9.nex_raw_data_summary.csv output/fixed_topology/multimedusa_output.csv

output/fixed_topology/set_9.nex_raw_data.csv output/fixed_topology/set_9.nex_raw_data_summary.csv output/fixed_topology/multimedusa_output.csv: output/fixed_topology/set_9.nex output/fixed_topology/set_9.nex_mct.nex code/supp_mat_06_multiMEDUSA.R 
	ls output/fixed_topology/set*nex | grep -v mct | while read MYFILE; do Rscript code/supp_mat_06_multiMEDUSA.R "$${MYFILE}" "$${MYFILE}""_mct.nex" "$${MYFILE}""_raw_data_summary.csv" "$${MYFILE}""_raw_data.csv"; done


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


####################################################################
# create sh files to run multiMEDUSA on CSC computer cluster
# need to copy temporaly nex files to the output/ folder for running multiMEDUSA
sh_files: code/script_for_multimedusa_in_cluster.sh code/create_script_files.sh
	bash code/create_script_files.sh


####################################################################
# count number of splits retained for each MEDUSA analysis?
# was 25 splits enough?
# It iterates through all raw_data.csv output files on the 1000 multiMEDUSA runs
#
# For each raw_data.csv file it counts the number of max splits on each file and
# sort the results trying to find the max number of splits ever. So do we reach
# 25 splits? ever?
#

count_number_splits: output/variable_topology/set_9.nex_raw_data.csv
	ls output/variable_topology/ | grep data.csv | while read FILE; do cat output/variable_topology/"$${FILE}" | sort -n | awk -F ' ' '{print $$1}' | uniq -c | sort -n | tail -n 1; done > output/number_of_splits.txt
	cat output/number_of_splits.txt | sort -n | tail -n 1
	rm output/number_of_splits.txt


count_number_splits2: output/fixed_topology/set_9.nex_raw_data.csv
	ls output/fixed_topology/ | grep data.csv | while read FILE; do cat output/fixed_topology/"$${FILE}" | sort -n | awk -F ' ' '{print $$1}' | uniq -c | sort -n | tail -n 1; done > output/number_of_splits.txt
	cat output/number_of_splits.txt | sort -n | tail -n 1
	rm output/number_of_splits.txt
