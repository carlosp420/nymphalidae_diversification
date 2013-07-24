#install.packages("~/Downloads/phyloch_1.5-3.tar.gz", repos=NULL, type="source")
library(phyloch)
library(turboMEDUSA)

tax <- read.csv(file="../data/supp_mat_03_richness.csv")
phy <- read.beast("../data/supp_mat01_genus.nex")
nodes <- unique(phy$edge[,1])
posterior_prob <- phy$posterior
model.limit <- 25


res <- runTurboMEDUSA(phy=phy,
                      richness=tax,
                      model.limit=model.limit,
                      initial.r = 0.05,
                      initial.e = 0.5)
summarize.turboMEDUSA(res)