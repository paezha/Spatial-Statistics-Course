---
title: "09 Activity 9: Point Pattern Analysis V"
output: html_notebook
---

# Activity 8: Point Pattern Analysis V

Remember, you can download the source file for this activity from [here](https://github.com/paezha/Spatial-Statistics-Course).

## Practice questions

Answer the following questions:

1. Describe the process to use simulation for hypothesis testing
2. Why is the selection of an appropriate region critical for the analysis of point patterns?
3. Discuss the issues associated with the edges of a region.
4. What is a sampled point pattern?

## Learning objectives

In this activity, you will:

1. Explore a dataset using single scale distance-based techniques.
2. Explore the characteristics of a point pattern at multiple scales.
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
library(geog4ga3)
```

Load a dataset of your choice. It could be one of the datasets that we have used before (Toronto Business Points, Bear GPS Locations), or one of the datasets included with the package `spatstat`. To see what datasets are available through the package, do the following:

```r
vcdExtra::datasets("spatstat.data")
```

```
##                 Item class   dim
## 1             Kovesi  list 41x13
## 2           amacrine   ppp     6
## 3           anemones   ppp     6
## 4               ants   ppp     6
## 5         ants.extra  list     7
## 6           austates  list     4
## 7            bdspots  list     3
## 8                bei   ppp     5
## 9          bei.extra  list     2
## 10         betacells   ppp     6
## 11      bramblecanes   ppp     6
## 12      bronzefilter   ppp     6
## 13             cells   ppp     5
## 14         cetaceans  list   9x4
## 15   cetaceans.extra  list     1
## 16           chicago   ppx     3
## 17           chorley   ppp     6
## 18     chorley.extra  list     2
## 19          clmfires   ppp     6
## 20    clmfires.extra  list     2
## 21            copper  list     7
## 22         demohyper  list   3x3
## 23           demopat   ppp     6
## 24          dendrite   ppx     3
## 25          finpines   ppp     6
## 26               flu  list  41x4
## 27           ganglia   ppp     6
## 28            gordon   ppp     5
## 29          gorillas   ppp     6
## 30    gorillas.extra  list     7
## 31           hamster   ppp     6
## 32           heather  list     3
## 33        humberside   ppp     6
## 34 humberside.convex   ppp     6
## 35          hyytiala   ppp     6
## 36     japanesepines   ppp     5
## 37           lansing   ppp     6
## 38           letterR  owin     5
## 39          longleaf   ppp     6
## 40            mucosa   ppp     6
## 41     mucosa.subwin  owin     4
## 42         murchison  list     3
## 43           nbfires   ppp     6
## 44     nbfires.extra  list     2
## 45          nbw.rect  owin     4
## 46           nbw.seg  list     5
## 47           nztrees   ppp     5
## 48             osteo  list  40x5
## 49           paracou   ppp     6
## 50         ponderosa   ppp     5
## 51   ponderosa.extra  list     2
## 52         pyramidal  list  31x2
## 53           redwood   ppp     5
## 54          redwood3   ppp     5
## 55       redwoodfull   ppp     5
## 56 redwoodfull.extra  list     5
## 57    residualspaper  list     7
## 58           shapley   ppp     6
## 59     shapley.extra  list     3
## 60             simba  list  10x2
## 61            simdat   ppp     5
## 62         simplenet  list    10
## 63           spiders   ppx     3
## 64       sporophores   ppp     6
## 65           spruces   ppp     6
## 66      swedishpines   ppp     5
## 67           urkiola   ppp     6
## 68          vesicles   ppp     5
## 69    vesicles.extra  list     4
## 70              waka   ppp     6
## 71     waterstriders  list     3
##                                                                                        Title
## 1                                          Colour Sequences with Uniform Perceptual Contrast
## 2                                                                 Hughes' Amacrine Cell Data
## 3                                                                      Beadlet Anemones Data
## 4                                                            Harkness-Isham ants' nests data
## 5                                                            Harkness-Isham ants' nests data
## 6                                                 Australian States and Mainland Territories
## 7                                               Breakdown Spots in Microelectronic Materials
## 8                                                                 Tropical rain forest trees
## 9                                                                 Tropical rain forest trees
## 10                                                         Beta Ganglion Cells in Cat Retina
## 11                                                             Hutchings' Bramble Canes data
## 12                                                               Bronze gradient filter data
## 13                                                            Biological Cells Point Pattern
## 14                                            Point patterns of whale and dolphin sightings.
## 15                                            Point patterns of whale and dolphin sightings.
## 16                                                                        Chicago Crime Data
## 17                                                                Chorley-Ribble Cancer Data
## 18                                                                Chorley-Ribble Cancer Data
## 19                                                           Castilla-La Mancha Forest Fires
## 20                                                           Castilla-La Mancha Forest Fires
## 21                                                   Berman-Huntington points and lines data
## 22                                       Demonstration Example of Hyperframe of Spatial Data
## 23                                                             Artificial Data Point Pattern
## 24                                                                     Dendritic Spines Data
## 25                                                                 Pine saplings in Finland.
## 26                                                                  Influenza Virus Proteins
## 27                                            Beta Ganglion Cells in Cat Retina, Old Version
## 28                                                                   People in Gordon Square
## 29                                                                     Gorilla Nesting Sites
## 30                                                                     Gorilla Nesting Sites
## 31                                                              Aherne's hamster tumour data
## 32                                                                     Diggle's Heather Data
## 33                                       Humberside Data on Childhood Leukaemia and Lymphoma
## 34                                       Humberside Data on Childhood Leukaemia and Lymphoma
## 35                                                   Scots pines and other trees at Hyytiala
## 36                                                              Japanese Pines Point Pattern
## 37                                                               Lansing Woods Point Pattern
## 38                                                               Window in Shape of Letter R
## 39                                                              Longleaf Pines Point Pattern
## 40                                                                   Cells in Gastric Mucosa
## 41                                                                   Cells in Gastric Mucosa
## 42                                                                   Murchison gold deposits
## 43                                              Point Patterns of New Brunswick Forest Fires
## 44                                              Point Patterns of New Brunswick Forest Fires
## 45                                              Point Patterns of New Brunswick Forest Fires
## 46                                              Point Patterns of New Brunswick Forest Fires
## 47                                                           New Zealand Trees Point Pattern
## 48                       Osteocyte Lacunae Data: Replicated Three-Dimensional Point Patterns
## 49                                                   Kimboto trees at Paracou, French Guiana
## 50                                                         Ponderosa Pine Tree Point Pattern
## 51                                                         Ponderosa Pine Tree Point Pattern
## 52                                                     Pyramidal Neurons in Cingulate Cortex
## 53                                       California Redwoods Point Pattern (Ripley's Subset)
## 54                                       California Redwoods Point Pattern (Ripley's Subset)
## 55                                        California Redwoods Point Pattern (Entire Dataset)
## 56                                        California Redwoods Point Pattern (Entire Dataset)
## 57                                     Data and Code From JRSS Discussion Paper on Residuals
## 58                                                      Galaxies in the Shapley Supercluster
## 59                                                      Galaxies in the Shapley Supercluster
## 60            Simulated data from a two-group experiment with replication within each group.
## 61                                                                   Simulated Point Pattern
## 62                                                          Simple Example of Linear Network
## 63                                               Spider Webs on Mortar Lines of a Brick Wall
## 64                                                                          Sporophores Data
## 65                                                                     Spruces Point Pattern
## 66                                                               Swedish Pines Point Pattern
## 67                                                               Urkiola Woods Point Pattern
## 68                                                                             Vesicles Data
## 69                                                                             Vesicles Data
## 70                                                               Trees in Waka national park
## 71 Waterstriders data.  Three independent replications of a point pattern formed by insects.
```

Load a dataset of your choice.

You can do this by using the `load()` function if the dataset is in your drive (e.g., the GPS coordinates of the bear).

On the other hand, if the dataset is included with the `spatstat` package you can do the following, for example to load the `gorillas` dataset:

```r
gorillas.ppp <- gorillas
```

As usual, you can check the object by means of the `summary` function:

```r
summary(gorillas.ppp)
```

```
## Marked planar point pattern:  647 points
## Average intensity 3.255566e-05 points per square metre
## 
## *Pattern contains duplicated points*
## 
## Coordinates are given to 2 decimal places
## i.e. rounded to the nearest multiple of 0.01 metres
## 
## Mark variables: group, season, date
## Summary:
##    group       season         date           
##  major:350   dry  :275   Min.   :2006-01-06  
##  minor:297   rainy:372   1st Qu.:2007-03-15  
##                          Median :2008-02-05  
##                          Mean   :2007-12-14  
##                          3rd Qu.:2008-09-23  
##                          Max.   :2009-05-31  
## 
## Window: polygonal boundary
## single connected closed polygon with 21 vertices
## enclosing rectangle: [580457.9, 585934] x [674172.8, 678739.2] metres
## Window area = 19873700 square metres
## Unit of length: 1 metre
## Fraction of frame area: 0.795
```

#Activity

1. Partner with a fellow student to analyze the chosen dataset.

2. Discuss whether the pattern is random, and how confident you are in your decision.

3. The analysis of the pattern is meant to provide insights about the underlying process. Describe a hypothetical process that is consistent with your observations about the pattern. How would you go about further investigating the process?

4. Discuss the limitations of the analysis, for instance, choice of modeling parameters (size of region, kernel bandwidths, edge effects, etc.)
