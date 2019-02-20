---
title: "Activity: Spatially Continuous Data I"
output: html_notebook
---

# Activity: Spatially Continuous Data I

## Practice questions

Answer the following questions:

1. What is the difference between spatially continuous data and a spatial point pattern?
2. What is the purpose of spatial interpolation?
3. In your own words describe the method of Inverse Distance Weighting. 
4. Consider the following spatial interpolation algorithms: Voronoi polygons and k-point means. How do they differ when the number of points used to calculate means is 1?


## Learning objectives

In this activity, you will:

1. Explore a dataset with area data using visualization as appropriate.
2. Discuss a process that might explain any pattern observed from the data.
3. Conduct a modeling exercise using appropriate techniques. Justify your modeling decisions.

## Suggested reading

O'Sullivan D and Unwin D (2010) Geographic Information Analysis, 2nd Edition, Chapters 8 and 9. John Wiley & Sons: New Jersey.

## Preliminaries

For this activity you will need the following:

* An R markdown notebook version of this document (the source file).

* A package called `geog4ga3`.

It is good practice to clear the working space to make sure that you do not have extraneous items there when you begin your work. The command in R to clear the workspace is `rm` (for "remove"), followed by a list of items to be removed. To clear the workspace from _all_ objects, do the following:

```r
rm(list = ls())
```

Note that `ls()` lists all objects currently on the worspace.

Load the libraries you will use in this activity (load other packages as appropriate). 

```r
library(tidyverse)
```

```
## -- Attaching packages ----------------------------------------------------------------- tidyverse 1.2.1 --
```

```
## v ggplot2 3.1.0     v purrr   0.2.5
## v tibble  2.0.1     v dplyr   0.7.8
## v tidyr   0.8.2     v stringr 1.3.1
## v readr   1.3.1     v forcats 0.3.0
```

```
## -- Conflicts -------------------------------------------------------------------- tidyverse_conflicts() --
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
## spatstat 1.58-2       (nickname: 'Not Even Wrong') 
## For an introduction to spatstat, type 'beginner'
```

```r
library(spdep)
```

```
## Loading required package: sp
```

```
## Loading required package: Matrix
```

```
## 
## Attaching package: 'Matrix'
```

```
## The following object is masked from 'package:tidyr':
## 
##     expand
```

```
## Loading required package: spData
```

```
## To access larger datasets in this package, install the spDataLarge
## package with: `install.packages('spDataLarge',
## repos='https://nowosad.github.io/drat/', type='source')`
```

```r
library(geog4ga3)
```

Load the data that you will use in this activity:

```r
data("aquifer")
```

The data is a set of piezometric head (watertable pressure) observations of the Wolfcamp Aquifer in Texas (https://en.wikipedia.org/wiki/Hydraulic_head). Measures of pressure can be used to infer the flow of underground water, since water flows from high to low pressure areas.

These data were collected to evaluate potential flow of contamination related to a high level toxic waste repository in Texas. The Deaf Smith county site in Texas was one of three potential sites proposed for this repository. Beneath the site is a deep brine aquifer known as the Wolfcamp aquifer that may serve as a conduit of contamination leaking from the repository.

The data set consists of 85 georeferenced measurements of piezometric head. Possible applications of interpolation are to determine sites at risk and to quantify uncertainty of the interpolated surface, to evaluate the best locations for monitoring stations.

## Activity

1. Map the Wolfcamp Aquifer data.

2. Create a surface using Voronoi polygons.

3. Create a surface using IDW. What is the effect of changing the power of the inverse distance function?

4. Create a surface using k-point means. What is the effect of changing the number of points used in this algorithm?

5. Discuss the limitations of these approaches. How can you calculate the uncertainty in the predictions?
