pkgname <- "geog4ga3"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
base::assign(".ExTimings", "geog4ga3-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('geog4ga3')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("kpointmean")
### * kpointmean

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: kpointmean
### Title: A funcion that implements k-point mean interpolation
### Aliases: kpointmean
### Keywords: spatial

### ** Examples

# Interpolate
target_xy = expand.grid(x = seq(0.5, 259.5, 2.2), y = seq(0.5, 299.5, 2.2))
source_xy = cbind(x = Walker_Lake$X, y = Walker_Lake$Y)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("kpointmean", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("localmoran.map")
### * localmoran.map

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: localmoran.map
### Title: A funcion for creating an interactive map of local Moran's I
###   statistics
### Aliases: localmoran.map
### Keywords: spatial

### ** Examples

# Create a map of local Moran's I statistics for population density
#
# Obtain a listw object for the contiguities. First obtain the neighbors:
Hamilton_CT.nb <- spdep::poly2nb(as(Hamilton_CT, "Spatial"))
# Based on the neighbors, obtain a listw object:
Hamilton_CT.w <- spdep::nb2listw(Hamilton_CT.nb)

localmoran.map(Hamilton_CT, Hamilton_CT.w, "POP_DENSITY", "TRACT")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("localmoran.map", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
