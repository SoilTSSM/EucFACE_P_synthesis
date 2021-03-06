make_wood_p_concentration <- function(func) {
    
    ### download the data
    infile <- "download/FACE_P0020_RA_leafP-Eter_20130201-20151115_L1.csv"
    if(!file.exists(infile)) {
        download_canopy_p_data()
    }

    df <- read.csv(infile)
    
    ### setting up the date
    df$Date <- paste0("1-", as.character(df$Campaign))
    df$Date <- as.Date(df$Date, "%d-%b-%y")
    
    df.wood <- subset(df, Type == "wood")
    
    
    ### Wood p, average across rings and date, unit = %
    df.wood.p <- summaryBy(PercP~Ring+Date,
                           data=df.wood,FUN=func,keep.names=T,na.rm=T)
    df.wood.p$month <- month(df.wood.p$Date)
    df.wood.p$year <- year(df.wood.p$Date)
    
    return(df.wood.p[,1:3])
    

}