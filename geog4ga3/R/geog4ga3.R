#' geog4ga3
#'
#' A package with datasets and functions used in the course 4GA3 Applied Spatial Statistics offered by the School of Greography and Earth Sciences at McMaster University.
#'
#' @section Functions
#' The functions are...
#' @author Antonio Paez
#' @name geog4ga3
#' @docType package
#' @import dplyr broom spdep plotly deldir
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
"snow_deaths"

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
"snow_pumps"

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
#'    \item VAR 2. Varible used to create a thematic map (0.3418337--0.4953046)
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
#' }
#' @docType data
#' @keywords datasets
#' @name PointPattern1
#' @format A data frame with 60 rows and 2 variables
#' @source
NULL

#' PointPattern2
#'
#' A dataset containing locations of some generic events.
#'  The variables are as follows:
#'
#' \itemize{
#'    \item x. x points based on a false origin and normalized to the unit-square (0.21511760--0.13941605)
#'    \item y. y points based on a false origin and normalized to the unit-square (0.23998400--0.26875381)
#' }
#'@docType data
#'@keywords datasets
#'@name PointPattern2
#'@format A data frame with 60 rows and 2 variables
#'@source
NULL

#' PointPattern3
#'
#' A dataset containing locations of some generic events.
#'  The variables are as follows:
#'
#' \itemize{
#'    \item x. x points based on a false origin and normalized to the unit-square (0.33453032--0.04994001)
#'    \item y. y points based on a false origin and normalized to the unit-square (0.31238907--0.32612196)
#' }
#' @docType data
#' @keywords datasets
#' @name PointPattern3
#' @format A data frame with 60 rows and 2 variables
#' @source
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
#' @source Dr. Paez
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

#' pp1_df
#' A dataset containing two sets of spatial events labeled as "Pattern 1" and "Pattern 2"
#'  The varirables are as follows:
#'
#'    \itemize{
#'      \item x. list of coordinates (0.22844244--0.95643341)
#'      \item y. list of coordinates (0.81963883--0.07471783)
#'      \item marks. Two sets of spatial events (Pattern 1, Pattern 2)
#' }
#' @docType data
#' @keywords datasets
#' @name pp1_df
#' @format A data frame with 72 rows and 3 variables
#' @ source Dr. Paez
NULL

#' bear_df
#' A dataset containing spatial information from the Scandinavian Bear Project
#'  The variables are as follows:
#'
#'    \itemize{
#'      \item x. list of coordinates (518921.5--517348.2)
#'      \item y. list of coordinates (6812989--6820431)
#'      \item marks. Unique identifier (Day Time, Night Time)
#" }
#' @docType data
#' @keywords datasets
#' @name bear_df
#' @format A data frame with 1000 rows and 3 variables
#' @source \url{https://cran.r-project.org/web/packages/spatstat/vignettes/getstart.pdf) and [here](http://spatstat.org/resources/spatstatJSSpaper.pdf}
NULL

#' pp2_df
#' A dataset containing saptial events
#'  The variables are as follows:
#'
#'    \itemize'
#'      \item x. list of points (0.08081813--0.45127988)
#'      \item y. list of points (0.30816121--0.56114344)
#'}
#' @docType data
#' @keywords datasets
#' @name pp2_df
#' @format A data frame with 81 rows and 2 variables
#' source Dr. Paez
NULL

#' pp3_df
#' A dataset containing saptial events
#'  The variables are as follows:
#'
#'    \itemize'
#'      \item x. list of points (0.1192257--0.7888675)
#'      \item y. list of points (0.1553581--0.8235269)
#'}
#' @docType data
#' @keywords datasets
#' @name pp3_df
#' @format A data frame with 81 rows and 2 variables
#' source Dr. Paez
NULL

#' pp4_df
#' A dataset containing saptial events
#'  The variables are as follows:
#'
#'    \itemize'
#'      \item x. list of points (0.1945629--0.8221292)
#'      \item y. list of points (0.2316941--0.16483732)
#'}
#' @docType data
#' @keywords datasets
#' @name pp5_df
#' @format A data frame with 81 rows and 2 variables
#' source Dr. Paez
NULL

#' pp5_df
#' A dataset containing spatial events
#'  The variables are as follows:
#'
#'    \itemize'
#'      \item x. list of points (0.16--0.88)
#'      \item y. list of points (0.16--0.88)
#'}
#' @docType data
#' @keywords datasets
#' @name pp5_df
#' @format A data frame with 81 rows and 2 variables
#' source Dr. Paez
NULL

#' df1_data6
#' A dataset contianing simulated landscapes, one random, one with a strong systematic pattern
#'  The variables are as follows:
#'
#'    \itemize'
#'      \item x. list of points (7--44)
#'      \item y. list of points (53--6)
#'      \item z. list of points (32.84139--33.28378)
#'}
#' @docType data
#' @keywords datasets
#' @name df1_data6
#' @format A data frame with 350 rows and 3 variables
#' source
NULL

#' df2_data6
#' A dataset contianing simulated landscapes, one random, one with a strong systemic pattern
#'  The variables are as follows:
#'
#'    \itemize'
#'      \item x. list of points (7--
#'      \item y. list of points (53--
#'      \item z. list of points (26.08312--
#'}
#' @docType data
#' @keywords datasets
#' @name df2_data6
#' @format A data frame with 350 rows and 3 variables
#' source
NULL

