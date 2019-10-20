#' A funcion for converting spatial points to Voronoi polygons
#'
#' This function calculates the Voronoi polygons based on a set of spatial points.
#' @param sp A SpatialPolygons object
#' @keywords spatial
#' @export
#' @return A SpatialPolygonsDataFrame object.
#' @examples
#' # Create a map of local Moran's I statistics for population density
#' xy_coords <- data.frame(x = c(0.7, 5.2, 3.3, 1.3, 5.4), y = c(0.5, 1.8, 2.3, 4.8, 5.5))
#' xy_coords.sp <- SpatialPointsDataFrame(coords = cbind(x = xy_coords$x, y = xy_coords$y), xy_coords)
#' vor <- points2voronoi(xy_coords.sp)
#' plot(vor)

points2voronoi <- function(sp) {

  # tile.list extracts the polygon data from the deldir computation
  vor_desc <- tile.list(deldir(sp@coords[,1], sp@coords[,2]))

  lapply(1:(length(vor_desc)), function(i) {

    # tile.list gets us the points for the polygons but we
    # still have to close them, hence the need for the rbind
    tmp <- cbind(vor_desc[[i]]$x, vor_desc[[i]]$y)
    tmp <- rbind(tmp, tmp[1,])

    # now we can make the Polygon(s)
    Polygons(list(Polygon(tmp)), ID=i)

  }) -> vor_polygons

  # hopefully the caller passed in good metadata!
  sp_dat <- sp@data

  # this way the IDs _should_ match up w/the data & voronoi polys
  rownames(sp_dat) <- sapply(slot(SpatialPolygons(vor_polygons),
                                  'polygons'),
                             slot, 'ID')

  SpatialPolygonsDataFrame(SpatialPolygons(vor_polygons),
                           data=sp_dat)

}
