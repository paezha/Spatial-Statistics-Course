# Air Quality on Nov. 12 @ 15:00 
library(rvest)

get_list_urls <- read_html("http://www.airqualityontario.com/history/summary.php") %>% html_nodes("a") %>% html_attr("href")

city <- lat <- lon <- pollutant <- pollutant_level <- c()
for(g in get_list_urls){
  if(length(grep("stationid", g)) > 0){
    if(length(grep("pol_code", g)) == 0){
      odd_data  <- read_html(paste("http://www.airqualityontario.com", g, sep = "")) %>% html_nodes(".oddrow") %>% html_text()
      even_data <- read_html(paste("http://www.airqualityontario.com", g, sep = "")) %>% html_nodes(".evenrow") %>% html_text()
      
      city <- c(city, odd_data[2])
      lat  <- c(lat, odd_data[4])
      lon  <- c(lon, even_data[4])
      
      pollutant       <- c(pollutant, odd_data[9])
      pollutant_level <- c(pollutant_level, odd_data[10])
      pollutant       <- c(pollutant, odd_data[11])
      pollutant_level <- c(pollutant_level, odd_data[12])
      
      pollutant       <- c(pollutant, even_data[9])
      pollutant_level <- c(pollutant_level, even_data[10])
      pollutant       <- c(pollutant, even_data[11])
      pollutant_level <- c(pollutant_level, even_data[12])
      
      Sys.sleep(sample(5:8)[1])
    }
  }
}

city_loc <- cbind(city, lat, lon)

new_data <- c()
for(l in 1:ncol(city_loc)){
  for(v in city_loc[,l]){
    new_data <- c(new_data, rep(v, 4))
  }
}

new_df <- data.frame(matrix(new_data, nrow = 152, ncol = 3), pollutant = pollutant, pollutant_level = pollutant_level)
colnames(new_df)[1:3] <- c("City", "Lat", "Lon")

new_df$pollutant_refine <- as.integer(as.character((gsub("([0-9]+).*$", "\\1", new_df$pollutant_level))))
new_df$pollutant_measure <- unlist(lapply(as.character(new_df$pollutant_level), function(x) substr(x, nchar(gsub("([0-9]+).*$", "\\1", x))+2, nchar(x))))
write.csv(new_df, "Data/Geospatial/Spatial Continuous/AirPollution.csv")
