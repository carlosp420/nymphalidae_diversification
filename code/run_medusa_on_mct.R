install.packages("phyloch_1.5-3.tar.gz", repos=NULL, type="source")
install.packages("turboMEDUSA_0.1.tar.gz", repos=NULL, type="source")
library(phyloch)
library(turboMEDUSA)

# load a modified version of the summarize function to 
# be able to save plotted tree to user file
source("summarize.turboMEDUSA.R")

tax <- read.csv(file="../data/supp_mat_03_richness.csv")
phy <- read.beast("../data/supp_mat01_genus.nex")
phy <- ladderize(phy)
posterior_prob <- phy$posterior

model.limit <- 25

# run MEDUSA on the maximum credibility tree
res <- runTurboMEDUSA(phy=phy,
                      richness=tax,
                      model.limit=model.limit,
                      initial.r = 0.05,
                      initial.e = 0.5)

# save MEDUSA results as R object
save(res, file="../output/medusa_on_mct.txt", ascii=TRUE)

load("../output/medusa_on_mct.txt")
pdf(file="../output/medusa_on_mct.pdf", width=9, height=19)
summarize.turboMEDUSA(res, cex=0.3)
dev.off()

# calculate percentage of nodes with posterior probability
# values lower than 0.95
n_low_prob <- length(which(posterior_prob < 0.95))/length(posterior_prob)
n_high_prob <- 1 - n_low_prob


