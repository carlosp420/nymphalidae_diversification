# See if sampling richness data has effect on MEDUSA by using cut-off
# at tribe-subtribe level

library(ape)
library(laser)
library(phytools)
library(diversitree)

phy <- read.nexus("ancillary/supp_mat_01_genus.nex")
tips <- c("Achlyodes", "Graphium", "Parnassius", "Baronia", "Troides", "Papilio1", "Papilio2", "Pieris", "Aporia", "Styx", "Hamearis", "Euselasia", "Nymphidium", "Emesis", "Crocozona", "Riodina", "Amarynthis", "Baliochila", "Poritia", "Miletus", "Liphyra", "Lycaena", "Celastrina", "Thecla", "Lucia", "Curetis", "Eurema", "Colias", "Leptidea", "Pseudopontia", "Libyt");
phy  <- drop.tip(phy, tips)

## tips to remove so that we can have strict higher phylogeny
tips <- c("Libythea")

tips <- c(tips, "Anetia", "Ithuna", "Lycorea")

tips <- c(tips, "Idea", "Tirumala", "Ideopsis", "Parantica")
tips <- c(tips, "Scada", "Mechanitis")
tips <- c(tips, "Athesis", "Melinaea", "Paititia", "Olyras")
tips <- c(tips, "Elzunia", "Tithorea")
tips <- c(tips, "Hyposcada", "Ollantaya", "Oleria", "Ithomia", "Pagyris", "Epityches", "Napeogenes", "Hyalyris",
          "Hypothyris", "Callithomia", "Hyalenna", "Dircenna", "Pteronymia", "Episcada", "Ceratinia", "Velamysta",
          "Veladyris", "Placidina", "Godyris", "Greta", "Pseudoscada", "Heterosais", "Hypoleria", "Brevioleria")
tips <- c(tips, "Harma", "Lasippa", "Pantoporia", "Moduza", "Adelpha", "Limenitis",  "Dophla", "Lexias", "Tanaecia",
          "Euphaedra", "Euriphene", "Hamanumida", "Crenidomimas", "Euryphura")
tips <- c(tips, "Altinote", "Dryadula", "Heliconius", "Dione", "Cirrochroa", "Algiachroa", "Phalanta", "Vagrans")
tips <- c(tips, "Yramea", "Boloria", "Issoria", "Argynnis", "Brenthis")
tips <- c(tips, "Eulaceura", "Apaturopsis", "Asterocampa", "Chitoria", "Mimathyma", "Euripus", "Hestina", "Apatura")
tips <- c(tips, "Vila", "Laringa", "Archimestra", "Mestra", "Eurytela", "Byblia", "Mesoxantha", "Neptidopsis")
tips <- c(tips, "Sevenia", "Ectima", "Batesia", "Catonephele", "Nessaea", "Haematera", "Callicore", "Diaethria",
          "Epiphile", "Nica", "Temenis")
tips <- c(tips, "Chersonesia", "Historis", "Tigridia", "Polygonia", "Kaniska", "Nymphalis")
tips <- c(tips, "Catacroptera", "Mallika", "Napeocles", "Anartia", "Precis", "Salamis", "Yoma")
tips <- c(tips, "Microtia", "Chlosyne", "Higginsius", "Phystis", "Ortilia", "Mazia", "Phyciodes", "Tegosa",
          "Anthanassa", "Castilia", "Telenassa", "Dagon", "Eresia", "Janatella")
