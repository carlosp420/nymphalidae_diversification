# 
# make manuscript in PDF
#
proof: MS_proof.pdf

MS_proof.pdf: header.latex MS.md refs.bib jeb.csl 
	pandoc --latex-engine=xelatex -s -S --template proof_header.latex -f markdown -V geometry:a4paper -V geometry:margin=1in  MS.md --bibliography=refs.bib  --csl=jeb.csl -o MS_proof.pdf

pdf: MS.pdf

MS.pdf: header.latex MS.md refs.bib jeb.csl ancillary/fig01.pdf 
	pandoc --latex-engine=xelatex -s -S --template header.latex -f markdown -V geometry:a4paper -V geometry:margin=1in  MS.md --bibliography=refs.bib  --csl=jeb.csl -o MS.pdf
	#convert ancillary/fig01.png ancillary/fig01.pdf
	#inkscape ancillary/fig04.svg -A ancillary/fig04.pdf
	pdftk MS.pdf ancillary/fig01.pdf cat output tmp.pdf
	mv tmp.pdf MS.pdf
	
# Make LATEX file for submittion
latex: MS.tex

MS.tex: header.latex MS.md refs.bib jeb.csl 
	pandoc --latex-engine=xelatex -s -S --template header.latex -f markdown -V geometry:a4paper -V geometry:margin=1in  MS.md --bibliography=refs.bib  --csl=jeb.csl  -o MS.tex

# Make ODT file for word count including references
docx: MS.docx

MS.docx: header.latex MS.md refs.bib mystyle.csl 
	pandoc --latex-engine=xelatex -s -S --template header.latex -f markdown -V geometry:a4paper -V geometry:margin=1in  MS.md --bibliography=refs.bib  --csl=jeb.csl -t docx -o MS.docx




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
medusa_run: output/medusa_on_mct.pdf

output/medusa_on_mct.pdf: code/run_medusa_093-4-33on_mct.R data/supp_mat_01_genus.nex data/supp_mat_03_richness.csv
	Rscript code/run_medusa_093-4-33on_mct.R



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


#
# make figures including ancillary material
#
figures: ancillary/fig02.svg ancillary/fig03.svg ancillary/fig04.svg fig05 fig06 fig07 ancillary/figS01.pdf ancillary/figS04.svg figS05 figS06 ancillary/supp_mat_13_list_of_clades_and_tips_MultiMEDUSA.csv data/clade_288.csv

ancillary/figS01.pdf: code/test_effect_of_sampling_tips.R data/strict_cutoff_24.csv ancillary/supp_mat_03_richness.csv ancillary/supp_mat_01_genus.nex code/summarize.turboMEDUSA.R
	R --no-save < code/test_effect_of_sampling_tips.R

ancillary/figS02.pdf: code/test_effect_of_sampling_tips.R data/strict_cutoff_24.csv ancillary/supp_mat_03_richness.csv ancillary/supp_mat_01_genus.nex code/summarize.turboMEDUSA.R
	R --no-save < code/test_effect_of_sampling_tips.R

fig02: ancillary/fig02.svg

ancillary/fig02.svg: code/summarize.turboMEDUSA.R code/make_figure_02_medusa.R ancillary/supp_mat_10_MEDUSA_Nymphalidae_raw_data.csv
	Rscript code/make_figure_02_medusa.R ancillary/fig02.svg

fig03: ancillary/fig03.svg 

ancillary/fig03.svg: code/plot_N_clade_sizes.R ancillary/supp_mat_12_multiMEDUSA_summary.csv
	R --no-save < code/plot_N_clade_sizes.R

ancillary/fig04.svg: data/boxplot.txt code/make_figure_04_boxplots.R
	R --no-save < code/make_figure_04_boxplots.R
