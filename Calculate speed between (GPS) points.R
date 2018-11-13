#### The following code uses location (in latitude and longitude) and time (date and time) to calculate speed
#### It can be applied to a data frame to create a new column of speed, where the first row will be zero.

# data frame columns = 
# "Longitude" , "Latitude" , "Date" , "Time"
# where "Date" is in the format dd/mm/yyyy and "Time" is in the format Hours:Minutes:Seconds
# returns speed in m/s

# Install and load packages

if(!"sp" %in% installed.packages())
install.packages("sp")
library(sp)
 
if(!"trip" %in% installed.packages())
install.packages("trip")
library(trip)

# speed function
 
speed <- function(x){

  trip.matrix <- data.matrix(x[,c("Longitude","Latitude")], rownames.force = NA) #creates two column matrix of lat and long for trip trackDistance function
  between.point.distances <- trackDistance(trip.matrix, longlat = TRUE)          #calculate distance between each GPS point, into vector
  x$PointDist <- c(0,between.point.distances)                                    #dist in km
  x$DateTime <- as.POSIXct(paste(x$Date, x$Time), tz="",                         #add column of date and time in present time zone
    format="%d/%m/%Y %H:%M:%S")                                                  #for date format dd/mm/yyyy and time format Hours:Minutes:Seconds, units = mins
  x$TimeElapsed <- 0                                                             #create empty column to fill with for loop
  
  for (i in 2:NROW(x)){
    x$TimeElapsed[i] <- difftime(x$DateTime[i], x$DateTime[i-1],                 # new column of time elapsed since previous point
    units = "secs")                                                              #time diff in secs
    }
 
  (x$PointDist * 1000)/x$TimeElapsed                                             #speed = dist/time. in m/s
}


# e.g. to run on data frame as:
# df$Speed <- speed(df)
