make_leaflitter_flux <- function(){
  
  litter_raw <- download_leaflitter()  
  
  # glitch fix
  litter_raw$Ring <- as.character(litter_raw$Ring)
  litter_raw$Trap <- as.character(litter_raw$Trap)
  litter_raw$Ring[is.na(litter_raw$Ring)] <- litter_raw$RING[is.na(litter_raw$Ring)]
  litter_raw$TRAP[is.na(litter_raw$Ring)] <- litter_raw$RING[is.na(litter_raw$Ring)]
  
  # Conversion factor from g basket-1 to mg m-2
  conv <- 1000 / frass_basket_area
  
  litter <- dplyr::mutate(litter_raw, 
                   Date = as.Date(litter_raw$Date, format = "%d/%m/%Y"),
                   Start_date = Date - days.past,
                   End_date = Date,
                   Leaf = as.numeric(Leaf) * conv / days.past)
  
  # Averages by Ring
  litter_a <- summaryBy(Leaf ~ Date + Ring, FUN=mean, na.rm=TRUE,
                        data=litter, id = ~Start_date + End_date, keep.names=TRUE)
  
  # return leaf flux in unit of mg m-2 d-1 (not C or P, just leaf litter mass!!!)
  litter_a <- as.data.frame(dplyr::rename(litter_a,
                                   leaf_flux = Leaf))
  
  return(litter_a)
}

