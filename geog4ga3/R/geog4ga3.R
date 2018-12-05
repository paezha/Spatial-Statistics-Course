#' geog4ga3
#'
#' A package with datasets and functions used in the course 4GA3 Applied Spatial Statistics offered by the School of Greography and Earth Sciences at McMaster University.
#'
#' @author Antonio Paez [cre, aut], \email{paezha@@mcmaster.ca}, Anastassios Dardas [ctb], Raj Ubhi [ctb]
#' @name geog4ga3
#' @docType package
#' @import dplyr spdep plotly deldir tidyverse spatstat rgdal
NULL

#' Snow cholera deaths
#'
#' A dataset containing the location and number of cholera deaths in Soho, London.
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
#' A dataset containing the location of pumps in Soho, London.
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
#'    \item hole. (FALSE)
#'    \item price. (1--10)
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
#' @usage data(HamiltonDAs)
#' @format A data frame with 11792 rows and 12 variables
#' @source \url{https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2011-eng.cfm}
"HamiltonDAs"

#' PointPattern1
#'
#' A dataset containing locations of some generic events.
#'  The variables are as follows:
#'
#' \itemize{
#'    \item x. x points based on a false origin and normalized to the unit-square for a generic variable like events as cases of flu, the location of trees of a certain species, or the location of fires (0.02849997--0.98884730)
#'    \item y. y points based on a false origin and normalized to the unit-square for a generic variable like events as cases of flu, the location of trees of a certain species, or the location of fires (0.005306043--0.999807645)
#' }
#'
#' @docType data
#' @keywords datasets
#' @name PointPattern1
#' @usage data(PointPattern1)
#' @format A data frame with 60 rows and 2 variables
#' @source Extracted from Data2.RData file
"PointPattern1"

#' PointPattern2
#'
#' A dataset containing locations of some generic events.
#'  The variables are as follows:
#'
#' \itemize{
#'    \item x. x points based on a false origin and normalized to the unit-square for a generic variable like events as cases of flu, the location of trees of a certain species, or the location of fires (0.01689682--0.99900765)
#'    \item y. y points based on a false origin and normalized to the unit-square for a generic variable like events as cases of flu, the location of trees of a certain species, or the location of fires (0.02932253--0.98867308)
#' }
#'
#' @docType data
#' @keywords datasets
#' @name PointPattern2
#' @usage data(PointPattern2)
#' @format A data frame with 60 rows and 2 variables
#' @source Extracted from Data2.RData file
"PointPattern2"

#' PointPattern3
#'
#' A dataset containing locations of some generic events.
#'  The variables are as follows:
#'
#' \itemize{
#'    \item x. x points based on a false origin and normalized to the unit-square for a generic variable like events as cases of flu, the location of trees of a certain species, or the location of fires (0.04911492--0.98371039)
#'    \item y. y points based on a false origin and normalized to the unit-square for a generic variable like events as cases of flu, the location of trees of a certain species, or the location of fires (0.01036480--0.99283927)
#' }
#'
#' @docType data
#' @keywords datasets
#' @name PointPattern3
#' @usage data(PointPattern3)
#' @format A data frame with 60 rows and 2 variables
#' @source Extracted from Data2.RData file
"PointPattern3"

#' Fast_Food
#'
#' A dataset containing locations of fast food restaruants in Toronto (data is from 2008).
#'  The variables are as follows:
#'
#' \itemize{
#'    \item x. list of x coordinates for fast food restaruants in Toronto (\-79.13459--\-79.61018)
#'    \item y. list of y coordinates for fast food restaruants in Toronto (43.83077--43.59277)
#'    \item Class. Four types of food offered at fast food restaurants in Toronto (Chicken, Hamburger, Pizza, Sub)
#' }
#'
#' @docType data
#' @keywords datasets
#' @name Fast_Food
#' @usage data(Fast_Food)
#' @format A data frame with 614 rows and 3 variables
#' @source Extracted from Toronto Business Points.RData
"Fast_Food"

