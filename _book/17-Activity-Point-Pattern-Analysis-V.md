---
title: "Activity 8: Point Pattern Analysis V"
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

Note that `ls()` lists all objects currently on the workspace.

Load the libraries you will use in this activity. In addition to `tidyverse`, you will need `spatstat`, a package designed for the analysis of point patterns (you can learn about `spatstat` [here](https://cran.r-project.org/web/packages/spatstat/vignettes/getstart.pdf) and [here](http://spatstat.org/resources/spatstatJSSpaper.pdf)):

```r
library(tidyverse)
library(spatstat)
library(geog4ga3)
```

```
## Warning: replacing previous import 'plotly::filter' by 'stats::filter' when
## loading 'geog4ga3'
```

```
## Warning: replacing previous import 'dplyr::lag' by 'stats::lag' when loading
## 'geog4ga3'
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
## 21          concrete   ppp     5
## 22            copper  list     7
## 23         demohyper  list   3x3
## 24           demopat   ppp     6
## 25          dendrite   ppx     3
## 26          finpines   ppp     6
## 27               flu  list  41x4
## 28           ganglia   ppp     6
## 29            gordon   ppp     5
## 30          gorillas   ppp     6
## 31    gorillas.extra  list     7
## 32           hamster   ppp     6
## 33           heather  list     3
## 34        humberside   ppp     6
## 35 humberside.convex   ppp     6
## 36          hyytiala   ppp     6
## 37     japanesepines   ppp     5
## 38           lansing   ppp     6
## 39           letterR  owin     5
## 40          longleaf   ppp     6
## 41            mucosa   ppp     6
## 42     mucosa.subwin  owin     4
## 43         murchison  list     3
## 44           nbfires   ppp     6
## 45     nbfires.extra  list     2
## 46          nbw.rect  owin     4
## 47           nbw.seg  list     5
## 48           nztrees   ppp     5
## 49             osteo  list  40x5
## 50           paracou   ppp     6
## 51         ponderosa   ppp     5
## 52   ponderosa.extra  list     2
## 53         pyramidal  list  31x2
## 54           redwood   ppp     5
## 55          redwood3   ppp     5
## 56       redwoodfull   ppp     5
## 57 redwoodfull.extra  list     5
## 58    residualspaper  list     7
## 59           shapley   ppp     6
## 60     shapley.extra  list     3
## 61             simba  list  10x2
## 62            simdat   ppp     5
## 63         simplenet  list    10
## 64           spiders   ppx     3
## 65       sporophores   ppp     6
## 66           spruces   ppp     6
## 67      swedishpines   ppp     5
## 68           urkiola   ppp     6
## 69          vesicles   ppp     5
## 70    vesicles.extra  list     4
## 71              waka   ppp     6
## 72     waterstriders  list     3
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
## 21                                                                   Air Bubbles in Concrete
## 22                                                   Berman-Huntington points and lines data
## 23                                       Demonstration Example of Hyperframe of Spatial Data
## 24                                                             Artificial Data Point Pattern
## 25                                                                     Dendritic Spines Data
## 26                                                                 Pine saplings in Finland.
## 27                                                                  Influenza Virus Proteins
## 28                                            Beta Ganglion Cells in Cat Retina, Old Version
## 29                                                                   People in Gordon Square
## 30                                                                     Gorilla Nesting Sites
## 31                                                                     Gorilla Nesting Sites
## 32                                                              Aherne's hamster tumour data
## 33                                                                     Diggle's Heather Data
## 34                                       Humberside Data on Childhood Leukaemia and Lymphoma
## 35                                       Humberside Data on Childhood Leukaemia and Lymphoma
## 36                                                   Scots pines and other trees at Hyytiala
## 37                                                              Japanese Pines Point Pattern
## 38                                                               Lansing Woods Point Pattern
## 39                                                               Window in Shape of Letter R
## 40                                                              Longleaf Pines Point Pattern
## 41                                                                   Cells in Gastric Mucosa
## 42                                                                   Cells in Gastric Mucosa
## 43                                                                   Murchison gold deposits
## 44                                              Point Patterns of New Brunswick Forest Fires
## 45                                              Point Patterns of New Brunswick Forest Fires
## 46                                              Point Patterns of New Brunswick Forest Fires
## 47                                              Point Patterns of New Brunswick Forest Fires
## 48                                                           New Zealand Trees Point Pattern
## 49                       Osteocyte Lacunae Data: Replicated Three-Dimensional Point Patterns
## 50                                                   Kimboto trees at Paracou, French Guiana
## 51                                                         Ponderosa Pine Tree Point Pattern
## 52                                                         Ponderosa Pine Tree Point Pattern
## 53                                                     Pyramidal Neurons in Cingulate Cortex
## 54                                       California Redwoods Point Pattern (Ripley's Subset)
## 55                                       California Redwoods Point Pattern (Ripley's Subset)
## 56                                        California Redwoods Point Pattern (Entire Dataset)
## 57                                        California Redwoods Point Pattern (Entire Dataset)
## 58                                     Data and Code From JRSS Discussion Paper on Residuals
## 59                                                      Galaxies in the Shapley Supercluster
## 60                                                      Galaxies in the Shapley Supercluster
## 61            Simulated data from a two-group experiment with replication within each group.
## 62                                                                   Simulated Point Pattern
## 63                                                          Simple Example of Linear Network
## 64                                               Spider Webs on Mortar Lines of a Brick Wall
## 65                                                                          Sporophores Data
## 66                                                                     Spruces Point Pattern
## 67                                                               Swedish Pines Point Pattern
## 68                                                               Urkiola Woods Point Pattern
## 69                                                                             Vesicles Data
## 70                                                                             Vesicles Data
## 71                                                               Trees in Waka national park
## 72 Waterstriders data.  Three independent replications of a point pattern formed by insects.
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
##     group              season               date           
##  Length:647         Length:647         Min.   :2006-01-06  
##  Class :character   Class :character   1st Qu.:2007-03-15  
##  Mode  :character   Mode  :character   Median :2008-02-05  
##                                        Mean   :2007-12-14  
##                                        3rd Qu.:2008-09-23  
##                                        Max.   :2009-05-31  
## 
## Window: polygonal boundary
## single connected closed polygon with 21 vertices
## enclosing rectangle: [580457.9, 585934] x [674172.8, 678739.2] metres
##                      (5476 x 4566 metres)
## Window area = 19873700 square metres
## Unit of length: 1 metre
## Fraction of frame area: 0.795
```

## Activity

1. Partner with a fellow student to analyze the chosen dataset.

2. Discuss whether the pattern is random, and how confident you are in your decision.

3. The analysis of the pattern is meant to provide insights about the underlying process. Create a hypothesis using the data generated and can you answer that hypothesis using the plots generated?

4. Discuss the limitations of the analysis, for instance, choice of modeling parameters (size of region, kernel bandwidths, edge effects, etc.)
