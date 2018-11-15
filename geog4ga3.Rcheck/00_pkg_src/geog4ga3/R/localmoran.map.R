#' A funcion for creating an interactive map of local Moran's I statistics
#'
#' This function obtains the m-surroundings by selecting the m-1 nearest neighbors of each observation, allowing for a degree of overlap of s.
#' @param spat_pol, listw, VAR, ID
#' @keywords autocorrelation
#' @export
#' @examples
#' # Create a map of local Moran's I statistics for population density
#' localmoran.map(Hamilton_CT, Hamilton_CT.w, Hamilton_CT$POP_DENSIT, Hamilton_CT$TRACT)

localmoran.map <- function(spat_pol = spat_pol, listw = listw, VAR = VAR, ID = ID){
  #require(tidyverse)
  #require(broom)
  #require(spdep)
  #require(plotly)

  spat_pol@data <- data.frame(ID = ID, VAR = VAR)
  spat_pol.t <- broom::tidy(spat_pol, region = "ID")
  spat_pol.t <- dplyr::rename(spat_pol.t, ID = id)
  spat_pol.t <- dplyr::left_join(spat_pol.t, spat_pol@data, by = "ID")

  df_msc <- transmute(spat_pol@data,
                      ID = ID,
                      Z = (VAR-mean(VAR)) / var(VAR),
                      SMA = lag.listw(listw, Z),
                      Type = factor(ifelse(Z < 0 & SMA < 0, "LL",
                                           ifelse(Z > 0 & SMA > 0, "HH", "HL/LH"))))

  local_I <- localmoran(spat_pol$VAR, listw)

  spat_pol.t <- left_join(spat_pol.t,
                          data.frame(ID = spat_pol$ID, local_I))
  spat_pol.t <- rename(spat_pol.t, p.val = Pr.z...0.)
  spat_pol.t <- left_join(spat_pol.t,
                          df_msc)

  map <- ggplot(data = spat_pol.t,
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
