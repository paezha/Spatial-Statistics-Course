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

# Load libraries at once 
list_lib <- c("tidyverse", "rgdal", "maptools", "leaflet", "htmltools", "leaflet.extras")
lapply(list_lib, require, character.only = TRUE)

# Get basemap
london_main <- leaflet() %>% addProviderTiles(provider = providers$CartoDB.DarkMatter) %>% 
  setView(lng = -.137, lat = 51.513, zoom = 16)

london_main

# Read geographical information
deaths <- readOGR("SnowGIS/Cholera_Deaths.shp")
pumps <- readOGR("SnowGIS/Pumps.shp")

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

pal <- colorFactor(c("red", "black"), domain = c(as.character(unique(data$type))))

# Subset by death cases
df_deaths <- subset(data, type == "death")
# Data was originally aggregated by address. Expand by number of cases, so that each case is one row
df_deaths_expanded <- expandRows(df_deaths, "Count")
# Subset by pumps
df_pumps <- subset(data, type == "pump")

pal <- colorNumeric(
  palette = "PuRd",
  domain = df_deaths$Count
)

final_map <- london_main %>% 
  addCircleMarkers(lng = df_deaths$long, lat = df_deaths$lat, color = pal(df_deaths$Count), radius = df_deaths$Count, label = htmlEscape(as.character(df_deaths$Count)), fillOpacity = 1) %>% 
  addCircleMarkers(lng = df_pumps$long, lat = df_pumps$lat, color = "yellow", radius = 5) %>% 
  addLegend("bottomright", pal = pal, values = df_deaths$Count, title = "Cholera Deaths") %>% 
  addLegend("bottomright", colors = "yellow", labels = "Pumps") 

final_map

heat_map <- leaflet() %>% addProviderTiles(provider = providers$CartoDB.DarkMatter) %>% 
  setView(lng = -.137, lat = 51.513, zoom = 16) %>% addHeatmap(lng = df_deaths$long, lat = df_deaths$lat, intensity = df_deaths$Counts, 
                                                               radius = 10)
  
heat_map