tips <- c(tips, "Prothoe", "Euxanthe", "Charaxes", "Prepona", "Zaretis", "Anaea", "Fountainea", "Polygrapha")
tips <- c(tips, "Dynastor", "Catoblepia", "Narope", "Haetera", "Melanitis")
tips <- c(tips, "Torynesis", "Aeropetes", "Tarsocera")
tips <- c(tips, "Penthema", "Zethera", "Ethope", "Taenaris", "Morphotenaris", "Amathuxidia", "Zeuxidia", "Chonala")
tips <- c(tips, "Lasiommata")
tips <- c(tips, "Hallelesis", "Henotesia", "Enodia", "Satyrodes", "Coenonympha", "Triphysa")
tips <- c(tips, "Harsiesis",  "Altiapa", "Percnodaimon", "Argyrophenga")
tips <- c(tips, "Megisto", "Yphthimoides", "Moneuptychia", "Rareuptychia", "Taygetis", "Guaianaza", "Forsterinaria", "Harjesia")
tips <- c(tips, "Paryphthimoides", "Caeruleuptychia", "Magneuptychia", "Taydebis", "Neonympha", "Erichthodes", "Pareuptychia")
tips <- c(tips, "Ypthimomorpha", "Pseudonympha", "Neocoenyra", "Cercyonis")
tips <- c(tips, "Aphantopus", "Hipparchia", "Neominois", "Oeneis", "Brintesia", "Arethusana", "Satyrus",
          "Chazara", "Pseudochazara")
tips <- c(tips, "Panyapedaliodes", "Parapedaliodes", "Punapedaliodes")
tips <- c(tips, "Eteona", "Foetterleia", "Daedalma", "Apexacuta", "Pseudomaniola", "Lasiophila", "Oxeoschistus",
          "Proboscis", "Mygona", "Lymanopoda", "Faunula", "Etcheverrius", "Pampasatyrus", "Elina", "Quilaphoetosus",
          "Auca", "Chillanella", "Cosmosatyrus")

phy <- ladderize(phy)

phy <- drop.tip(phy, tips); pdf(file="~/Desktop/a.pdf", height=20); plot(phy, cex=0.3); axisPhylo(side=3); dev.off()

# find cut-off Ithomiini
ithomiini <- findMRCA(phy, tips=c("Megoleria", "Mcclungia"))

# node = 413 age 24.866382
x <- branching.times(phy)
time_ithomiini <- x[names(x)==ithomiini]
# round it
time_ithomiini <- floor(time_ithomiini)

t <- findMRCA(phy, tips=c("Pedaliodes", "Praepedaliodes"))
# 360
x_cut <- x[names(x) == t]
# 24.55857



t <- findMRCA(phy, tips=c("Sephisa", "Hestinalis"))
# 360
x_cut <- x[names(x) == t]
# 24.458



t <- findMRCA(phy, tips=c("Junonia", "Protogoniomporha"))
# 360
x_cut <- x[names(x) == t]
# 24.458
x_cut



t <- findMRCA(phy, tips=c("Cithaerias", "Pseudohaetera"))
# 360
x_cut <- x[names(x) == t]
# 24.468
x_cut

####
cut_off <- "24.4 Mya";

###################################
### Using data from Folmer Bokma
###################################
dd <- read.csv("data/strict_cutoff_24.csv")
dd <- dd[ order(dd[,1]), ]

tax <- read.csv("ancillary/supp_mat_03_richness.csv")
tax <- tax[ order(tax[,1]), ]

# adding richnes to data.frame
dd$taxa <- tax[,2]

new_clades <- sort(dd[,2])
new_clades <- unique(new_clades)

# dd[,7][dd[,2]==130]

add_taxa <- function(clade_number) {
  # clade_number = 130
  # dd => new tree as data matrix from Bokma
  # return => sum of taxa for that clade number
  taxa_from_genera <- dd[,7][dd[,2] == clade_number]
  taxa_from_genera <- sum(taxa_from_genera)
  taxa_from_genera
  }

new_clades_tax <- unlist(lapply(new_clades, add_taxa))

####
# create dataset needed to use the SysBio formulae
new_data <- data.frame(new_clades);

# branching times 
new_data[,2] <- dd[ order(dd[,3]), ][1:212,][,6]

# stem ages
new_data[,3] <- dd[ order(dd[,3]), ][1:212,][,4]

# species numbers
new_data[,4] <- new_clades_tax

colnames(new_data) <- c("clades", "branching_times", "stem_ages", "species_numbers")
head(new_data)

write.csv(new_data, file="data/strict_phylogeny_24.csv", row.names=FALSE)
#####
# try to run the formulas

# p0(t)

