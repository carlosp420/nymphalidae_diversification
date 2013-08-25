library("ape");
library("geiger");

#x <- read.csv("Nymp_multiMEDUSA_1000trees_raw.csv", header=T, sep=",", quote="\"")
#x <- read.csv("Nymp_multiMEDUSA_1000trees_raw_clades.csv", header=T, sep=",", quote="\"")
x <- read.csv("raw_data_for_clades_in_MCT.csv", header=T, sep=",", quote="\"")

boxplot(varwidth=T, r~index, data=x, outline=T, pars=list(outcex=0.8, outcol=rgb(0,0,1,1/4)), ylab="r value", xlab="index", main="Boxplot of r values for each node\n with significant bursts as found by MEDUSA\nonly clades present in mct");
#boxplot(epsilon~index, data=x, outline=T, pars=list(outcex=0.8, outcol=rgb(0,0,1,1/4)), ylab="epsilon value", xlab="index", main="Boxplot of epsilon values for each node\n with significant bursts as found by MEDUSA");

# identify index for values between 0.6 and 0.3
r.index <- x$index
r.r <- x$r
r <- matrix(ncol=2, nrow=length(r.r))

for(i in 1:length(r.index)) {
  r[i,1] <- r.index[i];
  r[i,2] <- r.r[i];
}

#find maximum value of r and return its row
max_r_row <- match(max(r[,2]), r[,2])

# return its index
r[max_r_row,1]

#cat Nymp_multiMEDUSA_1000trees_summary.csv | egrep -v '^.+,"y",' | egrep -v '^.+,"[n|y]","NA"' | awk -F , '{print $1}' | sort -u
break_points <- c(1, 15, 155, 195, 256, 269, 288, 318, 49, 57);

#loop here
break_point <- 15;

tips <- mct.clades.nums[break_point]

                 
phy <- read.tree("genus.tree")
plot.phylo(phy, cex=0.1);


## node 413. index 15. Ithomiinae in part
node <- mrca(phy)["Hyposcada", "Episcada"];
node.leaves(phy, node);

color <- c()
for( i in 1:length(phy$tip.label) ) {
  color <- c(color, 1);
}

des <- getDescendants(phy, node=413)

des2 <- c();
for(i in 1:length(des)) { 
  if( des[i] < 399) { 
    des2 <- c(des2, des[i]);
  }
}

for(i in 1:length(color)) {
  if( i %in% des2 != FALSE ) {
    color[i] <- 2;
  }
}

phy <- ladderize(phy);
plot.phylo(phy, cex=0.1, tip.color=color);
nodelabels("15", 413, frame="circle", cex=.5)

# index 288
rows <- which(x$index==288)
r_values <- c();
for(i in 1:length(rows)) { 
    r_values <- c(x[i,]$r, r_values); 
}
