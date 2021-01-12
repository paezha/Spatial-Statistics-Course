#' A funcion for creating an interactive map of local Moran's I statistics
#'
#' This function plots a map with the results of local Moran's I statistics, based on spatial polygons, a `listw` object, and a variable with an ID.
#' @param p A simple features `sf` object
#' @param listw A listw object (see spdep)
#' @param VAR The name of a variable
#' @param by The name of a key to join the local Moran's I statistics to the `sf` object
#' @keywords spatial
#' @export
#' @import dplyr
#' @examples
#' # Create a map of local Moran's I statistics for population density
#' #
#' # Obtain a listw object for the contiguities. First obtain the neighbors:
#' Hamilton_CT.nb <- spdep::poly2nb(as(Hamilton_CT, "Spatial"))
#' # Based on the neighbors, obtain a listw object:
#' Hamilton_CT.w <- spdep::nb2listw(Hamilton_CT.nb)
#'
#' localmoran.map(Hamilton_CT, Hamilton_CT.w, "POP_DENSITY", "TRACT")

localmoran.map <- function(p = p, listw = listw, VAR = VAR, by = by){
  #require(tidyverse)
  #require(spdep)
  #require(plotly)

  Z <- SMA <- Pr.z...0. <- NULL

  df_msc <- transmute(p,
                      key = p[[by]],
                      Z = (p[[VAR]] - mean(p[[VAR]])) / var(p[[VAR]]),
                      SMA = lag.listw(listw, Z),
                      Type = factor(ifelse(Z < 0 & SMA < 0, "LL",
                                           ifelse(Z > 0 & SMA > 0, "HH", "HL/LH"))))

  local_I <- localmoran(p[[VAR]], listw)

  df_msc <- dplyr::left_join(df_msc,
                      data.frame(key = p[[by]], local_I))
  df_msc <- rename(df_msc, p.val = Pr.z...0.)

  plot_ly(df_msc) %>%
    add_sf(split = ~(p.val < 0.05), color = ~Type, colors = c("red", "khaki1", "dodgerblue", "dodgerblue4"))
}