#' Gas_Stands
#'
#' A dataset containing locations of gas stands in Toronto (data is from 2008).
#'  The variables are as follows:
#'
#' \itemize{
#'    \item x. list of x coordinates for gas stands in Toronto (\-79.14029--\-79.61831)
#'    \item y. list of y coordinates for gas stands in Toronto (43.83122--43.59499)
#' }
#'
#' @docType data
#' @keywords datasets
#' @name Gas_Stands
#' @usage data(Gas_Stands)
#' @format A data frame with 345 rows ad 2 variables
#' @source Extracted from Toronto Business Points.RData
"Gas_Stands"

#' Paez_Mart
#'
#' A dataset containing planned locations of convenience stores in Toronto.
#'  The variables are as follows:
#'
#'  \itemize{
#'    \item x. list of x coordinates for a project to cover Toronto with convenience stores (\-79.54108--\-79.17440)
#'    \item y. list of y coordinates for a project to cover Toronto with convenience stores (43.58793--43.84853)
#' }
#'
#' @docType data
#' @keywords datasets
#' @name Paez_Mart
#' @usage data(Paez_Mart)
#' @format A data frame with 395 rows and 3 variables
#' @source Data frame developed by Dr. Paez in 2008
"Paez_Mart"

#' Toronto
#'
#' A SpatialPolygons object that contains the city boundary of Toronto.
#'
#' @docType data
#' @keywords datasets
#' @name Toronto
#' @usage data(Toronto)
#' @format A data frame with 5250 rows and 7 variables
#' @source \url{https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2011-eng.cfm}
"Toronto"

#' Toronto_df
#'
#' A dataframe that contains the city boundary of Toronto.
#'
#'  \itemize{
#'    \item lat. longitude of address (\-79.63930--\-79.37075)
#'    \item long. latitude of address (43.74985--43.62359)
#'    \item order. Unique idenifier of address
#'    \item hole. (FALSE)
#'    \item piece. (1--10)
#'    \item group. (5299933.1-5299933.10)
#'    \item GTA06. (5299933)
#'}
#'
#' @docType data
#' @keywords datasets
#' @name Toronto_df
#' @usage data(Toronto_df)
#' @format A data frame with 5250 rows and 7 variables
#' @source \url{https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2011-eng.cfm}
"Toronto_df"

#' pp1_df
#'
#' A dataset that includes a `spatstat` `ppp`-class object with two sets of spatial events, labeled as "Pattern 1" and "Pattern 2".
#'  The varirables are as follows:
#'
#'  \itemize{
#'    \item x. list of x-coordinates used to plot two sets of spatial events (0.04559819--0.95643341)
#'    \item y. list of y-coordinates used to plot two sets of spatial events (0.03408578--0.94492099)
#'    \item marks. Two sets of spatial events (Pattern 1, Pattern 2)
#' }
#'
#' @docType data
#' @keywords datasets
#' @name pp1_df
#' @usage data(pp1_df)
#' @format A data frame with 72 rows and 3 variables
#' @source Extracted from Data4.RData
"pp1_df"

#' bear_df
#'
#' A dataset containing spatial information from the Scandinavian Bear Project which is a Swedish-Noruegian collaboration that aims to study the ecology of brown bears, to provide decision makers with evidence to support bear management, and to provide information regarding bears to the public.
#'  The variables are as follows:
#'
#'  \itemize{
#'    \item x. list of x-coordinates used to plot location of bears during the day and night (515743.2--522999.4)
#'    \item y. list of y-coordinates used to plot location of bears during the day and night (6812138--6821440)
#'    \item marks. Unique identifier of bear movement at different times (Day Time, Night Time)
#' }
#'
#' @docType data
#' @keywords datasets
#' @name bear_df
#' @usage data(bear_df)
#' @format A data frame with 1000 rows and 3 variables
#' @source \url{(http://bearproject.info/about-the-project/)}
"bear_df"

#' pp2_df
#'
#' A dataset containing `spatstat` `ppp`-class objects used to represent spatial events.
#'  The variables are as follows:
#'
#'  \itemize{
#'    \item x. list of x-coordinates (0.01321246--0.96299812)
#'    \item y. list of y-coordinates (0.02570673--0.84147945)
#'}
#'
#' @docType data
#' @keywords datasets
#' @name pp2_df
#' @usage data(pp2_df)
#' @format A data frame with 81 rows and 2 variables
#' @source Extracted from Data5.RData
"pp2_df"

