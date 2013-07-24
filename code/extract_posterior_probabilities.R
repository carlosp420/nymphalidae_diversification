install.packages("~/Downloads/phyloch_1.5-3.tar.gz", repos=NULL, type="source")
library(phyloch)

phy <- read.beast("../data/supp_mat01_genus.nex")
nodes <- unique(phy$edge[,1])


plot(phy, cex=0.2)
nodelabels(text=phy$posterior, edge=unique(phy$edge[,1]))

library(ape)
library(geiger)

getAllSubtrees<-function(phy, minSize=2) {
    res<-list()
    count=1
    ntip<-length(phy$tip.label)
    for(i in 1:phy$Nnode) {
        l<-node.leaves(phy, ntip+i)
        bt<-match(phy$tip.label, l)
        if(sum(is.na(bt))==0) {
            st<-phy
        } else st<-drop.tip(phy, phy$tip.label[is.na(bt)])
        if(length(st$tip.label)>=minSize) {
            res[[count]]<-st
            count<-count+1
        }
    }
    res
}


phy <- read.nexus("data/supp_mat01_genus.nex")
subtrees <- getAllSubtrees(phy)

plot(phy, cex=0.2, show.node.label=TRUE)