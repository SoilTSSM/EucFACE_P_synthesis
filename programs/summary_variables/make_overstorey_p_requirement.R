make_overstorey_p_requirement_table <- function(sumDF) {
    #### Produce a table summarizing the total P requirement based on
    #### NPP, leaf P concentrations in canopy, wood, twig, fine root
    #### and understorey,
    #### Also, ignoring inter-annual variability and ring variability
    #### Just focus on aCO2 and eCO2 for now.
    
    ### total requirement
    myDF <- rbind(sumDF[sumDF$terms == "Wood P flux",], sumDF[sumDF$terms == "Canopy P flux",],
                  sumDF[sumDF$terms == "Fine Root P flux",], sumDF[sumDF$terms == "Coarse Root P flux",],
                  sumDF[sumDF$terms == "Other litter P flux",], sumDF[sumDF$terms == "Frass P flux",])
    
    tot <- colSums(myDF[,2:7])

    out <- matrix(NA, nrow=1, ncol=8)
    out <- as.data.frame(out)
    colnames(out) <- c("R1", "R2", "R3", "R4", "R5", "R6", "aCO2", "eCO2")
    out[1,1:6] <- tot
    
    out$aCO2 <- mean(c(out$R2, out$R3, out$R6))
    out$eCO2 <- mean(c(out$R1, out$R4, out$R5))
    
    return(out)
    
}