### results: conditioned on species ; conditioned on mrca
res <- read.csv("data/strict_phylogeny_24_results2.csv", sep=",")
col <- c("#004165", "#eaab00", "#03253f", "#8e6803", "cyan2", "cyan3");

add.alpha <- function(col, alpha=.5) {
  tmp <- col2rgb(col)/255
  rgb(tmp[1,], tmp[2,], tmp[3,], alpha=alpha)
}

col.fill <- add.alpha(col, 0.5)
profiles.plot(c(res[2], res[3], res[5], res[6]), col.line=col)

x <- sapply(c(res[2],res[3],res[5],res[6]), quantile, c(0.025,0.975))
boxplot(x, col=col)
boxplot(c(res[2]-res[3], res[5]-res[6]))

# net diversification rate
boxplot(c(res[2]-res[3], res[5]-res[6]))

####
# now get bd values for models without strict higher level phylogenies

phy <- read.nexus("ancillary/supp_mat_01_genus.nex")
phy <- drop.tip(phy, tips)
tax <- read.csv("ancillary/supp_mat_03_richness.csv")

# simply BD model without species richness
# r = 0.1454076
bd.ext(phy, tax$n.taxa)

# fit birth death model using phylogeny and taxonomy (species richness)
tax <- read.csv("ancillary/supp_mat_03_richness.csv", row.names=1)
names(tax) <- "sp"

phy <- getTipdata(tax, phy)
fitNDR_1rate(phy)

####
# recreate the tree used in strict level phylogeny
dd <- read.csv("data/strict_cutoff_24.csv")
new_clades <- unique(dd[2])
new_clades <- sort(new_clades[,1])

# get tips for our new_clades
extract_new_tips <- function(clade_number) {
  new_tip <- dd[,1][dd[,2] == clade_number][1]
  new_tip <- as.character(new_tip)
  new_tip
}

get_tips_to_drop <- function(clade_number) {
  as.character(tail(dd[,1][dd[,2] == clade_number],-1))
}


# read our tree
phy <- read.nexus("ancillary/supp_mat_01_genus.nex")
# outgroups
tips <- c("Achlyodes", "Graphium", "Parnassius", "Baronia", "Troides", "Papilio1", "Papilio2", "Pieris", "Aporia", "Styx", "Hamearis", "Euselasia", "Nymphidium", "Emesis", "Crocozona", "Riodina", "Amarynthis", "Baliochila", "Poritia", "Miletus", "Liphyra", "Lycaena", "Celastrina", "Thecla", "Lucia", "Curetis", "Eurema", "Colias", "Leptidea", "Pseudopontia", "Libyt");
# remove outgroups
phy <- drop.tip(phy, tips)

# to replicate the strict high level taxa we keep only clades older than 24 Mya,
# so some tips need to be dropped
new_clades_tax <- unlist(lapply(new_clades, extract_new_tips))
rm(tips_to_drop)
tips_to_drop   <- unlist(lapply(new_clades, get_tips_to_drop))

# this is our strict high level phylogeny
phy <- drop.tip(phy, tips_to_drop)

# fit birth death model using phylogeny and taxonomy (species richness)
tmp <- read.csv("data/strict_phylogeny_24.csv")
species_numbers <- tmp[4]

tax <- data.frame(1:212)
row.names(tax) <- new_clades_tax

names(tax) <- "sp"
tax$sp <- species_numbers$species_numbers


phy <- getTipdata(tax, phy)

# fit BD model using taxon richness as well phylogeny, from laser package
fitNDR_1rate(phy)

# run MEDUSA
source("code/summarize.turboMEDUSA.R")
taxa <- as.data.frame(cbind(row.names(tax), tax[,1]))
names(taxa) <- c("taxon","n.taxa")

model.limit <- 25
phy <- ladderize(phy)

res <- runTurboMEDUSA(phy=phy, richness=taxa, model.limit, mc=TRUE, num.cores=4, initial.r=0.05, initial.e=0.5)
pdf(file="data/medusa_on_strict_high_level_phylo.pdf", width=9, height=19)
summarize.turboMEDUSA(res, cex=0.4)
dev.off()