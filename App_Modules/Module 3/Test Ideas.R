library(sp)
library(spdep)
library(rgdal)

shape <- readOGR(dsn=".", layer = "WiFi_Collector_Wicked_Free_")

N <- length(shape)
w <- bbox(shape)
