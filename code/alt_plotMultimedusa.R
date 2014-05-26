plotMultiMedusa_alt <- function (summary, treeRearrange = "down", annotateShift = TRUE, 
          annotateRate = "r.median", plotRichnesses = TRUE, richPlot = "log", 
          time = TRUE, tip.cex = 0.3, shiftScale = 1, label.offset = 0.5, 
          font = 3, shift.leg.pos = "left", power = 1.5, ...) 
{
  dev.new()
  conTree <- summary$summary.tree
  shift.summary <- summary$shift.summary
  rates <- summary$summary.tree$rates
  richness <- summary$richness
  rates <- rates[, annotateRate]
  rates[which(is.nan(rates))] <- NA
  rateColours <- diverge_hcl(20, power = power)
  rateSeq <- seq(min(rates, na.rm = T), max(rates, na.rm = T), 
                 length = 20)
  edgeColours <- suppressWarnings(rateColours[unname(sapply(rates, 
                                                            function(x) min(which(abs(rateSeq - x) == min(abs(rateSeq - 
                                                                                                                x))), na.rm = T)))])
  edgeColours[which(is.na(edgeColours))] <- "#000000"
  minMax <- c(min(rateSeq), max(rateSeq))
  margin <- FALSE
  if (time) 
    margin <- TRUE
  plot.phylo(conTree, edge.color = edgeColours, no.margin = !margin, 
             cex = tip.cex, label.offset = label.offset, font = font, 
             ...)
  lastPP <- get("last_plot.phylo", envir = .PlotPhyloEnv)
  maxX <- lastPP$x.lim[2]
  if (time) {
    axisPhylo(cex.axis = 0.75)
    mtext("Divergence Time (MYA)", at = (max(lastPP$xx) * 
                                           0.5), side = 1, line = 2, cex = 0.75)
  }
  if (all(richness$n.taxa == 1)) 
    plotRichnesses <- FALSE
  if (plotRichnesses) {
    richness2Plot <- NULL
    richness <- richness[match(conTree$tip.label, richness$taxon), 
                         ]
    if (richPlot == "log") {
      richness2Plot <- log(richness$n.taxa + 1)
    }
    else {
      richness2Plot <- richness$n.taxa
    }
    names(richness2Plot) <- richness$taxon
    maxVal <- max(as.numeric(richness2Plot[conTree$tip.label]))
    fontSize <- lastPP$cex
    longestName <- max(nchar(conTree$tip.label))
    nTips <- length(conTree$tip.label)
    richness2Plot <- as.numeric(richness2Plot[conTree$edge[which(conTree$edge[, 
                                                                              2] <= length(conTree$tip.label)), 2]])
    startPos <- max(lastPP$xx) + (longestName * fontSize) + 
      lastPP$label.offset + max(lastPP$xx)/20
    richMultiplier <- ((maxX - startPos)/maxVal) * 0.75
    segments(rep(startPos, nTips), 1:nTips, rep(startPos, 
                                                nTips) + richMultiplier * richness2Plot, 1:nTips, 
             lwd = (tip.cex * 2), col = "blue")
    prettyVals <- pretty(0:maxVal)
    plotAt <- startPos + (prettyVals * richMultiplier)
    axisPlacement <- mean(plotAt)
    axis(1, at = plotAt, labels = prettyVals, cex.axis = 0.75)
    if (richPlot == "log") {
      mtext("ln(species count + 1)", at = axisPlacement, 
            side = 1, line = 2, cex = 0.75)
    }
    else {
      mtext("species count", at = axisPlacement, side = 1, 
            line = 2, cex = 0.75)
    }
  }
  if (annotateShift && (length(shift.summary) > 0)) {
    plotcolor <- rgb(red = 255, green = 0, blue = 0, alpha = 150, 
                     maxColorValue = 255)
    for (i in 1:length(shift.summary[, "shift.node"])) {
        this_node = paste0("node:", shift.summary[, "shift.node"][i])
        this_rate = paste0("prob:", shift.summary[, "sum.prop"][i])

      nodelabels(
            text=paste(this_node, this_rate, sep=", "),
            node = shift.summary[, "shift.node"][i], 
            pch = 21,
            cex = 0.3, 
            frame="none", 
            adj=c(1),
            bg = plotcolor
       )
    }
    legend(x = shift.leg.pos, c("1.00", "0.75", "0.50", "0.25"), 
           pch = 21, pt.bg = plotcolor, pt.cex = (shiftScale * 
                                                    c(1, 0.75, 0.5, 0.25)), inset = 0.05, cex = 0.5, 
           bty = "n", title = "Shift Frequency")
  }
  colorlegend(posy = c(0.3, 0.55), posx = c(0.05, 0.075), col = rateColours, 
              zlim = minMax, zval = seq(min(rateSeq), max(rateSeq), 
                                        length = 10), dz = 0.5, digit = 3, cex = 0.5, zlevels = NULL, 
              main.cex = 0.5, main = "Rate")
}
