---
title: "Activity 6: Point Pattern Analysis III"
output: html_notebook
---

# Activity 6: Point Pattern Analysis III

Remember, you can download the source file for this activity from [here](https://github.com/paezha/Spatial-Statistics-Course).

## Practice questions

Answer the following questions:

1. List and explain two limitations of quadrat analysis.
2. What is clustering? What could explain a clustering in a set of events?
3. What is regularity? What could explain it?
4. Describe the concept of nearest neighbors.
5. What is a cumulative distribution function?

## Learning objectives

In this activity, you will:

1. Explore a dataset using distance-based approaches.
2. Compare the characteristics of different types of patterns.
3. Discuss ways to evaluate how confident you are that a pattern is random.

## Suggested reading

O'Sullivan D and Unwin D (2010) Geographic Information Analysis, 2nd Edition, Chapter 5. John Wiley & Sons: New Jersey.

## Preliminaries

For this activity you will need the following:

* An R markdown notebook version of this document (the source file).

* A package called `geog4ga3`.

It is good practice to clear the working space to make sure that you do not have extraneous items there when you begin your work. The command in R to clear the workspace is `rm` (for "remove"), followed by a list of items to be removed. To clear the workspace from _all_ objects, do the following:

```r
rm(list = ls())
```

Note that `ls()` lists all objects currently on the worspace.

Load the libraries you will use in this activity. In addition to `tidyverse`, you will need `spatstat`, a package designed for the analysis of point patterns (you can learn about `spatstat` [here](https://cran.r-project.org/web/packages/spatstat/vignettes/getstart.pdf) and [here](http://spatstat.org/resources/spatstatJSSpaper.pdf)):

```r
library(tidyverse)
```

```
## -- Attaching packages ---------------------------------------------------------------- tidyverse 1.2.1 --
```

```
## v ggplot2 3.1.0     v purrr   0.2.5
## v tibble  1.4.2     v dplyr   0.7.8
## v tidyr   0.8.2     v stringr 1.3.1
## v readr   1.2.1     v forcats 0.3.0
```

```
## -- Conflicts ------------------------------------------------------------------- tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(spatstat)
```

```
## Loading required package: spatstat.data
```

```
## Loading required package: nlme
```

```
## 
## Attaching package: 'nlme'
```

```
## The following object is masked from 'package:dplyr':
## 
##     collapse
```

```
## Loading required package: rpart
```

```
## 
## spatstat 1.57-1       (nickname: 'Cartoon Physics') 
## For an introduction to spatstat, type 'beginner'
```

```r
library(maptools) # Needed to convert `SpatialPolygons` into `owin` object
```

```
## Loading required package: sp
```

```
## Checking rgeos availability: TRUE
```

```r
library(geog4ga3)
```

In the practice that preceded this activity, you learned about the concepts of intensity and density, about quadrats, and also how to create density maps. For this practice, you will use the data that you first encountered in Activity 4, that is, the business locations in Toronto.

Begin by reading the geospatial files, namely the city boundary of Toronto. You will only need the `SpatialPolygons` object, which will be converted into a `spatstat` window object:

```r
data("Toronto")
```

Convert to an `owin` object:

```r
Toronto.owin <- as(Toronto, "owin") # Requires the package `maptools`
```

Next the data that you will use in this activity needs to be loaded. Each dataframe is converted into a ppp object using the `as.ppp` function:

```r
data("Fast_Food")
Fast_Food.ppp <- as.ppp(Fast_Food, W = Toronto.owin)

data("Gas_Stands")
Gas_Stands.ppp <- as.ppp(Gas_Stands, W = Toronto.owin)

data("Paez_Mart")
Paez_Mart.ppp <- as.ppp(Paez_Mart, W = Toronto.owin)
```

If you inspect your workspace, you will see that the following `ppp` objects are there:

* `Fast_Food.ppp`
* `Gas_Stands.ppp`
* `Paez_Mart.ppp`

These are locations of fast food restaurants and gas stands in Toronto (data are from 2008). Paez Mart on the other hand is my project to cover Toronto with convenience stores. The points are the planned locations of the stores. 

You can check the contents of `ppp` objects by means of `summary`:

```r
summary(Fast_Food.ppp)
```

```
## Marked planar point pattern:  614 points
## Average intensity 8663.712 points per square unit
## 
## Coordinates are given to 6 decimal places
## 
## Multitype:
##           frequency proportion intensity
## Chicken          82  0.1335505  1157.043
## Hamburger       209  0.3403909  2949.048
## Pizza           164  0.2671010  2314.086
## Sub             159  0.2589577  2243.534
## 
## Window: polygonal boundary
## 10 separate polygons (no holes)
##             vertices        area relative.area
## polygon 1       4185 7.05052e-02      9.95e-01
## polygon 2        600 2.82935e-04      3.99e-03
## polygon 3        193 2.64610e-05      3.73e-04
## polygon 4         28 2.96067e-06      4.18e-05
## polygon 5         52 1.59304e-05      2.25e-04
## polygon 6         67 1.76751e-05      2.49e-04
## polygon 7         41 9.31149e-06      1.31e-04
## polygon 8         30 4.78946e-06      6.76e-05
## polygon 9         36 3.77806e-06      5.33e-05
## polygon 10         8 1.23483e-06      1.74e-05
## enclosing rectangle: [-79.6393, -79.11547] x [43.58107, 43.85539] units
## Window area = 0.0708703 square units
## Fraction of frame area: 0.493
```

Now that you have the data that you need in the right format, you are ready for the next activity.

## Activity

1. Calculate the event-to-event distances to nearest neighbors using the function `nndist()`. Do this for all fast food establishments (pooled) and then for each type of establishment (i.e, "Chicken", "Hamburger", "Pizza", "Sub").

2. Create Stienen diagrams using the distance vectors obtained in Step 1. Discuss the diagrams with a fellow student.

3. Plot the empirical G-function for all fast food establishments (pooled) and then for each type of establishment (i.e, "Chicken", "Hamburger", "Pizza", "Sub").

4. Is there evidence of clustering/regularity? 

5. How confident are you to make a decision whether the patterns are not random? What could you do to assess your confidence in making a decision whether the patterns are random? Explain.
