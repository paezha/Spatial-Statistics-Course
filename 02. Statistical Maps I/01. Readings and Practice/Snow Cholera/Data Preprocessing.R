# Maps as processes
# Data preprocessing of John Snow's cholera deaths map
# Data sourced from: http://blog.rtwilson.com/?s=snow

#Clear workspace
rm(list = ls())

# ## Download the zip archive of geographical information
# download.file(url      = "http://www.rtwilson.com/downloads/SnowGIS_v2.zip",
#               destfile = "SnowGIS_v2.zip")
# 
# ## Unzip
# unzip(zipfile = "SnowGIS_v2.zip")
# 
# ## List files in the unzipped folder
# dir(path = "./SnowGIS")

#Load libraries
library(tidyverse)
#library(plyr)
library(rgdal)
library(maptools)
library(splitstackshape)
library(ggmap)

# Get basemap
london_main <- get_map(c(-.137,51.513), zoom = 16, source = "stamen", maptype = "watercolor")
# london_main <- get_map(c(-.137,51.513), zoom = 17, color = "bw")
LondonMap <- ggmap(london_main, extent = "device", legend = "topleft")

# Read geographical information
deaths <- readShapePoints("Cholera_Deaths")
pumps <- readShapePoints("Pumps")

df_deaths <- data.frame(deaths@coords)
df_deaths <- cbind(df_deaths,deaths@data)
df_deaths$Id <- c(1:250)
df_pumps <- data.frame(pumps@coords)
df_pumps$Id <- c(251:258)
df_pumps$Count <- 1

data <- rbind(df_deaths, df_pumps)
data$type <- as.factor(c(rep('death', times=dim(df_deaths)[1]),
              rep('pump', times=dim(df_pumps)[1])))

coordinates(data)=~coords.x1+coords.x2
proj4string(data)=CRS("+init=epsg:27700")
data <- spTransform(data, CRS("+proj=longlat +datum=WGS84"))
data <- data.frame(data@coords, Id = data@data$Id, Count =data@data$Count, type=data@data$type)

data <- dplyr::rename(data, long = coords.x1)
data <- dplyr::rename(data, lat = coords.x2)
# colnames(data)[colnames(data)=="coords.x1"] <- "long"
# colnames(data)[colnames(data)=="coords.x2"] <- "lat"

ggmap(london_main, extent = "panel") +
  geom_point(data = data, aes(x = long, y = lat, color = type, size = Count * 20), color = "red")

# Subset by death cases
df_deaths <- subset(data, type == "death")
# Data was originally aggregated by address. Expand by number of cases, so that each case is one row
df_deaths_expanded <- expandRows(df_deaths, "Count")
# Subset by pumps
df_pumps <- subset(data, type == "pump")


ggmap(london_main, extent = "panel") + 
  geom_point(data = df_deaths, aes(x = long, y = lat, size = Count * 20), color = "red") +
  geom_point(data = df_pumps, aes(x = long, y = lat), color = "black", size = 5)

ggmap(london_main, extent = "panel") + 
  geom_point(data = df_pumps, aes(x = long, y = lat, color = type), size = 5) +
  scale_color_brewer(palette = "RdGy", direction = -1)
  


ggmap(london_main) +
  stat_density2d(data = df_deaths_expanded,
    aes(x = long, y = lat, fill = ..level.., alpha = ..level..),
    size = 20, bins = 10,
    geom = "polygon") +
  scale_fill_gradient(low = "white", high = "blue") +
  scale_alpha(range = c(0.5, 0.75), guide = FALSE) +
  geom_point(data = df_deaths, 
             aes(x = long, y = lat, size = Count, shape = type), color = "blue", alpha = 0.5) +
  geom_point(data = df_pumps, 
             aes(x = long, y = lat, shape = type), color = "black", size = 5)
