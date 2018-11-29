#' A funcion that implements k-point mean interpolation
#'
#' This function calculates the spatial mean based on the k-nearest neighbors of a focal point or set of focal points.
#' @param source_xy
#' @param target_xy
#' @param k
#' @param longlat
#' @keywords spatial
#' @export
#' @return A SpatialPolygonsDataFrame object.
#' @examples
#' # Interpolate
#' target_xy = expand.grid(x = seq(0.5, 259.5, 2.2), y = seq(0.5, 299.5, 2.2))
#' source_xy = cbind(x = Walker_Lake$X, y = Walker_Lake$Y)

kpointmean <- function(source_xy, z, target_xy, k, longlat = FALSE){
  for(i in 1:nrow(target_xy)){
    x = rbind(source_xy, target_xy[i,1:2])
    knn <- knearneigh(x = as.matrix(x), k = k, longlat = longlat)
    target_xy$z[i] <- mean(z[knn$nn[nrow(x),]])
    target_xy$sd[i] <- sd(z[knn$nn[nrow(x),]])
  }
  target_xy
}