#' pp3_df
#'
#' A dataset containing `spatstat` `ppp`-class objects used to represent spatial events.
#'  The variables are as follows:
#'
#'  \itemize{
#'    \item x. list of x-coordinates (0.1035079--0.8741389)
#'    \item y. list of y-coordinates (0.1015268--0.8725456)
#'}
#'
#' @docType data
#' @keywords datasets
#' @name pp3_df
#' @usage data(pp3_df)
#' @format A data frame with 81 rows and 2 variables
#' @source Extracted from Data5.RData
"pp3_df"

#' pp4_df
#'
#' A dataset containing `spatstat` `ppp`-class objects used to represent spatial events.
#'  The variables are as follows:
#'
#'  \itemize{
#'    \item x. list of x-coordinates (0.1945629--0.9624404)
#'    \item y. list of y-coordinates (0.02639242--0.88419944)
#'}
#'
#' @docType data
#' @keywords datasets
#' @name pp4_df
#' @usage data(pp4_df)
#' @format A data frame with 81 rows and 2 variables
#' @source Extracted from Data5.RData
"pp4_df"

#' pp5_df
#'
#' A dataset containing `spatstat` `ppp`-class objects used to represent spatial events.
#'  The variables are as follows:
#'
#'  \itemize{
#'    \item x. list of x-coordinates (0.16--0.88)
#'    \item y. list of y-coordinates (0.16--0.88)
#'}
#'
#' @docType data
#' @keywords datasets
#' @name pp5_df
#' @usage data(pp5_df)
#' @format A data frame with 81 rows and 2 variables
#' @source Extracted from Data5.RData
"pp5_df"

#' missing_df
#'
#' A dataframe containing a set of observations, including some missing variables.
#'  The variables are as follows:
#'
#' \itemize{
#'    \item x. x points based on a false origin and normalized to the unit-square  (0.01698944--0.95718825)
#'    \item y. y points based on a false origin and normalized to the unit-square  (0.01003585--0.98715473)
#'    \item VAR1. Genric variable - think of it as housing prices or concentrations in ppb of some contaminant (50.00000--1050.00000)
#'    \item VAR2. Genric variable - think of it as housing prices or concentrations in ppb of some contaminant (50.00000--1050.00000)
#'    \item VAR3. Genric variable - think of it as housing prices or concentrations in ppb of some contaminant (50.00000--1050.00000)
#'    \item Observed. factor variable states whether the variables were measured for a location: if the status is "FALSE", the values of the variables are missing (TRUE--FALSE)
#' }
#'
#' @docType data
#' @keywords datasets
#' @name missing_df
#' @usage data(missing_df)
#' @format A data frame with 65 rows and 6 variables
#' @source Dr. Paez
"missing_df"

#' PointPatterns
#'
#' A dataset which includess a dataframe with four sets of spatial events, labeled as "Pattern 1", "Pattern 2", "Pattern 3", "PointPattern4", with n = 60 events in each set.
#'  The variables are as follows:
#'
#' \itemize{
#'    \item x. x coordinates used to plot spatial event (0.01689682--0.99900765)
#'    \item y. y coordinates used to plot spatial event (0.005306043--0.999807645)
#'    \item Pattern. Four sets of spatial events (Pattern 1, Pattern 2, Pattern 3 and Pattern 4)
#' }
#'
#' @docType data
#' @keywords datasets
#' @name PointPatterns
#' @usage data(PointPatterns)
#' @format A data frame with 140 rows and 3 variables
#' @source Dr. Paez
"PointPatterns"

#' df1_simulated
#'
#' A dataframe with a simulated landscape.
#'
#'  \itemize{
#'    \item x. list of x-coordinates (1--87)
#'    \item y. list of y-coordinates (1--61)
#'    \item z. list of z-coordinates (24.39618--69.58580)
#'}
#'
#' @docType data
#' @keywords datasets
#' @name df1_simulated
#' @usage data(df1_simulated)
#' @format A data frame with 350 rows and 3 variables
#' @source Extracted from Data6.RData
"df1_simulated"

