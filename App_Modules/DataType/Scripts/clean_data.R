library(readr)

fed_data   <- data.frame(read_csv("Data/Raw Data/FedRawData.csv"))
store_vars <- c(which(colnames(fed_data) == "PROV_TERR"), which(colnames(fed_data) == "VARIABLE"), which(colnames(fed_data) == "VALUE_VALEUR"), 
                which(colnames(fed_data) == "LATITUDE"), which(colnames(fed_data) == "LONGITUDE"))

clean_fed  <- fed_data[,c(store_vars)]

#Grab Arsenic, Cadmium, lead, PH 
grab_val     <- c(unique(clean_fed$VARIABLE)[c(2,3,5,7)])
grab_num_val <- sum(sort(table(clean_fed$VARIABLE))[c(10,27,31,36)])

clean_2 <- subset(clean_fed, clean_fed$VARIABLE == grab_val[1] | clean_fed$VARIABLE == grab_val[2] | 
                    clean_fed$VARIABLE == grab_val[3] | clean_fed$VARIABLE == grab_val[4])


write.csv(clean_2, "Data/Geospatial/Spatial Continuous/Water_Environment.csv")


#### Clean data for broadband
broad_band <- data.frame(read_csv("Data/Fixed_Broadband_Deployment_Data__June__2017_Status_V1.csv"))
MA_Broad_band <- broad_band[broad_band$State == "MA", ]
rm(broad_band)

Census_Block <- num_provide <- c()
j <- 1
for(i in 71385:length(unique(MA_Broad_band$Census.Block.FIPS.Code))){
  temp_df <- MA_Broad_band[MA_Broad_band$Census.Block.FIPS.Code == unique(MA_Broad_band$Census.Block.FIPS.Code)[i],]
  Census_Block <- c(Census_Block, unique(MA_Broad_band$Census.Block.FIPS.Code[i]))
  num_provide  <- c(num_provide, nrow(temp_df))
  print(j)
  j <- j + 1
}

new_data <- data.frame(Census_Block, num_provide)
write.csv(new_data, "Data/MA_Census/Broadband.csv")

#restart the application and run the rest of the script - NEED ARCGIS TO DO THE MERGE. 
library(rgdal)
MA_shp <- readOGR(dsn = "Data/MA_Census", layer = "CENSUS2010BLOCKGROUPS_POLY")[,5]
new_data <- data.frame(read_csv("Data/MA_Census/Broadband.csv"))

MA_shp_merge <- merge(as.numeric(as.character(MA_shp$GEOID10)), as.numeric(as.character(new_data$Census_Block)), all.x = TRUE)