data/boxplot.txt: ancillary/supp_mat_11_multiMEDUSA_raw_data.csv
	cat ancillary/supp_mat_11_multiMEDUSA_raw_data.csv | head -n 1 > data/boxplot.txt
	cat ancillary/supp_mat_11_multiMEDUSA_raw_data.csv | grep -v 'y' | egrep  '^[0-9]+\s1 ' >> data/boxplot.txt
	cat ancillary/supp_mat_11_multiMEDUSA_raw_data.csv | grep -v 'y' | egrep  '^[0-9]+\s15 ' >> data/boxplot.txt
	cat ancillary/supp_mat_11_multiMEDUSA_raw_data.csv | grep -v 'y' | egrep  '^[0-9]+\s49 ' >> data/boxplot.txt
	cat ancillary/supp_mat_11_multiMEDUSA_raw_data.csv | grep -v 'y' | egrep  '^[0-9]+\s57 ' >> data/boxplot.txt
	cat ancillary/supp_mat_11_multiMEDUSA_raw_data.csv | grep -v 'y' | egrep  '^[0-9]+\s155 ' >> data/boxplot.txt
	cat ancillary/supp_mat_11_multiMEDUSA_raw_data.csv | grep -v 'y' | egrep  '^[0-9]+\s195 ' >> data/boxplot.txt
	cat ancillary/supp_mat_11_multiMEDUSA_raw_data.csv | grep -v 'y' | egrep  '^[0-9]+\s256 ' >> data/boxplot.txt
	cat ancillary/supp_mat_11_multiMEDUSA_raw_data.csv | grep -v 'y' | egrep  '^[0-9]+\s269 ' >> data/boxplot.txt
	cat ancillary/supp_mat_11_multiMEDUSA_raw_data.csv | grep -v 'y' | egrep  '^[0-9]+\s288 ' >> data/boxplot.txt
	cat ancillary/supp_mat_11_multiMEDUSA_raw_data.csv | grep -v 'y' | egrep  '^[0-9]+\s318 ' >> data/boxplot.txt
	cat ancillary/supp_mat_11_multiMEDUSA_raw_data.csv | grep -v 'n' | egrep  '^[0-9]+\s224 ' >> data/boxplot.txt
	cat ancillary/supp_mat_11_multiMEDUSA_raw_data.csv | grep -v 'n' | egrep  '^[0-9]+\s299 ' >> data/boxplot.txt
	cat ancillary/supp_mat_11_multiMEDUSA_raw_data.csv | grep -v 'n' | egrep  '^[0-9]+\s355 ' >> data/boxplot.txt
	cat ancillary/supp_mat_11_multiMEDUSA_raw_data.csv | grep -v 'n' | egrep  '^[0-9]+\s377 ' >> data/boxplot.txt

fig05: ancillary/fig05.svg


ancillary/fig05.svg: code/plot_medusa_tests.R ancillary/supp_mat_14-consistently_recovered_splits_multimedusa_variable_topology.csv ancillary/supp_mat_15-percentage_nodes_high_post_prob.csv
	R --no-save < code/plot_medusa_tests.R

ancillary/supp_mat_15-percentage_nodes_high_post_prob.csv: 
	rm ancillary/supp_mat_15-percentage_nodes_high_post_prob.csv
	R --no-save < code/get_percentage_of_nodes_with_high_post_prob.R
	touch ancillary/supp_mat_15-percentage_nodes_high_post_prob.csv



fig06: ancillary/fig06.svg

ancillary/fig06.svg: code/plot_medusa_tests_fig6.R ancillary/supp_mat_16-multimedusa_output_nodes_confidence_intervals.csv
	R --no-save < code/plot_medusa_tests_fig6.R



fig07: ancillary/fig07.svg

ancillary/fig07.svg: ancillary/supp_mat_09_states.csv ancillary/supp_mat_01_genus.nex ancillary/supp_mat_03_richness.csv ancillary/supp_mat_17_bisse_source.R
	R --no-save < ancillary/supp_mat_17_bisse_source.R


ancillary/supp_mat_13_list_of_clades_and_tips_MultiMEDUSA.csv: code/get_list_of_indexes_and_taxa.R data/supp_mat_03_richness.csv ancillary/supp_mat_01_genus.nex
	R --no-save < code/get_list_of_indexes_and_taxa.R

data/clade_288.csv: ancillary/supp_mat_11_multiMEDUSA_raw_data.csv code/get_max_min_r_values.R
	cat ancillary/supp_mat_11_multiMEDUSA_raw_data.csv | grep -v 'y' | egrep '^[0-9]+\s288' | awk '{print $$3}' > data/clade_288.csv
	R --no-save < code/get_max_min_r_values.R
	

# ===================
# Others
#
plot_combined_bisse: figS05 figS06
	
figS05: ancillary/figS05.svg

ancillary/figS05.svg: ancillary/supp_mat_19_combined_bisse.csv code/bisse_combined.R
	R --no-save < code/bisse_combined.R

ancillary/supp_mat_19_combined_bisse.csv: data/combined_bisse.csv	
	head -n 1 data/combined_bisse.csv > tmp
	grep -v 'i' data/combined_bisse.csv >> tmp
	mv tmp ancillary/supp_mat_19_combined_bisse.csv
	

figS06: ancillary/figS06.pdf
	
ancillary/figS06.pdf: ancillary/supp_mat_19_combined_bisse.csv code/bisse_combined.R
	R --no-save < code/bisse_combined.R

