libraries <- c("shiny", "leaflet","htmltools", "leaflet.extras", "rgdal", "plotly")
lapply(libraries, require, character.only = TRUE)

# Setting up the UI

ui <- tags$html(
  tags$head(
    tags$title("Applied Spatial Statistics (GEOG 4GA3) - Module 1"),
    tags$style(type = "text/css", 
                "html,body,#map {height: calc(100vh - 50px) !important;} #center_hist {text-align: center; position: relative; font-size: 18px; font-family: garamond;} 
                .control-label {text-align: center; position: relative; font-size: 18px; font-family: garamond; font-weight: bold; bottom: 10px; top: 10px;} 
                #container {margin-top: 14px; margin: auto; position: inherit; text-align: center; font-size: 32px; font-weight: bold; font-family: garamond;}
                .panel {display: block; max-width: 450px; opacity: 0.78; background-color: white; border: 4px solid #D7DBDD; border-radius: 12px;}
                .panel:hover{opacity:0.95; background-color: white;   transition-delay: 0;}
                .shiny-input-container {right: -15%; position: relative;}
                .selectize-input {max-width: 200px; top: 20px;}        
                .irs {max-width: 200px;}
                .irs-with-grid {top: 20px;}
               ")
  ),
  tags$body(
      div(id = "container", "Applied Spatial Statistics (GEOG 4GA3) - Statistical Maps I"),
      leafletOutput("map"),
      absolutePanel(id = 'controls', class = 'panel panel-default',
                    fixed = TRUE, draggable = TRUE, top = 118, left = 20, bottom = "auto",
                    width = 300, height = 580,
                    selectInput("typemap", "Select Type of Map", choices = c("Proportional Symbols", "Heatmap")),
                    br(),
                    br(),
                    uiOutput("radius"),
                    br(),
                    HTML("<h3 id = 'center_hist'><font color = 'green'>Histogram of Cholera Deaths</font></h3>"),
                    plotlyOutput("histo")
      )
  )
)


# Setting up the backend
server <- function(input, output){
  
  cholera_pumps <- readOGR(dsn = "Data", "Combined_Pumps_Cholera_Deaths")
  deaths_df     <- subset(cholera_pumps, cholera_pumps$type == "deaths")
  pumps_df      <- subset(cholera_pumps, cholera_pumps$type == "Pumps")

  pump_yellow <- makeIcon(iconUrl = "Image/icons8-pump-filled-50.png", iconWidth = 25, iconHeight = 25)
  pump_purple <- makeIcon(iconUrl = "Image/pump_purple.png", iconWidth = 25, iconHeight = 25)
  html_pumps  <- "<img src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAALfSURBVGhD7Vi9ixNBHF2/ULw4kz1QEb9QGwuFA7ESK+3EUgQtBTt7/wCxsPIQLMRWxcNCLDzE4sjN7iEYFLSwUIsUchxosski4ge3/n6TmbhJZndnkt2wkXnw2DAzvzfzZubtQhwLCwuL/wNR5GwIGHV12Ky7VJSVD7i4tkcjPZKGKCsfrJGy4eurWQILbOowYOSdKLMoHPD22ghvpsMqNpl7QAwrP9KzYpaNL/U922EDlK/wQYb+zC549m3a+nNnq5AyRx5GAp+chMX4ag19gsZ6m9HXgUcu43dOyOthXCMdRq8EHv0ja+D3D6j7bEowsdY/N30cLTibxDTZGMcI7hzfxXgN7mjsymQRrxjXYuRSnw4Q2m7xiXQwqpHvK7N7u7uvqjPiA9RTG6G/tF84OkaiJWez3EH4/uzDtnClelxVY3q14FTvo57KSFePXMP+TOgYwV2RbfLjmGyEMOw3RaIRRufFkHTkbcQ0I99q7n7USzICenexnwMKTki2PDonmjlyN2LOxIxwxo30d5BANHPkf7USMsLoJ+ivDxKu4m3UMzfikTB+MmXPSIoROaB7MkVkpONXjsavcxpbNXoI9cpnxJwjZqQ3oCgjJITnUBaSOEZG5IBsIxDcVTz+tr/jXK9tOjMyzMwTYeTtYA7SOKGMDDPTiDkfol4JjaRnBOprMOZlj4zeQL3SGZlYRiDAv3EnoPAp9hWZkdYyPQPPs2kMffcY6pmfiDgJiSnLyL87KU9CooCMtOLzZdIkI2mYqoykYfXF7hnlTiWRkXtYl2iEkfeqLCQxMyMevYn9hSG3jDD6CPWST6R6nk9YFNaWdlbwmg1PrpMRughcQILGddRTGmH0Y1R3tvAJiwTk4QgsrBGfHK7LB+CFETg/oPOzs1w5JaYqHk2/ehBy8ya+iPFJGh2velpMMTmIv4uugqEn8vrAaT2DRfHrY8A7UHcR9LYJaQsLCwsLixzgOH8BEMHQqf2DEz8AAAAASUVORK5CYII=', style='width:25px;height:25px;'>Pumps</br>"
  html_purple <- "<img src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAALlSURBVGhD7Vg9iBNBFI5/KCqKjY1/qI2FgiBWIhZaCGrn3u5OAhbCdfZ2acTCykM5b39UUFQMFpLLzF64IohYeShoYaEWqcRGBQvxB+N7ezNhs7d/k+yGjcwHXzOz77353rxvl6SioKCg8H+gV+mtmiWtbVloaYtbeVj5gIdzTNbLyC4PKx+UkLLhfpVtcQz2JSPf8DCFwlGv11ffJq19UbS05m7+WPmR4hUpb1hnmxujXt+RrLW3h5s2c5qt56nkkYcQa4odhWdfhGKlaZv0r22yl8Aqfud4+mwYVYhN2EUo/EfE2Ab9YRvsoywdg34O1EU+bmiNNbxMOkYRgp3DLgZjsKPBkUkjjhjmcnRKgnl8GvSaXygLhhVy6/z8Dux+RIwUQfgDzBcj5FfmF04WIfUTnbWig3aV7cS1OUIPRTwvPVpwWBfzRQrx87FLuJ+KLEKwK/01/nGMEwIHe477sogVYtIZ/kgy8hYi65E7+sIuzBd/I3QW9304pHVE0Catw3zZR+43IslEj+D+gJCBTfqNL/vI/UZiPAJ1P0DsUgSvY75hhHwP3kzpPRIvRHD5ZorwiGUuHAiOcxLtWnsv5iudEFmO4BHBooTA6EZ7IY7DekQwXQh06xNev2t4Z/rrE+qRlUwVwl6HfZDEcXlkJXP2CJzjIeYroZBkj8A35RmM36IgHPQK5ivhaI3NI/T3cjfYU9wr0iOuzk5axDuVRHdq/iDmG0aIfxMCk+WRwEyKmxDIWwh44OtgvWRKeSQJE+WRJNyrtTeFu5RIk9kYF3sjJnsb5YU4pnrEZFdxvzDk5hGDPsJ8cUKA5/yCReGm1tmMYxYunMUj0GUPRqaBhJjLmC9KCOy/t6aX1vkFi8SczvZDwe7AAQz6ziWeJkv8bR7MA2J/OoQe46WKh0tae+AQr4KHyIFdW/eO8xLjA/5d5BA2DaP2pD8+Bm2K8clOdgNGTL97obOBp1ZQUFBQUMgBlco/FAdgHOs4QkEAAAAASUVORK5CYII=', style='width:25px;height:25px;'>Pumps</br>"
  
  output$radius <- renderUI({
    if(input$typemap == "Heatmap"){
      div(id = "placer", sliderInput("size_rad", "Select a Kernel Bandwidth", min = 5, max = 20, value = 10, step = 1))
    }
  })
  
  output$histo <- renderPlotly({
    plot_ly(x = as.numeric(as.character(deaths_df$Count)), type = "histogram") %>% layout(autosize = F, height = 300, width = 300)
  })
  
  output$map <- renderLeaflet({
    leaflet() %>% 
      addProviderTiles(providers$CartoDB.DarkMatterNoLabels, group = "CartoDB-Dark") %>% 
      addProviderTiles(providers$Esri.WorldGrayCanvas, group = "Esri WorldGrey") %>% 
      addProviderTiles(providers$Esri.WorldImagery, group  = "Esri - Satellite") %>% 
      setView(lng = -.137, lat = 51.513, zoom = 16) %>% 
      addLayersControl(baseGroups = c("CartoDB-Dark", "Esri WorldGrey", "Esri - Satellite"), options = layersControlOptions(collapsed = TRUE))
  })

  observe({
    choro <- leafletProxy("map") %>% clearMarkers %>% clearShapes() %>% clearHeatmap() %>% clearControls()
    if(input$typemap == "Proportional Symbols"){
        pal <- colorNumeric(palette = "PuRd", domain = as.numeric(as.character(deaths_df$Count))) # Get the death counts
        choro %>% addCircleMarkers(lng = deaths_df@coords[,1], lat = deaths_df@coords[,2], color = pal(as.numeric(as.character(deaths_df$Count))), 
                                   radius = as.numeric(as.character(deaths_df$Count)), label = htmlEscape(as.character(deaths_df$Count)), fillOpacity = 1) %>%
          addMarkers(lng = pumps_df@coords[,1], lat = pumps_df@coords[,2], icon = pump_yellow) %>%
          addLegend("bottomright", pal = pal, values = as.numeric(as.character(deaths_df$Count)), title = "Cholera Deaths") %>%
          addControl(position = "bottomright", html = html_pumps)
          
    }
    else if(input$typemap == "Heatmap"){
      choro %>% addHeatmap(lng = deaths_df@coords[,1], lat = deaths_df@coords[,2], intensity = as.numeric(as.character(deaths_df$Count)), radius = input$size_rad) %>%
        addMarkers(lng = pumps_df@coords[,1], lat = pumps_df@coords[,2], icon = pump_purple) %>% 
        addControl(position = "bottomright", html = html_purple)
    }
  })
    
}

shinyApp(ui = ui, server = server)