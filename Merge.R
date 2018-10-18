

library("ggplot2")
library("ggmap")


arrests<-USArrests
dfStatesNew
dfStatesNew<-dfStatesNew[-9,]
row.names(arrests)
colnames(dfStatesNew)

arrests$stateName <- dfStatesNew$stateName


#Merge dataframe

DataSetMerged <- merge(dfStatesNew, arrests)


#Describe DataSetMerged

str(DataSetMerged)
summary(DataSetMerged)

#Create a new Data frame that has the area of each state (state.area), and the center of each state (state.center), and then merge it with your final data frame in step #1.


statename <- arrests$stateName 
area <- state.area
center <- state.center

mergeDf <- data.frame(statename, area, center)

merge_data <- merge(DataSetMerged,mergeDf)




us <- map_data("state")

merge_data$statename <- tolower(merge_data$statename)

#Step B: Generate a color coded map
#	Create a color coded map, based on the area of the state 

m1 <- ggplot(merge_data, aes(map_id = statename))
m1 <- m1 + geom_map(map = us, aes(fill = merge_data$area))      
m1 <- m1 + expand_limits(x = us$long , y = us$lat) + coord_map() + ggtitle("Area of United States")
m1

#Step C: Create a color shaded map of the U.S. based on the Murder rate for each state 
#Repeat step B, but color code the map based on the murder rate of each state.
m2 <- ggplot(merge_data, aes(map_id = statename))
m2 <- m2 + geom_map(map = us, aes(fill = merge_data$Murder))      
m2 <- m2 + expand_limits(x = us$long , y = us$lat) + coord_map() + ggtitle("United States based on the Murder rate per state")
m2

#Show the population as a circle per state
#(the larger the population, the larger the circle) using the location defined by the center of each state


m3 <- ggplot(merge_data, aes(map_id = statename))
m3 <- m3 + geom_map(map = us, aes(fill = merge_data$Murder)) 
m3 <- m3 + expand_limits(x = us$long , y = us$lat) + coord_map() + ggtitle("United States based on the Murder rate per state")
m3<- m3 + geom_point( x = merge_data$x, y = merge_data$y, aes(size = merge_data$population))      
m3<- m3 + ggtitle("Area of United States") 
m3

NYC <- geocode(source = "dsk", "nyc, new york,ny")
NYC

#Step D: Zoom the map
#Repeat step C, but only show the states in the north east
#Hint: get the lat and lon of new york city
#Hint: set the xlim and ylim to NYC +/- 10

m4 <- ggplot(merge_data, aes(map_id = statename))
m4 <- m4 + geom_map(map = us, aes(fill = merge_data$Murder)) 
m4 <- m4 + expand_limits(x  = us$long, y = us$lat ) + coord_fixed(xlim = c(NYC$lon -10,NYC$lon +10), ylim = c(NYC$lat +10,NYC$lat -10)) 
m4<- m4 + geom_point( x = merge_data$x, y = merge_data$y, aes(size = merge_data$population))      
m4 <- m4 + ggtitle(" NYC Murder Rate")
m4
