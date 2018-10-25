#' geog4ga3.
#'
#' @name geog4ga3
#' @docType package
#' @import dplyr broom spdep plotly
NULL

#' Snow cholera deaths
#'
#' A dataset containing the location and number of cholera deaths.
#'  The variables are as follows:
#'
#' \itemize{
#'   \item long. longitude of address (\-0.1401--\-0.1329)
#'   \item lat. latitude of address (51.51--51.52)
#'   \item Id. Unique identifier of address
#'   \item Count. Number of deaths recorded at address (1--15)
#' }
#'
#' @docType data
#' @keywords datasets
#' @name snow_deaths
#' @usage data(snow_deaths)
#' @format A data frame with 250 rows and 5 variables
#' @source \url{http://blog.rtwilson.com/?s=snow}
NULL

#' Snow cholera pumps
#'
#' A dataset containing the location of pumps if Soho.
#'  The variables are as follows:
#'
#' \itemize{
#'   \item long. longitude of address (\-0.1401--\-0.1329)
#'   \item lat. latitude of address (51.51--51.52)
#'   \item Id. Unique identifier of address
#'   \item Count. Number of pumps at location
#' }
#'
#' @docType data
#' @keywords datasets
#' @name snow_pumps
#' @usage data(snow_pumps)
#' @format A data frame with 5 rows and 4 variables
#' @source \url{http://blog.rtwilson.com/?s=snow}
NULL
