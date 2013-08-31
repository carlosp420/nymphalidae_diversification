#install.packages("auteur_0.12.1010.tar.gz", repos=NULL, type="source")
library(turboMEDUSA)
library(ape)
library(auteur)
library(phytools)
library(reshape)

rm(list=ls())




tax <- read.csv(file="data/supp_mat_03_richness.csv"); # two column dataframe of genera (match tip.lables) and species richness
mct <- read.nexus("ancillary/supp_mat_01_genus.nex"); # mct is the maximum credibility tree
tips <- c("Achlyodes", "Graphium", "Parnassius", "Baronia", "Troides", "Papilio1", "Papilio2", "Pieris", "Aporia", "Styx", "Hamearis", "Euselasia", "Nymphidium", "Emesis", "Crocozona", "Riodina", "Amarynthis", "Baliochila", "Poritia", "Miletus", "Liphyra", "Lycaena", "Celastrina", "Thecla", "Lucia", "Curetis", "Eurema", "Colias", "Leptidea", "Pseudopontia", "Libyt");
mct  <- drop.tip(mct, tips)


# get list of all clades in mct

mct.clades.names <- list()
mct.clades.nums <- prop.part(mct)
for (i in 1:length(mct.clades.nums)) {
  mct.clades.names[[i]] <- mct$tip.label[unlist(mct.clades.nums[i])]
}

indexes_from_boxplot <- read.csv("data/boxplot.txt", sep=" ")
new_indexes <- data.frame(1:10562)
new_indexes[1] <- indexes_from_boxplot[,2]
new_indexes[2] <- indexes_from_boxplot[,6]
names(new_indexes)  <- c("index","tip")
new_indexes <- unique(new_indexes)

new_indexes[3] <- c(1:length(new_indexes[1]))

for ( i in 1:length(new_indexes[,1])) {
    
    if( new_indexes[i,2] == "y") {
        index <- new_indexes[i,1]
        new_indexes[i,3] <- paste(mct$tip[index], sep=" ", collapse=" ")
    }
    else {
        index <- new_indexes[i,1]
        new_indexes[i,3] <- paste(mct.clades.names[[index]], sep=" ", collapse=" ")
    }
}
names(new_indexes)[3] <- "taxa"


write.csv(new_indexes,
          "ancillary/supp_mat_13_list_of_clades_and_tips_MultiMEDUSA.csv",
          row.names = FALSE,
          eol="\n",
          quote=FALSE
)


cat("\n
##############################################
## Use the index number to identify the taxa in each clade.
##
## If the clade is a tip (i.e., tip = y),
## type:  mct$tip['insert index value here']
##
## If the clade is not a tip (i.e., tip = n),
## type:  mct.clades.names[['insert index value here']]
##
## In both cases, a string of taxon names will be returned.
##############################################\n
    ")



