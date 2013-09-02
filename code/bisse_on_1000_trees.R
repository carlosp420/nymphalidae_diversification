library(diversitree);
library(multicore)

run_bisse <- function(
              phy, 
              states_file="ancillary/supp_mat_09_states.csv",
              richness="ancillary/supp_mat_03_richness.csv"
              ) {
  new.phy <- multi2di(phy);
  phy <- new.phy;

  # Process data on using **Solanaceae** as hostplant
  data <- read.csv(states_file, sep=",", header=T, row.names=1);
  data <- data[order(order(phy$tip.label)),]

  # Column 2 is the data for **Solanaceae**
  # Column 1 is for Apocynaceae (data not used in this analysis)
  data.v <- data[,2]
  names(data.v) <- row.names(data)
  phy$tip.state<-data.v
  
  ##################
  # get sampling values. Propotion of extant species in our tree that have state 0 and state 1
  # in relation with the total 
  richness <- read.csv("ancillary/supp_mat_03_richness.csv")
  richness <- richness[order(order(phy$tip.label)),]

  richness_cero <- c();
  richness_one <- c();
  for(i in 1:length(names(data.v))) {
    x <- match(names(data.v)[i], richness$taxon)
    x.state <- data.v[i]
    
    if( is.na(x.state) == FALSE) {
      if( x.state == 0) {
        richness_cero <- c(richness_cero, richness$n.taxa[i])
      }
      if( x.state == 1) {
        richness_one <- c(richness_one, richness$n.taxa[i])
      }
    }
  }
  total_richness_state_cero <- sum(richness_cero);
  total_richness_state_one <- sum(richness_one);
  sampling.f <- c(length(richness_cero)/total_richness_state_cero, length(richness_one)/total_richness_state_one)
  
  lik <- make.bisse(tree=phy, states=phy$tip.state, sampling.f=sampling.f);
  p <- starting.point.bisse(phy);
  fit <- find.mle(lik, p);
  fit$lnLik; # -1613.274

  # > round(coef(fit),3)
  # lambda0 lambda1     mu0     mu1     q01     q10 
  # 0.104   0.157   0.000   0.000   0.000   0.006 

  prior <- make.prior.exponential(1 / (2 * (p[1] - p[3])));
  set.seed(1);

  tmp <- mcmc(lik, fit$par, nsteps=1000, prior=prior, lower=0, w=rep(1,6));
  w <- diff(sapply(tmp[2:7], quantile, c(0.05, 0.95)));
  
  # this runs the markov chain
  samples <- mcmc(lik, fit$par, nsteps=10000, w=w, lower=0, 
                prior=prior, save.every=1000);
  # do burnin
  samples <- subset(samples, i > 7500)
  
  # save to file
  file_conn <- file("combined_bisse.csv", open="at")
  write.csv(samples, file_conn)
  close(file_conn)
  "done"
}
  
phy <- read.nexus("ancillary/supp_mat_02_1000_random_trees_no_outgroups.nex");
mclapply(phy, run_bisse, mc.cores=16)
