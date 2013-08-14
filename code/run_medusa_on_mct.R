#install.packages("phyloch_1.5-3.tar.gz", repos=NULL, type="source")
#install.packages("turboMEDUSA_0.1.tar.gz", repos=NULL, type="source")
library(phyloch)
library(turboMEDUSA)

# load a modified version of the summarize function to 
# be able to save plotted tree to user file
source("code/summarize.turboMEDUSA.R")

# This script should be invocked from the command line
# The input tree file should be used as 1st argument
# for example:
#    Rscript run_medusa_on_mct.R my_mct.nex
args <- commandArgs(trailingOnly = TRUE)

tax <- read.csv(file="data/supp_mat_03_richness.csv")

# our tree is the original nexus file with outgroups
# with posterior prob values for the nodes
phy <- read.beast(as.character(args[1]))
# we have to remove the tips
tips <- c("Achlyodes", "Graphium", "Parnassius", "Baronia", "Troides", "Papilio1", "Papilio2", "Pieris", "Aporia", "Styx", "Hamearis", "Euselasia", "Nymphidium", "Emesis", "Crocozona", "Riodina", "Amarynthis", "Baliochila", "Poritia", "Miletus", "Liphyra", "Lycaena", "Celastrina", "Thecla", "Lucia", "Curetis", "Eurema", "Colias", "Leptidea", "Pseudopontia", "Libyt")
phy <- drop.tip2(phy, tips)

phy <- ladderize(phy)
posterior_prob <- phy$posterior

model.limit <- 25

# run MEDUSA on the maximum credibility tree
res <- runTurboMEDUSA(phy=phy,
                      richness=tax,
                      model.limit=model.limit,
                      mc = TRUE,
                      num.cores = 4,
                      initial.r = 0.05,
                      initial.e = 0.5)

# save MEDUSA results as R object
# output file should be 2nd argument
# for example:
#    Rscript run_medusa_on_mct.R output/my_mct.nex output/my_mct_out.txt
save(res, file=as.character(args[2]), ascii=TRUE)

#load("output/medusa_on_mct.txt")
# save tree as PDF 
# output file should be 3nd argument
# for example:
#    Rscript run_medusa_on_mct.R output/my_mct.nex output/my_mct_out.txt output/my_mct_out.pdf
pdf(file=as.character(args[3]), width=9, height=19)
summarize.turboMEDUSA(res, cex=0.3)
dev.off()

# calculate percentage of nodes with posterior probability
# values lower than 0.95
n_low_prob <- length(which(posterior_prob < 0.95))/length(posterior_prob)
n_high_prob <- 1 - n_low_prob

# save to file only percentage of nodes with posterior
# probability more than 0.95
file_conn <- file("output/percentage_nodes_high_post_prob.csv", open="at");
writeLines(c(paste(args[1],n_high_prob, sep=",")), file_conn)
close(file_conn);