#' travel_data
#' An excel file with the number of trips by mode of transportation by TAZ, and other useful information from the 2011 census for Hamilton CMA
#'  The variables are as follows:
#'
#'    \itemize'
#'      \item GTA06. identifier used for spatial joins (4050--6020)
#'      \item Cycle. list of Hamiltonians that cycle to work (0--623)
#'      \item Auto_driver. list of Hamiltonians that drive to work (0--17743)
#'      \item Auto_passenger. list of Hamiltonians that get a ride to work (0--4321)
#'      \item Walk. list of Hamiltonians that walk to work (0--1599)
#'      \item Population. population based on a unique spatial polygon (38.88097--12770.552)
#'      \item Worked_in_2010_Full-time. number of Hamiltonians that worked full-time in 2010 (0--5925.9434)
#'      \item Worked_in_2010_Part-time. number of Hamiltonians that worked part-time in 2010 (0--1661.16313)
#'      \item Worked_at_home. number of Hamiltonians that worked from home (0--559.97542)
#'      \item Pop_Density. population denisty based on a unique spatial polygon (26.20745--14232.5677)
#'      \item Median_Age. median age of Hamiltonians based on a unique spatial polygon (3.845238--56.85006)
#'      \item Family_Size_2. size of family based on unique a spatial polygon (7.250167--1489.0255)
#'      \item Family_Size_3. size of family based on unique a spatial polygon (3.237384--859.09030)
#'      \item Family_Size_4. size of family based on unique a spatial polygon (1.619751--1281.18323)
#'      \item Family_Size_5_more. size of family based on a unique spatial polygon (1.617209--387.37487)
#'      \item Median_income. median income based on unique spatial polygon (9.496379--52496.09)
#'      \item Average_income. average income based on unique spatial polygon (11.44593--81235.73)
#'      \item Employment_rate. average employment rate based on a unique spatial polygon (32.74746--76.69758)
#'      \item Unemployment)rate. average unemployment rate based on a unique polygon (0.001258--23.200001)
#'      \item Median_commuting_duration. median commuting duration based on a unique polygon (15.41049--30.59950)
#'}
#' @docType data
#' @keywords excel file
#' @name travel_data
#' @format An excel file with 270 rows and 20 variables
#' source \url{http://www12.statcan.gc.ca/census-recensement/index-eng.cfm}
NULL

#' travel_time
#' An excel file with travel distance/time from TAZ centroids to Jackson Square in downtown Hamilton
#'  The variables are as follows:
#'
#'    \itemize'
#'      \item GTA06. idenitifer used for spatial joins (4050--6020)
#'      \item group. (4050.1--6020.1)
#'      \item from. TAZ centroid address
#'      \item to. Jackson Square, Hamilton, Ontario
#'      \item m. travel distance between origin and Jackson Square in meters (493--37558)
#'      \item km. travel distance between origin and Jackson Square in kilometers (0.493--37.558)
#'      \item miles. travel distance between origin and Jackson Square in miles (0.3063502--23.338541)
#'      \item seconds. travel time between origin and Jackson Square in seconds (115--2100)
#'      \item minutes. travel time between origin and Jackson Square in minutes (1.91667--35.0000)
#'      \item hours. travel time between origin and Jackson Square in hours (0.03194444--0.5833333)
#'}
#' @docType data
#' @keywords excel file
#' @name travel_time
#' @format An excel file with 270 rows and 10 variables
#' source \url{http://www.transportationtomorrow.on.ca/}
NULL



#' Walker_Lake
#' A dataset with geocoded observations of a series of variables originally used for teahcing geostatistics in Isaaks and Srivastava;s [An Introduction to Geostatistics]
#'  The variables are as follows:
#'
#'    \itemize'
#'      \item ID. object ID of variable (1--470)
#'      \item X. false x-coordinates (8--251)
#'      \item Y. false y-coordinates (8--291)
#'      \item V. quantitative variable (0--1528.1)
#'      \item U. quantitative variable (0--5190.1)
#'      \item T. factor variable (1--2)
#'}
#' @docType data
#' @keywords datasets
#' @name Walker_Lake
#' @format A dataset with 470 rows and 6 variables
#' source \url {https://books.google.ca/books?id=vC2dcXFLI3YC&dq=introduction+to+applied+geostatistics+isaaks+and+srivastava&hl=en&sa=X&ved=0ahUKEwiKg6_iyrXZAhUjp1kKHd_jAVcQ6AEIKTAA}
NULL

#' Wolfcamp Aquifer
#' A dataset of piezometric head (watertable pressure) observations of the Wolfcamp Aquifer inn Texas
#'  The variables are as follows:
#'
#'    \itemize'
#'      \item X. x-coordinates (-145.23564--112.80450)
#'      \item Y. y-coordiantes (9.41441--184.76636)
#'      \item H. hydraulic head (1024--3571)
#'}
#' @docType data
#' @keywords datasets
#' @name Wolfcamp Aquifer
#' @format A dataset with 85 rows and 3 variables
#' source \url {https://rubenfcasal.github.io/npsp/reference/aquifer.html}
NULL
