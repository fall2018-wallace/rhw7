
clean_data <- raw_data

#re-use the data from before
readStates <- function(states)
{
    #remove rows that are not needed
    #first row is the total for the US, we do not need that
    states <- states[-1,]
    
    #last row is Puerto Rico, it's not a state
    num.row <- nrow(states)
    states <- states[-num.row,]
    
    #remove the first four columns
    states <- states[,-1:-4]
    
    #change names for remaining columns
    colnames(states) <- c("stateName","population","popOver18","percentOver18")
    
    #return the results
    return(states)
    
}

cleanCensus<-readStates(raw_data)
str(cleanCensus)
c<-cleanCensus