#' df2_simulated
#'
#' A dataframe containing a simulated landscape.
#'
#'  \itemize{
#'    \item x. list of x-coordinates (1--87)
#'    \item y. list of y-coordinates (1--61)
#'    \item z. list of z-coordinates (24.39618--69.58580)
#'}
#'
#' @docType data
#' @keywords datasets
#' @name df2_simulated
#' @usage data(df2_simulated)
#' @format A data frame with 350 rows and 3 variables
#' @source Extracted from Data6.RData
"df2_simulated"

#' trips_by_mode
#'
#' An excel file with the number of trips by mode of transportation by Traffic Analysis Zone (TAZ), and other useful information from the 2011 census for the Hamilton, CMA, Canada.
#'
#'  \itemize{
#'    \item GTA06. identifier used for spatial joins (4050--6020)
#'    \item Cycle. list of Hamiltonians that cycle to work (0--623)
#'    \item Auto_driver. list of Hamiltonians that drive to work (0--17743)
#'    \item Auto_passenger. list of Hamiltonians that get a ride to work (0--4321)
#'    \item Walk. list of Hamiltonians that walk to work (0--1599)
#'    \item Population. population based on a unique spatial polygon (38.88097--12770.552)
#'    \item Worked_in_2010_Full-time. number of Hamiltonians that worked full-time in 2010 (0--5925.9434)
#'    \item Worked_in_2010_Part-time. number of Hamiltonians that worked part-time in 2010 (0--1661.16313)
#'    \item Worked_at_home. number of Hamiltonians that worked from home (0--559.97542)
#'    \item Pop_Density. population denisty based on a unique spatial polygon (26.20745--14232.5677)
#'    \item Median_Age. median age of Hamiltonians based on a unique spatial polygon (3.845238--56.85006)
#'    \item Family_Size_2. size of family based on unique a spatial polygon (7.250167--1489.0255)
#'    \item Family_Size_3. size of family based on unique a spatial polygon (3.237384--859.09030)
#'    \item Family_Size_4. size of family based on unique a spatial polygon (1.619751--1281.18323)
#'    \item Family_Size_5_more. size of family based on a unique spatial polygon (1.617209--387.37487)
#'    \item Median_income. median income based on unique spatial polygon (9.496379--52496.09)
#'    \item Average_income. average income based on unique spatial polygon (11.44593--81235.73)
#'    \item Employment_rate. average employment rate based on a unique spatial polygon (32.74746--76.69758)
#'    \item Unemployment)rate. average unemployment rate based on a unique polygon (0.001258--23.200001)
#'    \item Median_commuting_duration. median commuting duration based on a unique polygon (15.41049--30.59950)
#'}
#'
#' @docType data
#' @keywords datasets
#' @name trips_by_mode
#' @usage data(trips_by_mode)
#' @format An excel file with 270 rows and 20 variables
#' @source \url{http://www12.statcan.gc.ca/census-recensement/index-eng.cfm}
"trips_by_mode"

#' "travel_time_car"
#'
#' A dataframe with travel distance/time from TAZ centroids to Jackson Square in downtown Hamilton, Canada.
#'
#'  \itemize{
#'    \item GTA06. idenitifer used for spatial joins (4050--6020)
#'    \item group. (4050.1--6020.1)
#'    \item from. TAZ centroid address
#'    \item to. Jackson Square, Hamilton, Ontario
#'    \item m. travel distance between origin and Jackson Square in meters (493--37558)
#'    \item km. travel distance between origin and Jackson Square in kilometers (0.493--37.558)
#'    \item miles. travel distance between origin and Jackson Square in miles (0.3063502--23.338541)
#'    \item seconds. travel time between origin and Jackson Square in seconds (115--2100)
#'    \item minutes. travel time between origin and Jackson Square in minutes (1.91667--35.0000)
#'    \item hours. travel time between origin and Jackson Square in hours (0.03194444--0.5833333)
#'}
#'
#' @docType data
#' @keywords datasets
#' @name travel_time_car
#' @usage data(travel_time_car)
#' @format An excel file with 270 rows and 10 variables
#' @source \url{http://www.transportationtomorrow.on.ca/}
"travel_time_car"

