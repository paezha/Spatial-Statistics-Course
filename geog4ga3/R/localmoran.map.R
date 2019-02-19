#' A funcion for creating an interactive map of local Moran's I statistics
#'
#' This function plots a map with the results of local Moran's I statistics, based on spatial polygons, a `listw` object, and a variable with an ID.
#' @param p A SpatialPolygons object
#' @param listw A listw object (see spdep)
#' @param VAR A variable
#' @param by A key to join the variable to the SpatialPolygons object
#' @keywords spatial
#' @export
#' @examples
#' # Create a map of local Moran's I statistics for population density
#' localmoran.map(Hamilton_CT, Hamilton_CT.w, Hamilton_CT$POP_DENSIT, Hamilton_CT$TRACT)

localmoran.map <- function(p = p, listw = listw, VAR = VAR, by = by){
  require(tidyverse)
  require(spdep)
  require(plotly)

  df_msc <- transmute(p,
                      key = p[[by]],
                      Z = (p[[VAR]] - mean(p[[VAR]])) / var(p[[VAR]]),
                      SMA = lag.listw(listw, Z),
                      Type = factor(ifelse(Z < 0 & SMA < 0, "LL",
                                           ifelse(Z > 0 & SMA > 0, "HH", "HL/LH"))))

  local_I <- localmoran(p[[VAR]], listw)

  df_msc <- left_join(df_msc,
                      data.frame(key = p[[by]], local_I))
  df_msc <- rename(df_msc, p.val = Pr.z...0.)

  plot_ly(df_msc) %>%
    add_sf(split = ~(p.val < 0.05), color = ~Type, colors = c("red", "khaki1", "dodgerblue", "dodgerblue4"))
}
