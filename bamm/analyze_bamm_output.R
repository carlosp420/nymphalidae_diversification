library(BAMMtools)
tree <- read.tree("bamm/mcc.tre")
edata <- getEventData(tree, eventdata = "bamm/event_data.txt", burnin=0.95, type="trait")
mcmcout <- read.csv("bamm/mcmc_out.txt", header=TRUE)
plot(mcmcout$logLik ~ mcmcout$generation, type="l")

# 50 million generations were run
burnstart <- floor(0.95 * nrow(mcmcout))
postburn <- mcmcout[burnstart:nrow(mcmcout),]
plot(postburn$logLik ~ postburn$generation, type="l")

library(coda)
effectiveSize(postburn$N_shifts)
effectiveSize(postburn$logLik)

post_probs <- table(postburn$N_shifts) / nrow(postburn)

shift_probs <- summary(edata)

# compare with simulated priors
postfile <- "bamm/mcmc_out.txt"
priorfile <- "bamm/prior_probs.txt"
pprior <- getBranchShiftPriors(tree, priorfile)
css_nymp <- credibleShiftSet(edata, pprior)
bmat <- computeBayesFactors(postfile, priorfile, burnin=0.1)
bmat # most likely 8 shifts
summary(edata)
plot.bammdata(edata, lwd=2, legend=TRUE)
plot.credibleshiftset(css_nymp, lwd=1.7, plotmax=4)

# find best configuration


allrates <- getCladeRates(edata)
ithomiiinae <- getCladeRates(edata, node=749)

st <- max(branching.times(tree))
plot.new()
par(mfrow=c(2,3))
plotRateThroughTime(edata, intervalCol = "red", avgCol = "red", start.time=st, ylim=c(0,1), cex.axis=1.5, 
                    cex.lab=1.5)
text(x=80,y=0.8, label="All butterflies", font=3, cex=2.0, pos=4)
plotRateThroughTime(edata, intervalCol = "blue", avgCol = "blue", start.time=st, ylim=c(0,1), cex.axis=1.5, 
                    cex.lab=1.5, node=749)
text(x=80,y=0.8, label="Ithomiinae only", font=3, cex=2.0, pos=4)
plotRateThroughTime(edata, intervalCol = "darkgreen", avgCol = "darkgreen", start.time=st, ylim=c(0,1), cex.axis=1.5, 
                    cex.lab=1.5, node=749, nodetype="exclude")
text(x=80,y=0.8, label="non-Ithomiinae", font=3, cex=2.0, pos=4)

rtt <- getRateThroughTimeMatrix(edata)
meanTraitRate <- colMeans(rtt$beta)
plot(meanTraitRate ~ rtt$times)
