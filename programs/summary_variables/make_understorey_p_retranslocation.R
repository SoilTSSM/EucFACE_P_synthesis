make_understorey_p_retranslocation <- function(retrans_calc_method, 
                                               retrans_coef,
                                               sumDF) {
    ### Calculate understorey p retranslocated
    ### it can be either calculated based on a fixed retranslocation coefficient (simple), 
    ### or based on % live information (mortality)
    
    
    out <- sumDF[sumDF$term == "Understorey P flux", 2:9] - sumDF[sumDF$term == "Understorey Litter P flux", 2:9]
    
    #if (retrans_calc_method == "Simple") {
    #    
    #tmpDF <- sumDF[sumDF$term == "Understorey P flux", 2:7]
    #    
    #    for (i in 1:6) {
    #        tmpDF[,i] <- tmpDF[,i] * retrans_coef$retrans_coef[retrans_coef$Ring==i]
    #    }
    #    
    #    tmpDF$aCO2 <- mean(tmpDF$R2, tmpDF$R3, tmpDF$R6)
    #    tmpDF$eCO2 <- mean(tmpDF$R1, tmpDF$R4, tmpDF$R5)
    #    
    #    out <- tmpDF
#
    #    
    #    
    #} else if (retrans_calc_method == "Mortality") {
    #    mortality <- summaryBy((1-percent_live)~Ring, data=understorey_live_percent, 
    #                           FUN=mean, keep.names=T)
    #    colnames(mortality) <- c("Ring", "percent_dead")
    #    
    #    for (i in 1:6) {
    #        mortality[mortality$Ring == i, "P_flux"] <- sumDF[sumDF$term == "Understorey P flux", i+1] 
    #    }
    #    
    #    mortality$retrans_flux <- with(mortality, percent_dead * P_flux)
#
    #    out <- t(mortality$retrans_flux)
    #    colnames(out) <- c("R1", "R2", "R3", "R4", "R5", "R6")
    #    out <- as.data.frame(out)
    #    out$aCO2 <- round(rowMeans(data.frame(out$R2, out$R3, out$R6)), 4)
    #    out$eCO2 <- round(rowMeans(data.frame(out$R1, out$R4, out$R5)) , 4)
    #    
    #}

    out <- as.data.frame(out)
    
    return(out)
}
