---
title: "08 Point Pattern Analysis I"
output: html_notebook
---

# Point Pattern Analysis I

*NOTE*: You can download the source files for this book from [here](https://github.com/paezha/Spatial-Statistics-Course). The source files are in the format of R Notebooks. Notebooks are pretty neat, because the allow you execute code within the notebook, so that you can work interactively with the notes. 

In last practice your learning objectives were:

1. How to generate random numbers with different properties.
2. About Null Landscapes.
3. How to create new columns in a dataframe using a formula.
4. How to simulate a spatial process.

Please review the previous practices if you need a refresher on these concepts.

If you wish to work interactively with this chapter you will need the following:

* An R markdown notebook version of this document (the source file).

* A package called `geog4ga3`.

## Learning objectives

In this practice, you will learn:

1. A formal definition of point pattern.
2. Processes and point patterns.
3. The concepts of intensity and density.
4. The concept of quadrats and how to create density maps.
5. More ways to control the look of your plots, in particular faceting and adding lines.

## Suggested reading

O'Sullivan D and Unwin D (2010) Geographic Information Analysis, 2nd Edition, Chapter 5. John Wiley & Sons: New Jersey.

## Preliminaries

As usual, it is good practice to clear the working space to make sure that you do not have extraneous items there when you begin your work. The command in R to clear the workspace is `rm` (for "remove"), followed by a list of items to be removed. To clear the workspace from _all_ objects, do the following:

```r
rm(list = ls())
```

Note that `ls()` lists all objects currently on the worspace.

Load the libraries you will use in this activity:

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

Load the data that you will use for this practice:

```r
data("PointPatterns")
```

Quickly check the contents of this dataframe:

```r
summary(PointPatterns)
```

```
##        x                y                 Pattern  
##  Min.   :0.0169   Min.   :0.005306   Pattern 1:60  
##  1st Qu.:0.2731   1st Qu.:0.289020   Pattern 2:60  
##  Median :0.4854   Median :0.550000   Pattern 3:60  
##  Mean   :0.5074   Mean   :0.538733   Pattern 4:60  
##  3rd Qu.:0.7616   3rd Qu.:0.797850                 
##  Max.   :0.9990   Max.   :0.999808
```

The dataframe contains the `x` and `y` coordinates of four different patterns of points, each with $n=60$ events. 

## Point patterns

Previously you created different types of maps and learned about different kinds of processes (i.e., random, stochastic, deterministic). A map that you have seen in several occasions is one where the coordinates of an even of interest are available. The simplest kind of data of this type is when only the coordinates are available: we call this a _point pattern_.

A point pattern is given by a set of events of interest that are observed in a region $R$.

A region has an infinite number of _points_, essentially coordinates $(x_i, y_i)$ on the plane. The number of points is infinite, because there is a point defined by, say, coordinates (1,1), and also a point for coordinates (1.1,1), and for coordinates for (1.01,1), and so on. Any _location_ that can be described by a set of coordinates contained in the region is a point.

Not all points are events, however. An event is defined as a point where something of interest happened. This could be the location where a tree exists, or a crime happened, the epicenter of an earthquake, a case of a disease was reported, and so on. There might be one such occurrence, or more. Each event is be denoted by:
$$
\textbf{s}_i
$$
with coordinates:
$$
(x_i,y_i).
$$
Sometimes other attributes of the events have been measured as well. For example, the event could be an address where cholera was reported (as in John Snow's famous map). In addition to the address (which can be converted into the coordinates of the event), the _number of cases_ could be recorded. Other examples could be the height and diameter of trees, the magnitude of an earthquake, and so on.

It is important, for reasons that will be discussed later, that the point pattern is a complete _enumeration_. What this means is that every event that happened has been recorded! Interpretation of most analysis becomes dubious if the events are only sampled, that is, if only a few of them have been recorded.

## Processes and Point Patterns

Point patterns are interesting in many applications. In these application, a key question of interest is whether the pattern is _random_.

Imagine, for instance, a point pattern that records crimes in a region. The pattern might be random, in which case there is no way to anticipate where the next occurrence will be. Non-random patterns, on the other hand, are likely the outcome of some meaningful process. For instance, crimes might _cluster_ as a consequence of some common environmental variable (e.g., concentration of wealth). On the contrary, they might repeal each other (e.g., the location of a crime draws attention of law enforcement, and therefore the next occurrence of a crime tends to happen away from it). Deciding whether the pattern is random or not is the initial step towards developing hypotheses about the underlying process.

Consider for example the following patterns. To create the following figure, you can use _faceting_ by means of `ggplot2::facet_grid`:

```r
ggplot() + 
  geom_point(data = PointPatterns, aes(x = x, y = y)) + facet_grid(.~ Pattern) +
  coord_fixed()
```

<img src="08-Reading-Point-Pattern-Analysis-I_files/figure-html/unnamed-chunk-5-1.png" width="672" />

As you can see, faceting is a convenient way to simultaneously plot different parts of a dataframe (in the present case, the different `Pattern`s).

In a previous discussion, a few ideas were suggested as possible ways of deciding whether a map of events (i.e., a point pattern) is random. One idea was to consider the _intensity_ of the process. This is discussed in more detail next.

## Intensity and Density

The _intensity_ of a spatial point process is the expected number of events per unit area. This is conventionally denoted by the greek letter $\lambda$.

In most cases the process is not know, so its intensity cannot be directly measured. In its place, the _density_ of the point pattern is taken as the empirical estimate of the _intensity_ of the underlying process. The density of the point pattern is calculated very simply as the number of events divided by the area of the region, that is:
$$
\hat{\lambda} = \frac{(S \in R)}{a} = \frac{n}{a}.
$$
Notice the use of the "hat" symbol on top of the Greek lambda. This symbol is called "caret". The hat notation is used to indicate an estimated value of an unobserved parameter of a process, in the present case the intensity of the spatial point process.

Consider one of the point patterns in your sample dataset, say "Pattern 1". Let's summarize it:

```r
summary(subset(PointPatterns, Pattern == "Pattern 1"))
```

```
##        x                y                 Pattern  
##  Min.   :0.0285   Min.   :0.005306   Pattern 1:60  
##  1st Qu.:0.3344   1st Qu.:0.236509   Pattern 2: 0  
##  Median :0.5247   Median :0.500262   Pattern 3: 0  
##  Mean   :0.5531   Mean   :0.500248   Pattern 4: 0  
##  3rd Qu.:0.8417   3rd Qu.:0.761218                 
##  Max.   :0.9888   Max.   :0.999808
```

We see that there are $n = 60$ points in this dataset. Since the region is the unit square (check how the values of the coordinates range from approximately zero to approximately 1), the area of the region is 1. This means that for "Pattern 1":
$$
\hat{\lambda} = \frac{60}{1} = 60
$$

This is the _overall density_ of the point pattern.

## Quadrats and Density Maps

The overall density of a point process (calculated above) can be mapped by means of the `geom_bin2d` function of the `ggplot2` package. This function divides two dimensional space into bins and reports the number of events or the density of the events in the bins. Let's give this a try:

```r
ggplot() +
  geom_bin2d(data = subset(PointPatterns, Pattern == "Pattern 1"),
             aes(x = x, y = y),
             binwidth = c(1, 1)) +
  coord_fixed()
```

<img src="08-Reading-Point-Pattern-Analysis-I_files/figure-html/unnamed-chunk-7-1.png" width="672" />

Let's see step-by-step how this plot is made. 

1. `ggplot()` creates a plot object.
2. `geom_bin2d` is called to plot a map of counts of events in the space defined by the bins.
3. The dataframe used for plotting the bins is `PointPatterns`, subset so that only the points in "Pattern 1" are used.
4. The coordinates x and y are used to plot (in `aes()`, we indicate that x in the dataframe corresponds to the x axis in the plot, and y in the dataframe corresponds to y axis in the plot)
5. The size of the bin is defined as 1-by-1 (`binwidth = c(1, 1)`)
6. `coord_fixed` is applied to ensure that the aspect ratio of the plot is one (one unit of x is the same length as one unit of y in the plot).

The map of the overall density of the process above is not terribly interesting. It only reports what we already knew, that globally the density of the point pattern is 60. It would be more interesting to see how the density varies across the region. 

We do this by means of the concept of _quadrats_.

Imagine that instead of calculating the overall (or global) intensity of the point pattern, we subdivided the region into a set of smaller subregions. For instance, we could draw horizontal and vertical lines to create smaller squares:

```r
ggplot() + 
  geom_vline(xintercept = seq(from = 0, to = 1, by = 0.25)) +
  geom_hline(yintercept = seq(from = 0, to = 1, by = 0.25)) +
  geom_point(data = subset(PointPatterns, Pattern == "Pattern 1"), 
             aes(x = x, y = y)) +
  coord_fixed()
```

<img src="08-Reading-Point-Pattern-Analysis-I_files/figure-html/unnamed-chunk-8-1.png" width="672" />

Notice the following functions used to create the vertical lines (`geom_vline`) and horizontal lines (`geom_hline`), from 0 to 1 every 0.25 units of distance respectively.

Each of the smaller squares used to subdivide the region is called a _quadrat_.

To make things more interesting, instead of calculating the overall density, we can calculate the density for each quadrat. Let's visualize a density map using quadrats:

```r
ggplot() +
  geom_bin2d(data = subset(PointPatterns, Pattern == "Pattern 1"),
             aes(x = x, y = y),
             binwidth = c(0.50, 0.50)) +
    geom_point(data = subset(PointPatterns, Pattern == "Pattern 1"), 
             aes(x = x, y = y)) +
  scale_fill_distiller(palette = "RdBu") +
  coord_fixed()
```

<img src="08-Reading-Point-Pattern-Analysis-I_files/figure-html/unnamed-chunk-9-1.png" width="672" />

You can, of course, change the size of the quadrats. Let's take a look at the four point patterns (by means of faceting), after creating a variable to easily control the size of the quadrat. Let's call this variable `q_size`:

```r
q_size <- 0.25
ggplot() +
  geom_bin2d(data = PointPatterns,
             aes(x = x, y = y),
             binwidth = c(q_size, q_size)) +
    geom_point(data = PointPatterns, 
             aes(x = x, y = y)) +
  facet_grid(.~ Pattern) +
  scale_fill_distiller(palette = "RdBu") +
  coord_fixed()
```

<img src="08-Reading-Point-Pattern-Analysis-I_files/figure-html/unnamed-chunk-10-1.png" width="672" />

Notice the differences in the density maps? Try changing the size of the quadrat to 1. What happens, and why? Next, try a smaller quadrat size, say 0.25. What happens, and why? Try even smaller quadrat sizes, but greater than zero. What happens now?

The package `spatstat` includes numerous functions for the analysis of point patterns. A relevant function at this point, is `quadratcount`, which returns the number of events per quadrat.

To use this function, we need to convert the point patterns to a type of data used by `spatstat` denominated `ppp` (for *p*lannar *p*oint *p*attern). This is simple, thanks to a utility function in `spatstat` called `as.ppp`. This function takes as arguments (inputs) a set of coordinates, and data to define a window. Let's convert the spatial patterns to `ppp` objects.

First, define the window by means of the `owin` function, and using the 0 to 1 interval for our region:

```r
Wnd <- owin(c(0,1), c(0,1)) 
```

Now, a `ppp` object can be created:

```r
ppp1 <- as.ppp(PointPatterns, Wnd)
```

If you examine these new `ppp` objects, you will see that they pack the same basic information (i.e., the coordinates), but also the range of the region and so on:

```r
summary(ppp1)
```

```
## Marked planar point pattern:  240 points
## Average intensity 240 points per square unit
## 
## Coordinates are given to 8 decimal places
## 
## Multitype:
##           frequency proportion intensity
## Pattern 1        60       0.25        60
## Pattern 2        60       0.25        60
## Pattern 3        60       0.25        60
## Pattern 4        60       0.25        60
## 
## Window: rectangle = [0, 1] x [0, 1] units
## Window area = 1 square unit
```

As you can see, the `ppp` object includes the four patterns, calculates the frequency of each (the number of events), and their respective overall intensities.

Objects of the class `ppp` can be plotted using base plotting functions:

```r
plot(ppp1)
```

<img src="08-Reading-Point-Pattern-Analysis-I_files/figure-html/unnamed-chunk-14-1.png" width="672" />

To plot each pattern separately you can split the different patterns using the function `split.ppp()`. Notice how `$` works for indexing the patterns here:

```r
plot(split.ppp(ppp1)$`Pattern 1`)
```

<img src="08-Reading-Point-Pattern-Analysis-I_files/figure-html/unnamed-chunk-15-1.png" width="672" />

Once the patterns are in `ppp` form, `quadratcount` can be used to compute the counts of events. To calculate the count separately for each pattern, you need to use again `split.ppp()` (if you don't index a pattern, it will apply the function to all of them). The other two arguments are the number of quadrats in the horizontal (nx) and the vertical (ny) directions:  

```r
quadratcount(split(ppp1), nx = 4, ny = 4)
```

```
## List of spatial objects
## 
## Pattern 1:
##             x
## y            [0,0.25) [0.25,0.5) [0.5,0.75) [0.75,1]
##   [0.75,1]          3          5          1        6
##   [0.5,0.75)        2          3          4        6
##   [0.25,0.5)        5          4          2        3
##   [0,0.25)          2          4          4        6
## 
## Pattern 2:
##             x
## y            [0,0.25) [0.25,0.5) [0.5,0.75) [0.75,1]
##   [0.75,1]         14          2          2        6
##   [0.5,0.75)        0          0          4        6
##   [0.25,0.5)        6          3          1        2
##   [0,0.25)          4          6          2        2
## 
## Pattern 3:
##             x
## y            [0,0.25) [0.25,0.5) [0.5,0.75) [0.75,1]
##   [0.75,1]          2         11          5        7
##   [0.5,0.75)        1          1          6        4
##   [0.25,0.5)        1         10          3        2
##   [0,0.25)          2          1          2        2
## 
## Pattern 4:
##             x
## y            [0,0.25) [0.25,0.5) [0.5,0.75) [0.75,1]
##   [0.75,1]          4          5          6        3
##   [0.5,0.75)        3          3          4        2
##   [0.25,0.5)        3          3          4        2
##   [0,0.25)          5          4          6        3
```

Compare the counts of the quadrats for each pattern. They should replicate what you observed in the density plots before.

## Defining the Region for Analysis

It is important when conducting the type of analysis described above (and more generally any analysis with point patterns), to define a region for analysis that is consistent with the pattern of interest. 

Consider for instance what would happen if the region was defined, instead of in the unit square, as a bigger region. Create a second window:

```r
Wnd2 <- owin(c(-1,2), c(-1,2)) 
```

Create a second `ppp` object using this new window:

```r
ppp2 <- as.ppp(PointPatterns, Wnd2)
```

Repeat the plot but using the new `ppp` object: 

```r
plot(split.ppp(ppp2)$`Pattern 1`)
```

<img src="08-Reading-Point-Pattern-Analysis-I_files/figure-html/unnamed-chunk-19-1.png" width="672" />

Repeat but now using an even bigger region. Create a third window:

```r
Wnd3 <- owin(c(-2, 3), c(-2, 3)) 
```

And also a third `ppp` object using the third window:

```r
ppp3 <- as.ppp(PointPatterns, Wnd3)
```

Now the plot looks like this: 

```r
plot(split.ppp(ppp3)$`Pattern 1`)
```

<img src="08-Reading-Point-Pattern-Analysis-I_files/figure-html/unnamed-chunk-22-1.png" width="672" />

Which of the three regions that you saw above is more appropriate? What do you think is the effect of selecting an inappropriate region for the analysis?

This concludes this chapter. The next activity will illustrate how quadrats are a useful tool to explore the question whether a map is random.
