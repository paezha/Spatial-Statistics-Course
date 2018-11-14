library(rgdal)
pumps <- readOGR(dsn = ".", "Pumps")
cholera <- readOGR(dsn = ".", "Cholera_Deaths")

pumps$Count <- "0" #Create a pseudo-column with pseudo-values to make the rbind possible
pumps$type <- "Pumps"
cholera$type <- "deaths"

# Combine the shapefiles into one and reproject it to longitude and latitude coordinate systems 
comb_shp <- rbind(cholera, pumps)
coordinates(comb_shp)=~coord.x1+coord.x2
proj4string(comb_shp)=CRS("+init=epsg:27700")
project_comb_shp <- spTransform(comb_shp, CRS("+proj=lonlat +datum=WGS84"))


writeOGR(project_comb_shp, dsn = ".", layer = "Combined_Pumps_Cholera_Deaths", driver = "ESRI Shapefile")