#' Walker_Lake
#'
#' A dataset with geocoded observations of a series of variables originally used for teahcing geostatistics in Isaaks and Srivastava's [An Introduction to Geostatistics].
#'  The variables are as follows:
#'
#'  \itemize{
#'    \item ID. object ID of variable (1--470)
#'    \item X. false x-coordinates (8--251)
#'    \item Y. false y-coordinates (8--291)
#'    \item V. quantitative variable (0--1528.1)
#'    \item U. quantitative variable (0--5190.1)
#'    \item T. factor variable (1--2)
#'}
#'
#' @docType data
#' @keywords datasets
#' @name Walker_Lake
#' @usage data(Walker_Lake)
#' @format A dataset with 470 rows and 6 variables
#' @source \url{https://books.google.ca/books?id=vC2dcXFLI3YC&dq=introduction+to+applied+geostatistics+isaaks+and+srivastava&hl=en&sa=X&ved=0ahUKEwiKg6_iyrXZAhUjp1kKHd_jAVcQ6AEIKTAA}
"Walker_Lake"

#' aquifer
#'
#' A dataset of piezometric head (watertable pressure) observations of the Wolfcamp Aquifer in Texas. This dataset was used by Isaaks and Srivastavas in their book An Introduction to Applied Geostatistics.
#'
#'  \itemize{
#'    \item X. x-coordinates (\-145.23564\--112.80450)
#'    \item Y. y-coordiantes (9.41441--184.76636)
#'    \item H. Hydraulic head at the Woldcamp Aquifer in Texas (1024--3571)
#'}
#'
#' @docType data
#' @keywords datasets
#' @name aquifer
#' @usage data(aquifer)
#' @format A dataset with 85 rows and 3 variables
#' @source \url{https://rubenfcasal.github.io/npsp/reference/aquifer.html}
"aquifer"

#' nyleukemia
#'
#' A spatial polygon data frame of New York leukemia data projected in UTM Zone 18 using WGS84.
#'  The variables are as follows:
#'
#'  \itemize{
#'    \item AREANAME. name of study area (Auburn city--Vestal town)
#'    \item AREAKEY. unique identifier of study area (36007000100--36109992300)
#'    \item X. x-coordinates of spatial polygons (-55.482300--53.508600)
#'    \item Y. y-coordinates of spatial polygons (-75.290700--56.410130)
#'    \item POP8. (9--13015)
#'    \item TRACTCAS. (0.00--9.29)
#'    \item PROPCAS. (0.000000--0.006993)
#'    \item PCTOWNHOME. (0.00082237--1.0000000)
#'    \item PCTAGE65. (0.00404412--0.5050505)
#'    \item Z. (-1.92062--4.71053)
#'    \item AVGDIST. (0.0184667--3.5263750)
#'    \item PEXPOSURE. (0.613384--5.865441)
#'    \item Cases. number of leukemia cases in New York based on studya area (0.00014--9.286010)
#'    \item Xm. (-55482.300--53508.600)
#'    \item Ym. (-75290.700--56410.130)
#'    \item Xshift. (363839.3--472830.2)
#'    \item Yshift. (4653564--4785265)
#'}
#'
#' @docType data
#' @keywords spatialpolygondataframe
#' @name nyleukemia
#' @usage data(nyleukemia)
#' @format A spatial polygon data frame with 281 rows and 17 variables
#' @source \url{https://www.rdocumentation.org/packages/SpatialEpi/versions/1.2.3/topics/NYleukemia}
"nyleukemia"

#' pennlc
#'
#' A spatial polygon data frame of Pennsylvania lung cancer projected using latitude and longitude.
#'
#'  \itemize{
#'    \item county. name of each county in Pennsylvania with recorded lung cancer patients within this spatial polygon data frame (adams--york)
#'    \item cases. number of cases in each county with lung cancer (3--1415)
#'    \item population. population of each county in Pennsylvania (4946--1517550)
#'    \item rate. (2.629157--13.391363)
#'    \item smoking. (0.182--0.279)
#'    \item cancer_rate. rate of patients diagnosed with lung cancer in each county of Pennsylvania (2.629157--13.391363)
#'    \item smoking_rate. smoking rate per county in Pennsylvania (18.2--27.9)
#'}
#'
#' @docType data
#' @keywords spatialpolygondataframe
#' @name pennlc
#' @usage data(pennlc)
#' @format A spatial polygon data frame with 67 rows and 7 variables
#' @source \url{https://www.rdocumentation.org/packages/RgoogleMaps/versions/1.4.2/topics/pennLC}
"pennlc"
