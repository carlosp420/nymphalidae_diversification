#install.packages("phyloch_1.5-3.tar.gz", repos=NULL, type="source")
install.packages("turboMEDUSA_0.1.tar.gz", repos=NULL, type="source")
library(phyloch)
library(turboMEDUSA)

# load a modified version of the summarize function to 
# be able to save plotted tree to user file
source("summarize.turboMEDUSA.R")

tax <- read.csv(file="../data/supp_mat_03_richness.csv")
phy <- read.beast("../data/supp_mat01_genus.nex")
nodes <- unique(phy$edge[,1])
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

pdf(file="../output/medusa_on_mct.pdf", width=9, height=19)
summarize.turboMEDUSA(res, cex=0.3)
dev.off()

# get posterior probabilities for nodes that are diversification shifts
sum <- capture.output(summarize.turboMEDUSA(res, cex=0.3))

nodes_with_breaks <- c()
pattern <- '[0-9]{1,2}\\s+([0-9]{3})\\s.+';
for( i in 1:length(sum)) {
    if( length(grep(pattern, sum[i])) > 0) {
        print(sum[i])
        node <- sub(pattern, "\\1", sum[i])
        nodes_with_breaks <- c(nodes_with_breaks, as.integer(node))
    }
}