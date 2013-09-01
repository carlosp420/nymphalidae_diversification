# calculate percentage of nodes with posterior probability
# values lower than 0.95

library("phyloch")

get_percentages <- function(phy) {
    posterior_prob <- phy$posterior
    n_low_prob <- length(which(posterior_prob < 0.95))/length(posterior_prob)
    n_high_prob <- 1 - n_low_prob
    n_high_prob
}

for( i in 1:2) {
    # read MCT files, get percentage of high post prob nodes
    phy <- read.beast(paste(
            "output/variable_topology/set_",
            i,
            ".nex_mct.nex",
            sep=""))
    n_high_prob <- get_percentages(phy)
    file_conn <- file("ancillary/supp_mat_16-percentage_nodes_high_post_prob.csv",
                      open="at")
    writeLines(c(paste(i, n_high_prob, sep=",")), file_conn)
    close(file_conn)
}
