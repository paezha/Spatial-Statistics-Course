#' A funcion for creating an interactive map of local Moran's I statistics
#'
#' This function plots a map with the results of local Moran's I statistics, based on spatial polygons, a `listw` object, and a variable with an ID.
#' @param sp A SpatialPolygons object
#' @param listw A listw object (see spdep)
#' @param VAR A variable
#' @param by A key to join the variable to the SpatialPolygons object 
#' @keywords spatial
#' @export
#' @examples
#' # Create a map of local Moran's I statistics for population density
#' localmoran.map(Hamilton_CT, Hamilton_CT.w, Hamilton_CT$POP_DENSIT, Hamilton_CT$TRACT)

localmoran.map <- function(sp = sp, listw = listw, VAR = VAR, by = ID){
  #require(tidyverse)
  #require(broom)
  #require(spdep)
  #require(plotly)

  sp@data <- data.frame(by = ID, VAR = VAR)
  sp.t <- broom::tidy(sp, region = "ID")
  sp.t <- dplyr::rename(sp.t, by = id)
  sp.t <- dplyr::left_join(sp.t, sp@data, by = "ID")

  df_msc <- transmute(sp@data,
                      ID = ID,
                      Z = (VAR-mean(VAR)) / var(VAR),
                      SMA = lag.listw(listw, Z),
                      Type = factor(ifelse(Z < 0 & SMA < 0, "LL",
                                           ifelse(Z > 0 & SMA > 0, "HH", "HL/LH"))))

  local_I <- localmoran(sp$VAR, listw)

  sp.t <- left_join(sp.t,
                          data.frame(ID = spat_pol$ID, local_I))
  sp.t <- rename(spat_pol.t, p.val = Pr.z...0.)
  sp.t <- left_join(sp.t,
                          df_msc)

  map <- ggplot(data = sp.t,
                aes(x = long, y = lat, group = group,
                    p.val = p.val, VAR = round(VAR))) +
    geom_polygon(aes(fill = Type, color = p.val < 0.05)) +
    scale_fill_brewer(palette = "RdBu") +
    scale_color_manual(values = c(NA, "Black") ) +
    labs(color = "Prob < 0.05") +
    coord_equal() +
    theme(legend.title = element_blank())
  ggplotly(map, tooltip = c("p.val", "VAR"))
}
