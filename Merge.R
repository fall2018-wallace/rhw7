

library(ggplot2)


library(ggmap)

#Merged dataframe with the attributes from both dataset:mergeDF

DataSetMerged <- merge(dfStatesNew, arrests, by ="statename")
View(DataSetMerged)

#Describe DataSetMerged

str(DataSetMerged)
summary(DataSetMerged)

#•Create a new Data frame that has the area of each state (state.area), and the center of each state (state.center), and then merge (by stateName) it with your final data frame in step #1.


statename <- arrests$statename 
area <- state.area
center <- state.center

mergeDf <- data.frame(statename, area, center)

merge_data <- merge(DataSetMerged,mergeDf, by = "statename")
View(merge_data)



us <- map_data("state")
View(us)
merge_data$statename <- tolower(merge_data$statename)

#Step B: Generate a color coded map
#•	Create a color coded map, based on the area of the state 

map_area <- ggplot(merge_data, aes(map_id = statename))
map_area <- map_area + geom_map(map = us, aes(fill = merge_data$area))      
map_area <- map_area + expand_limits(x = us$long , y = us$lat) + coord_map() + ggtitle("Area of United States")
map_area

#Step C: Create a color shaded map of the U.S. based on the Murder rate for each state 
#•Repeat step B, but color code the map based on the murder rate of each state.
map_mur <- ggplot(merge_data, aes(map_id = statename))
map_mur <- map_mur + geom_map(map = us, aes(fill = merge_data$Murder))      
map_mur <- map_mur + expand_limits(x = us$long , y = us$lat) + coord_map() + ggtitle("United States based on the Murder rate per state")
map_mur

#•Show the population as a circle per state
#(the larger the population, the larger the circle) using the location defined by the center of each state


map_mur_pop <- ggplot(merge_data, aes(map_id = statename))
map_mur_pop <- map_mur_pop + geom_map(map = us, aes(fill = merge_data$Murder)) 
map_mur_pop <- map_mur_pop + expand_limits(x = us$long , y = us$lat) + coord_map() + ggtitle("United States based on the Murder rate per state")
map_mur_pop<- map_mur_pop + geom_point( x = merge_data$x, y = merge_data$y, aes(size = merge_data$population))      
map_mur_pop<- map_mur_pop + ggtitle("Area of United States") 
map_mur_pop

NYC <- geocode(source = "dsk", "nyc, new york,ny")
NYC

#Step D: Zoom the map
#•Repeat step C, but only show the states in the north east
#Hint: get the lat and lon of new york city
#Hint: set the xlim and ylim to NYC +/- 10

zoom_map <- ggplot(merge_data, aes(map_id = statename))
zoom_map <- zoom_map + geom_map(map = us, aes(fill = merge_data$Murder)) 
zoom_map <- zoom_map + expand_limits(x  = us$long, y = us$lat ) + coord_fixed(xlim = c(NYC$lon -10,NYC$lon +10), ylim = c(NYC$lat +10,NYC$lat -10)) 
zoom_map<- zoom_map + geom_point( x = merge_data$x, y = merge_data$y, aes(size = merge_data$population))      
zoom_map <- zoom_map + ggtitle(" NYC Murder Rate")
zoom_map
