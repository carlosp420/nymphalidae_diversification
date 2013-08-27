# See if sampling richness data has effect on MEDUSA by using cut-off
# at tribe-subtribe level

library(ape)
library(phytools)

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
