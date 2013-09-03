library(diversitree);
library(RSvgDevice);

add.alpha <- function(col, alpha=.5) {
    tmp <- col2rgb(col)/255
    rgb(tmp[1,], tmp[2,], tmp[3,], alpha=alpha)
}


# do burnin
samples <- read.csv("ancillary/supp_mat_19_combined_bisse.csv")

## get diversification rate values = r:
diversification0 = c();
diversification1 = c();

for (i in 1:length(samples$lambda0)) { 
    r0 = samples$lambda0[[i]] - samples$mu0[[i]];
    r1 = samples$lambda1[[i]] - samples$mu1[[i]];
    
    diversification0 = c(r0, diversification0)
    diversification1 = c(r1, diversification1)
}

diversification0 = as.data.frame(diversification0);
diversification1 = as.data.frame(diversification1);

col <- c("#004165", "#eaab00", "#03253f", "#8e6803");
col.fill <- add.alpha(col, 0.5)
legend <- c(expression(paste(lambda[0],"\tnon-Solanaceae feeders")), 
            expression(paste(lambda[1],"\tSolanaceae feeders")),
            expression(paste('r'[0],"\tnon-Solanaceae feeders")), 
            expression(paste('r'[1],"\tSolanaceae feeders"))
);

# plot diversification rate of taxa not using and using solanaceae as hostplants
svg(filename="ancillary/figS05.svg")
profiles.plot(c(samples[3], samples[4], diversification0, diversification1), 
              col.line=col, 
              las=1, 
              ylab="Posterior probability density", 
              xlab="Speciation/Diversification rate"
              );
legend("topright", legend=legend, fill=col.fill, border=col, bty="n")
dev.off()

