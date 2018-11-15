libraries <- c("shiny", "leaflet", "rgdal", "readr", "RColorBrewer", "htmltools")
lapply(libraries, require, character.only = TRUE)

ui <- navbarPage("Applied Spatial Statistics (GEOG 4GA3) - Module 2", id = "nav", 
                 tabPanel("Point Pattern", 
                          div(class = "outer", 
                              tags$head(
                                tags$style(type = "text/css", 
                                           "div.outer{position:fixed; top: 36px; left:0; right:0; bottom:0; overflow:hidden; padding:0;}
                                          #center_hist {text-align: center; position: relative; font-size: 18px; font-family: garamond;}
                                           .control-label {text-align: center; position: relative; font-size: 18px; font-family: garamond; font-weight: bold; bottom: 10px; top: 10px;}
                                          #container {margin-top: 14px; margin: auto; position: inherit; text-align: center; font-size: 32px; font-weight: bold; font-family: garamond;}
                                          .panel {display: block; max-width: 450px; opacity: 0.78; background-color: white; border: 4px solid #D7DBDD; border-radius: 12px;}
                                          .panel:hover{opacity:0.95; background-color: white;   transition-delay: 0;}
                                          .shiny-input-container {right: -15%; position: relative;}
                                          .selectize-input {max-width: 200px; top: 20px;}
                                          .irs {max-width: 200px;}
                                          .irs-with-grid {top: 20px;}
                                          #point_questions {text-align: center; position: relative;}"
                                          )
                              ), 
                              leafletOutput("map", width = "100%", height = "100%"), 
                              absolutePanel(id = "controls", class = "panel panel-default", 
                                            fixed = TRUE, draggable = TRUE, top = 118, left = 20, bottom = "auto",
                                            width = 300, height = "auto",
                                            uiOutput("point_questions")
                                            )
                              )
                          ),
                 tabPanel("Spatially Continuous", 
                          div(class = "outer", 
                              tags$head(
                                tags$style(type = "text/css", 
                                           "div.outer{position:fixed; top: 36px; left:0; right:0; bottom:0; overflow:hidden; padding:0;}
                                            #center_hist {text-align: center; position: relative; font-size: 18px; font-family: garamond;}
                                             .control-label {text-align: center; position: relative; font-size: 18px; font-family: garamond; font-weight: bold; bottom: 10px; top: 10px;}
                                            #container {margin-top: 14px; margin: auto; position: inherit; text-align: center; font-size: 32px; font-weight: bold; font-family: garamond;}
                                            .panel {display: block; max-width: 450px; opacity: 0.78; background-color: white; border: 4px solid #D7DBDD; border-radius: 12px;}
                                            .panel:hover{opacity:0.95; background-color: white;   transition-delay: 0;}
                                            .shiny-input-container {right: -15%; position: relative;}
                                            .selectize-input {max-width: 200px; top: 20px;}
                                            .irs {max-width: 200px;}
                                            .irs-with-grid {top: 20px;}
                                            #continuous_questions {text-align: center; position: relative;}"
                                )
                              ),
                              leafletOutput("map2", width = "100%", height = "100%"), 
                              absolutePanel(id = "controls", class = "panel panel-default", 
                                            fixed = TRUE, draggable = TRUE, top = 118, left = 20, bottom = "auto", 
                                            width = 300, height = "auto",
                                            selectInput("chem", "Select Pollutant", choices = c("O3", "PM2.5")),
                                            br(),
                                            sliderInput("classes", "Classification Bins", min = 3, max = 7, value = 4, step = 1), 
                                            br(),
                                            uiOutput("continuous_questions")
                                            )
                              )
                          ),
                 tabPanel("Area",
                          div(class = "outer", 
                              tags$head(
                                tags$style(type = "text/css", 
                                           "div.outer{position:fixed; top: 36px; left:0; right:0; bottom:0; overflow:hidden; padding:0;}
                                            #center_hist {text-align: center; position: relative; font-size: 18px; font-family: garamond;}
                                             .control-label {text-align: center; position: relative; font-size: 18px; font-family: garamond; font-weight: bold; bottom: 10px; top: 10px;}
                                            #container {margin-top: 14px; margin: auto; position: inherit; text-align: center; font-size: 32px; font-weight: bold; font-family: garamond;}
                                            .panel {display: block; max-width: 450px; opacity: 0.78; background-color: white; border: 4px solid #D7DBDD; border-radius: 12px;}
                                            .panel:hover{opacity:0.95; background-color: white;   transition-delay: 0;}
                                            .shiny-input-container {right: -15%; position: relative;}
                                            .selectize-input {max-width: 200px; top: 20px;}
                                            .irs {max-width: 200px;}
                                            .irs-with-grid {top: 20px;}
                                            #area_questions {text-align: center; position: relative;}"
                                )
                              ),
                              leafletOutput("map3", width = "100%", height = "100%"),
                              absolutePanel(id = "controls", class = "panel panel-default", 
                                            fixed = TRUE, draggable = TRUE, top = 118, left = 20, bottom = "auto",
                                            width = 300, height = "auto", 
                                            selectInput("class_type", "Classification Type", choices = c("Choropleth", "Quantiles", "Std. Deviation")),
                                            br(),
                                            sliderInput("area_classes", "Classification Bins", min = 3, max = 7, value = 4, step = 1),
                                            br(),
                                            uiOutput("area_questions")
                                            )
                              )
                          )
)

server <- function(input, output, session){
  #####################################################################################################
  #########################################  Point Pattern ############################################
  #####################################################################################################
  #wifi_icon   <- makeIcon(iconUrl = "Image/icon.png")
  wifi_icon    <- makeIcon(iconUrl = "Image/wifi_blue.png", iconWidth = 24, iconHeight = 24)
  wifi_points <- readOGR(dsn = "Data/Geospatial/Point", "WiFi_Collector_Wicked_Free_")
  
  #html_wifi   <- "<img src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAMAAADXqc3KAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAABRFBMVEUAAACAAP+qVaqVQMSUP8aSPcWTPcWTPsWSPsWTPsWTPcWUP8WXOsWSSbaTPsaTPsSTPsWTPsaTPsGUPMaTPsWSPsX/AP+TPsWTPsWTPsaUP8WUPcSSPsWTPceUP8WUPsSTPsWTPsaTPsWXQsaAQL+SPsaTPsWTPsaSN8iSPsSTPsWTPsWWPMOSPsSTPsWTPcSPPcKVQMaSQMSTPsWTPsWTPsWTPsWTP8aTPsWTPsWTPsWTPsWTPsWOOcaZM8yTPsWSPsWTPsWTPsWPQL+SPcKTPsWTP8WTPcWUPsWUP8WTQMOTPsWTPsWZM8ySPcKTPsWTPsWTP8WSPsaTPsSUPsWTPsWWPciUP8WTPsaUPsSSPcSfQL+TPsWUPcSRPMOSQMeOOcaVQL+TPsWTPsaUPsWSPsWRPsaTPsWUP8WUPcaTPsUAAACT1ymeAAAAanRSTlMAAgM8isPg++vWnl0WB2/n+JchTON8AYD+3qt5RjtpmMf0wRsEqcktDpT94SKP9XEZJDjTveXLVari98+QEgXXc/a0EBWsYVykOUDpuQoq+ah2XouRzi5y1Va3CNlkM0QJDO50nbw6zdhwLTlLEQAAAAFiS0dEAIgFHUgAAAAJcEhZcwAADdcAAA3XAUIom3gAAAAHdElNRQfiChkRKCpr+76mAAAA80lEQVQoz2NgoAQwYhFjYmZhZWNn5+Dk4uZBEubl48+CAwFBIZi4sEgWCmAXBRsqJi4B4klKScvIyskrKII4SsoMDCqqIJaaOky7hqYWkK+tw6ALpPT0wXoNDMGUkTFQyITBNCvLDGSbuYVlVpaVtY0tA4MdS1aWPYODo5MzA4OLK8xmDjcxBgZ3D0+gPFC5lzeSo3x84f7w0wPy/QMCg4KtQTIhcAkbIC80DBwq4Y5ZWRFwicisrKhoKNszRi8WESZx8UAb7czdEkAeTkQLR1tgeCUZYgngZFR7ESAFJJGKRSINJGGOLQJj0zMyVShKAjgAAMTjQqMDL3e+AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDE4LTEwLTI1VDE3OjQwOjQyKzAyOjAw4UFMrAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAxOC0xMC0yNVQxNzo0MDo0MiswMjowMJAc9BAAAAAZdEVYdFNvZnR3YXJlAHd3dy5pbmtzY2FwZS5vcmeb7jwaAAAAAElFTkSuQmCC'>Free WiFi</br>"
  
  output$map <- renderLeaflet({
    leaflet() %>% 
      addProviderTiles(providers$CartoDB.DarkMatterNoLabels, group = "CartoDB-Dark") %>% 
      addProviderTiles(providers$Esri.WorldGrayCanvas, group = "Esri WorldGrey") %>% 
      addProviderTiles(providers$Esri.WorldImagery, group  = "Esri - Satellite") %>% 
      addMarkers(lng = wifi_points@coords[,1], lat = wifi_points@coords[,2], icon = wifi_icon) %>% 
      fitBounds(lng1 = max(wifi_points@coords[,1]), lat1 = max(wifi_points@coords[,2]),
                lng2 = min(wifi_points@coords[,1]), lat2 = min(wifi_points@coords[,2])) %>%
      #addControl("bottomright", html = html_wifi) %>% 
      addLayersControl(baseGroups = c("CartoDB-Dark", "Esri WorldGrey", "Esri - Satellite"), options = layersControlOptions(collapsed = TRUE))
  })
  
  output$point_questions <- renderUI({HTML("<u><strong>Questions</strong></u><br>Are the free wifi points randomly located?")})
  
  #####################################################################################################
  ################################### Spatially Continuous ############################################
  #####################################################################################################
  air_qual    <- na.omit(read.csv("Data/Geospatial/Spatial Continuous/AirPollution.csv", encoding = "utf-8"))
  output$map2 <- renderLeaflet({
    leaflet(air_qual) %>% 
      addProviderTiles(providers$CartoDB.DarkMatterNoLabels, group = "CartoDB-Dark") %>% 
      addProviderTiles(providers$Esri.WorldGrayCanvas, group = "Esri WorldGrey") %>% 
      addProviderTiles(providers$Esri.WorldImagery, group  = "Esri - Satellite") %>%
      fitBounds(lng1 = max(air_qual$Lon), lat1 = max(air_qual$Lat), lng2 = min(air_qual$Lon), lat2 = min(air_qual$Lat)) %>% 
      addLayersControl(baseGroups = c("CartoDB-Dark", "Esri WorldGrey", "Esri - Satellite"), options = layersControlOptions(collapsed = TRUE))
  })
  
  observeEvent(input$chem, {
    observeEvent(input$classes, {
      filt <- subset(air_qual, air_qual$pollutant == input$chem)
      palette <- brewer.pal(input$classes, "PRGn")
      pal     <- colorNumeric(palette = palette, domain = filt$pollutant_refine)
      leafletProxy("map2") %>% clearMarkers %>% clearShapes() %>% clearControls() %>%
                addCircles(lng = filt$Lon, lat = filt$Lat, color = pal(filt$pollutant_refine), radius = 5000, fillOpacity = 1, weight = 5, label = htmlEscape(as.character(filt$pollutant_level))) %>%
                addLegend("bottomright", pal = pal, values = filt$pollutant_refine, title = paste("Pollution Level (", filt$pollutant_measure[1], ") of ", input$chem, sep = ""))
          })
  })
  
  output$continuous_questions <- renderUI({HTML("<u><strong>Questions</strong></u><br>Do you see a spatially continuous pattern?<br><br>What happens if you change the number of classification bins?<br><br>Does it then change the pattern perception?")})
  
  #####################################################################################################
  ########################################## Area Data ################################################
  #####################################################################################################
  hamilton_income <- readOGR("Data/Geospatial/Area", "Hamilton_Income_Final")
  
  std_dev_income <- sd(as.numeric(as.character(hamilton_income$income)))
  mean_income    <- mean(as.numeric(as.character(hamilton_income$income)))
  income_lev <- as.numeric(as.character(hamilton_income$income))

  # Calculate Standard deviation of each value
  sd_lev <- c()
  for(i in income_lev){
    if(i < mean(income_lev)){
      sd_lev <- c(sd_lev, -((mean(income_lev) - i) / sd(income_lev)))
    }
    else{
      sd_lev <- c(sd_lev, (abs(mean(income_lev) - i) / sd(income_lev)))
    }
  }

  test_df <- data.frame(income = income_lev, sd_dev = round(sd_lev,2))

  #label each standard deviation value as a range
  label_std <- c()
  for(t in test_df$sd_dev){
    if(t <= 0.5 & t >= 0){
      label_std <- c(label_std, "0 - 0.5 std.")
    }
    else if(t > 0.5 & t <= 1){
      label_std <- c(label_std, "0.5 - 1 std.")
    }
    else if(t > 1 & t <= 2){
      label_std <- c(label_std, "1 - 2 std.")
    }
    else if(t > 2 & t <= 3){
      label_std <- c(label_std, "2 - 3 std.")
    }
    else if(t > 3){
      label_std <- c(label_std, "> 3 std.")
    }
    else if(t < 0 & t >= -0.5){
      print(t)
      label_std <- c(label_std, "-0.5 to 0 std.")
    }
    else if(t < -0.5 & t >= -1){
      label_std <- c(label_std, "-1 to -0.5 std.")
    }
    else if(t < -1 & t >= -2){
      label_std <- c(label_std, "-2 to -1 std.")
    }
    else if(t < -2 & t >= -3){
      label_std <- c(label_std, "-3 to -2 std.")
    }
    else if(t < -3){
      label_std <- c(label_std, "< -3 std.")
    }
  }

  # Final output of standard deviaton for income
  test_df$lab_std <- label_std
  std_bins <- c(-Inf, -3, -2, -1, -0.5, 0, 0.5, 1, 2, 3, Inf)
  std_pal  <- colorBin("PRGn", bins = std_bins)
  test_df$finalColor <- std_pal(test_df$sd_dev)
  sorted_df <- test_df[order(test_df$sd_dev), ]
  
  output$map3 <- renderLeaflet({
    leaflet(hamilton_income) %>% 
      addProviderTiles(providers$CartoDB.DarkMatterNoLabels, group = "CartoDB-Dark") %>% 
      addProviderTiles(providers$Esri.WorldGrayCanvas, group = "Esri WorldGrey") %>% 
      addProviderTiles(providers$Esri.WorldImagery, group  = "Esri - Satellite") %>%
      fitBounds(lng1 = bbox(hamilton_income)[1], lat1 = bbox(hamilton_income)[2], lng2 = bbox(hamilton_income)[3], lat2 = bbox(hamilton_income)[4]) %>% 
      addLayersControl(baseGroups = c("CartoDB-Dark", "Esri WorldGrey", "Esri - Satellite"), options = layersControlOptions(collapsed = TRUE))
  })
  
  observeEvent(input$class_type, {
    observeEvent(input$area_classes, {
      palette <- brewer.pal(input$area_classes, "PRGn")
      pal     <- colorNumeric(palette = palette, domain = income_lev)
      qpal    <- colorQuantile("PRGn", domain = income_lev, input$area_classes)
      
      if(input$class_type == "Choropleth"){
        leafletProxy("map3", data = hamilton_income) %>% clearShapes() %>% clearControls() %>% addPolygons(fillColor = ~pal(income_lev), fillOpacity = 1, weight = 1, color = "white", label = htmlEscape(as.character(hamilton_income$income))) %>%
          addLegend("bottomright", pal = pal, values = round(as.numeric(as.character(hamilton_income$income))), title = "Median Household Income")
      }
      else if(input$class_type == "Quantiles"){
        leafletProxy("map3", data = hamilton_income) %>% clearShapes() %>% clearControls() %>% addPolygons(fillColor = ~qpal(income_lev), fillOpacity = 1, weight = 1, color = "white", label = htmlEscape(as.character(hamilton_income$income))) %>%
          addLegend("bottomright", pal = qpal, values = round(as.numeric(as.character(hamilton_income$income))), title = "Median Household Income")
      }
      else if(input$class_type == "Std. Deviation"){
        leafletProxy("map3", data = hamilton_income) %>% clearShapes() %>% clearControls() %>% addPolygons(fillColor = ~std_pal(test_df$sd_dev), fillOpacity = 1, weight = 1, color = "white", label = htmlEscape(as.character(test_df$sd_dev))) %>%
          addLegend("bottomright", colors = unique(sorted_df$finalColor), labels = unique(sorted_df$lab_std))
      }
    })
  })  
  
  output$area_questions <- renderUI({HTML("<u><strong>Questions</strong></u><br>Do you see any variation?<br><br>What happens if you change the number of classification bins or symbology type?<br><br>Does it then change the pattern perception?")})
}

shinyApp(ui = ui, server = server)