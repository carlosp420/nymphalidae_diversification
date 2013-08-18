library("turboMEDUSA")
library(RSvgDevice)

source("code/summarize.turboMEDUSA.R")

args <- commandArgs(trailingOnly = TRUE)

load("ancillary/supp_mat_10_MEDUSA_Nymphalidae_raw_data.csv")

devSVG(file=as.character(args[1]), width=9, height=19)
summarize.turboMEDUSA(res, cex=0.3)
legend("left", legend=c("6. Ithomiini", "4. Charaxes", "9. Danaina"),
                title="Diversification shifts inferred in more \n than 95% of the posterior distribution of trees",
                xjust=0.5,
                bty="o",
                xpd=TRUE)
dev.off()