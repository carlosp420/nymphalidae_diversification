library(phyloch)
library(turboMEDUSA)

for( i in 368:1000) {
  phy <- read.beast(paste0("output/variable_topology/set_", i, ".nex_mct.nex"))
  posterior_prob <- phy$posterior
  
  n_low_prob <- length(which(posterior_prob < 0.95))/length(posterior_prob)
  n_high_prob <- 1 - n_low_prob
  file_conn <- file("/home/carlosp420/Desktop/percentage_nodes_high_post_prob.csv", open="at");
  writeLines(c(paste(i,n_high_prob, sep=",")), file_conn)
  close(file_conn);
}
