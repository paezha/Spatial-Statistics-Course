#' geog4ga3.
#'
#' @name geog4ga3
#' @docType package
#' @import dplyr broom spdep plotly tidyverse spatstat ggplot2
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

#' HamiltonDAs
#'
#' A dataset containing Hamilton Dissemination Areas.  
#'  The variables are as follows: 
#'
#' \itemize{
#'    \item long. longitude of address (-\-79.86997--\-79.51301)
#'    \item lat. latitude of adress (43.29277--43.18924)
#'    \item order. Unique identifier of address 
#'    \item hole. 
#'    \item price. 
#'    \item group. 
#'    \item GTA06. 
#'    \item VAR 1. Varible used to create a thematic map (0.3788377--0.3482670)
#'    \iteam VAR 2. Varible used to create a thematic map (0.3418337--0.4953046)
#'    \item VAR 3. Varible used to create a thematic map (0.3450731--0.2735642)
#'    \item VAR 4. Varible used to create a thematic map (0.3057122--0.4634048)
#'    \item VAR 5. Varible used to create a thematic map (0.3622016--0.4760264)
#' }
#'
#' @docType data 
#' @keywords datasets 
#' @name HamiltonDAs 
#' @usage data(HameilonDAs)
#' @format A data frame with 11792 rows and 12 variables 
#' @source \url{https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2011-eng.cfm}
NULL

#' Data1
#'
#' A dataset contianing point data.  
#'  The variables are as follows: 
#' 
#' \itemize{
#'    \item x. x points based on a false origin and normalized to the unit-square  (0.87289164--0.88000000)
#'    \item y. y points based on a false origin and normalized to the unit-square  (0.13177294--0.85000000)
#'    \item VAR1. Variable assocaited with location used to adjust plot (388.55666--NA)
#'    \item VAR2. Variable associated with location used to adjust plot (571.07806--NA)
#'    \item VAR3. Variable assocaited with location used to adjust plot (634.7831--NA)
#'  Feel free to think of each variable if they were housing prices or concentrations in ppb of some contaminant. 
#'    \item observed. Variable states whether it was measured at that location (TRUE--FALSE) 
#' }
#'
#' @docType data 
#' @keywords datasets 
#' @name Data1
#' @usage data(Data1)
#' @format A data frame with 65 rows and 6 variables 
#' @source 
NULL 

#PointPattern1,2,3 are part of Data2.RData in the RMarkdown file

#' PointPattern1
#' 
#' A dataset containing locations of some generic events. 
#'  The variables are as follows: 
#'
#' \itemize{ 
#'    \item x. x points based on a false origin and normalized to the unit-square (0.94197211--0.37310555)
#'    \item y. y points based on a false origin and normalized to the unit-square (0.797437939--0.626555892)
#'  Feel free to think of these events as cases of flu, the location of trees of a certain species, or the location of fires. 
#' }
#' @docType data
#' @keywords datasets
#' @name PointPattern1
#' @format A data frame with 60 rows and 2 variables 
#' @source NA
NULL

#' PointPattern2
#' 
#' A dataset containing locations of some generic events. 
#'  The variables are as follows: 
#'
#' \itemize{ 
#'    \item x. x points based on a false origin and normalized to the unit-square (0.21511760--0.13941605)
#'    \item y. y points based on a false origin and normalized to the unit-square (0.23998400--0.26875381)
#'  Feel free to think of these events as cases of flu, the location of trees of a certain species, or the location of fires. 
#' }
#'@docType data
#'@keywords datasets
#'@name PointPattern2
#'@format A data frame with 60 rows and 2 variables 
#'@source NA
NULL

#' PointPattern3
#' 
#' A dataset containing locations of some generic events. 
#'  The variables are as follows: 
#'
#' \itemize{ 
#'    \item x. x points based on a false origin and normalized to the unit-square (0.33453032--0.04994001)
#'    \item y. y points based on a false origin and normalized to the unit-square (0.31238907--0.32612196)
#'  Feel free to think of these events as cases of flu, the location of trees of a certain species, or the location of fires. 
#' }
#' @docType data
#' @keywords datasets
#' @name PointPattern3
#' @format A data frame with 60 rows and 2 variables 
#' @source NA
NULL

#'Data3
#'
#'A dataset containing four sets of spatial events labeled "Pattern1", "Pattern2", "Pattern3" and "Pattern4" 
#'  The variables are as follows: 
#'
#' \itemize{
#'    \item x. x points (0.94197211--0.90000000)
#'    \item y. y points (0.797437939--0.95000000)
#'    \item Pattern. Four sets of spatial events (Pattern1, Pattern2, Pattern3 and Pattern4) 
#' }
#' @docType data
#' @keywords datasets
#' @name Data3
#' @format A data frame with 140 rows and 3 variables 
#' @source 
NULL

#' Fast_Food
#' A dataset containing locations of fast food restaruants in Toronto (data is from 2008). 
#'  The variables are as follows: 
#'
#' \itemize{
#'    \item x. list of x coordinates (\-79.31405--\-79.38232)
#'    \item y. list of y coordinates (43.82118--43.67041)
#'    \item class. Four sets of food offered at restaurants(Chicken, Hamburger, Pizza, Sub)
#' }
#' @docType data
#' @keywords datasets
#' @name Fast_Food
#' @format A data frame with 614 rows and 3 variables 
#' @source 
NULL

#' Gas_Stands
#' A dataset containing locations of gas stands in Toronto (data is from 2008) 
#' The variables are as follows: 
#'
#' \itemize{
#'    \item x. list of x coordinates (\-79.57759--\-79.56854)
#'    \item y. list of y coordinates (43.76148--43.62758)
#' }
#' @docType data
#' @keywords datasets
#' @name Gas_Stands
#' @format A data frame with 345 rows ad 2 variables 
#' @source 
NULL

#' Paez_Mart
#' A dataset containing planned locations of convenience stores in Toronto 
#'  The variables are as follows: 
#'
#'  \itemize{
#'    \item x. list of x coordinates (\-79.54108--\-79.17440)
#'    \item y. list of y coordinates (43.58793--43.84853)
#' }
#' @docType data
#' @keywords datasets
#' @name Paez_Mart
#' @format A data frame with 395 rows and 3 variables 
#' @source Dr. Paez's project 
NULL

#' Toronto
#' A dataset containing the city boundary of Toronto 
#'  The variables are as follows: 
#'
#'  \itemize{
#'    \item lat. longitude of address (\-79.63930--\-79.37075)
#'    \item long. latitude of address (43.74985--43.62359)
#'    \item order. Unique idenifier of address 
#'    \item hole.
#'    \item price. 
#'    \item group. 
#'    \item GTA06. 
#'}
#' @docType data
#' @keywords datasets
#' @name Toronto
#' @format A data frame with 5250 rows and 7 variables 
#' @source \url{https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2011-eng.cfm}
NULL

#' pp1 
#' A dataset 
