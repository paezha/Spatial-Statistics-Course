---
title: "12 Area Data III"
output: html_notebook
---

# Area Data III

*NOTE*: You can download the source files for this book from [here](https://github.com/paezha/Spatial-Statistics-Course). The source files are in the format of R Notebooks. Notebooks are pretty neat, because the allow you execute code within the notebook, so that you can work interactively with the notes. 

In preceding chapter and activity, you learned about different ways to define _proximity_ for area data, about spatial weights matrices, and how spatial weights matrices could be used to calculate spatial moving averages. 

If you wish to work interactively with this chapter you will need the following:

* An R markdown notebook version of this document (the source file).

* A package called `geog4ga3`.

## Learning Objectives

In this practice, you will learn about:

1. Spatial moving averages and simulation. 
2. The concept of spatial autocorrelation.
3. Moran's I coefficient and Moran's scatterplot.
4. Hypothesis testing for spatial autocorrelation.

## Suggested Readings

- Bailey TC and Gatrell AC (1995) Interactive Spatial Data Analysis, Chapter 7. Longman: Essex.
- Bivand RS, Pebesma E, and Gomez-Rubio V (2008) Applied Spatial Data Analysis with R, Chapter 9. Springer: New York.
- Brunsdon C and Comber L (2015) An Introduction to R for Spatial Analysis and Mapping, Chapter 7. Sage: Los Angeles.
- O'Sullivan D and Unwin D (2010) Geographic Information Analysis, 2nd Edition, Chapter 7. John Wiley & Sons: New Jersey.

## Preliminaries

As usual, it is good practice to clear the working space to make sure that you do not have extraneous items there when you begin your work. The command in R to clear the workspace is `rm` (for "remove"), followed by a list of items to be removed. To clear the workspace from _all_ objects, do the following:

```r
rm(list = ls())
```

Note that `ls()` lists all objects currently on the worspace.

Load the libraries you will use in this activity:

```r
library(tidyverse)
library(spdep)
library(sf)
library(geog4ga3)
#library(reshape2)
library(gridExtra)
```

Read the data used in this chapter. This is an object of class `sf` (simple feature) with the census tracts of Hamilton CMA and some selected population variables from the 2011 Census of Canada:

```r
data(Hamilton_CT)
```

You can quickly verify the contents of the dataframe by means of `summary`:

```r
summary(Hamilton_CT)
```

```
##        ID               AREA             TRACT             POPULATION   
##  Min.   : 919807   Min.   :  0.3154   Length:188         Min.   :    5  
##  1st Qu.: 927964   1st Qu.:  0.8552   Class :character   1st Qu.: 2639  
##  Median : 948130   Median :  1.4157   Mode  :character   Median : 3595  
##  Mean   : 948710   Mean   :  7.4578                      Mean   : 3835  
##  3rd Qu.: 959722   3rd Qu.:  2.7775                      3rd Qu.: 4692  
##  Max.   :1115750   Max.   :138.4466                      Max.   :11675  
##   POP_DENSITY         AGE_LESS_20      AGE_20_TO_24    AGE_25_TO_29  
##  Min.   :    2.591   Min.   :   0.0   Min.   :  0.0   Min.   :  0.0  
##  1st Qu.: 1438.007   1st Qu.: 528.8   1st Qu.:168.8   1st Qu.:135.0  
##  Median : 2689.737   Median : 750.0   Median :225.0   Median :215.0  
##  Mean   : 2853.078   Mean   : 899.3   Mean   :253.9   Mean   :232.8  
##  3rd Qu.: 3783.889   3rd Qu.:1110.0   3rd Qu.:311.2   3rd Qu.:296.2  
##  Max.   :14234.286   Max.   :3285.0   Max.   :835.0   Max.   :915.0  
##   AGE_30_TO_34     AGE_35_TO_39     AGE_40_TO_44     AGE_45_TO_49  
##  Min.   :   0.0   Min.   :   0.0   Min.   :   0.0   Min.   :  0.0  
##  1st Qu.: 135.0   1st Qu.: 145.0   1st Qu.: 170.0   1st Qu.:203.8  
##  Median : 195.0   Median : 200.0   Median : 230.0   Median :282.5  
##  Mean   : 228.2   Mean   : 239.6   Mean   : 268.7   Mean   :310.6  
##  3rd Qu.: 281.2   3rd Qu.: 280.0   3rd Qu.: 325.0   3rd Qu.:385.0  
##  Max.   :1320.0   Max.   :1200.0   Max.   :1105.0   Max.   :880.0  
##   AGE_50_TO_54    AGE_55_TO_59    AGE_60_TO_64  AGE_65_TO_69  
##  Min.   :  0.0   Min.   :  0.0   Min.   :  0   Min.   :  0.0  
##  1st Qu.:203.8   1st Qu.:175.0   1st Qu.:140   1st Qu.:115.0  
##  Median :280.0   Median :240.0   Median :220   Median :157.5  
##  Mean   :300.3   Mean   :257.7   Mean   :229   Mean   :174.2  
##  3rd Qu.:375.0   3rd Qu.:325.0   3rd Qu.:295   3rd Qu.:221.2  
##  Max.   :740.0   Max.   :625.0   Max.   :540   Max.   :625.0  
##   AGE_70_TO_74    AGE_75_TO_79     AGE_80_TO_84     AGE_MORE_85    
##  Min.   :  0.0   Min.   :  0.00   Min.   :  0.00   Min.   :  0.00  
##  1st Qu.: 90.0   1st Qu.: 68.75   1st Qu.: 50.00   1st Qu.: 35.00  
##  Median :130.0   Median :100.00   Median : 77.50   Median : 70.00  
##  Mean   :139.7   Mean   :118.32   Mean   : 95.05   Mean   : 87.71  
##  3rd Qu.:180.0   3rd Qu.:160.00   3rd Qu.:120.00   3rd Qu.:105.00  
##  Max.   :540.0   Max.   :575.00   Max.   :420.00   Max.   :400.00  
##           geometry  
##  POLYGON      :188  
##  epsg:26917   :  0  
##  +proj=utm ...:  0  
##                     
##                     
## 
```

The `sf` object can be converted into a `SpatialPolygonsDataFrame` object for use with the `spdedp` package:

```r
Hamilton_CT.sp <- as(Hamilton_CT, "Spatial")
```

## Spatial Moving Averages and Simulation

In the preceding chapter and activity you learned about spatial weights matrices as a way to define proximity in the analysis of area data. You also used spatial moving averages to explore spatial patterns in area data.

Let us briefly revisit these notions. Here, you create a spatial weights matrix for Hamilton CMA census tracts:

```r
Hamilton_CT.nb <- poly2nb(pl = Hamilton_CT.sp)
Hamilton_CT.w <- nb2listw(Hamilton_CT.nb)
```

The spatial moving averages are calculated as follows:

```r
POP_DENSITY.sma <- lag.listw(Hamilton_CT.w, Hamilton_CT$POP_DENSITY)
```

Let us append the spatial moving averages to both the `sf` and `SpatialPolygonsDataFrame` objects:

```r
Hamilton_CT$POP_DENSITY.sma <- POP_DENSITY.sma
Hamilton_CT.sp$POP_DENSITY.sma <- POP_DENSITY.sma
```

The spatial moving average can be used in two ways to explore the spatial pattern of an area variable: as a smoother and by means of a scatterplot, combined with the original variable.

## The Spatial Moving Average as a Smoother

First, when mapped, it is essentially a smoothing technique, in that it reduces the amount of variability to make it easier to distinguish the overall pattern.

This can be illustrated with the help of a little simulation.

To simulate a random spatial variable, we can randomize the observations that we already have, reassigning them at random to areas in the system. This is accomplished as follows:

```r
POP_DENSITY_s1 <- sample(Hamilton_CT$POP_DENSITY)
```

Calculate the spatial moving average for this randomized variable:

```r
POP_DENSITY_s1.sma <- lag.listw(Hamilton_CT.w, POP_DENSITY_s1)
```

Once that you have seen how to randomize the variable, simulate a total of eight variables, and calculate their spatial moving averages:

```r
POP_DENSITY_s2 <- sample(Hamilton_CT$POP_DENSITY)
POP_DENSITY_s2.sma <- lag.listw(Hamilton_CT.w, POP_DENSITY_s2)
POP_DENSITY_s3 <- sample(Hamilton_CT$POP_DENSITY)
POP_DENSITY_s3.sma <- lag.listw(Hamilton_CT.w, POP_DENSITY_s3)
POP_DENSITY_s4 <- sample(Hamilton_CT$POP_DENSITY)
POP_DENSITY_s4.sma <- lag.listw(Hamilton_CT.w, POP_DENSITY_s4)
POP_DENSITY_s5 <- sample(Hamilton_CT$POP_DENSITY)
POP_DENSITY_s5.sma <- lag.listw(Hamilton_CT.w, POP_DENSITY_s5)
POP_DENSITY_s6 <- sample(Hamilton_CT$POP_DENSITY)
POP_DENSITY_s6.sma <- lag.listw(Hamilton_CT.w, POP_DENSITY_s6)
POP_DENSITY_s7 <- sample(Hamilton_CT$POP_DENSITY)
POP_DENSITY_s7.sma <- lag.listw(Hamilton_CT.w, POP_DENSITY_s7)
POP_DENSITY_s8 <- sample(Hamilton_CT$POP_DENSITY)
POP_DENSITY_s8.sma <- lag.listw(Hamilton_CT.w, POP_DENSITY_s8)
```

Now, append the spatial moving averages to the dataframes:

```r
Hamilton_CT$POP_DENSITY_s1 <- POP_DENSITY_s1
Hamilton_CT$POP_DENSITY_s2 <- POP_DENSITY_s2
Hamilton_CT$POP_DENSITY_s3 <- POP_DENSITY_s3
Hamilton_CT$POP_DENSITY_s4 <- POP_DENSITY_s4
Hamilton_CT$POP_DENSITY_s5 <- POP_DENSITY_s5
Hamilton_CT$POP_DENSITY_s6 <- POP_DENSITY_s6
Hamilton_CT$POP_DENSITY_s7 <- POP_DENSITY_s7
Hamilton_CT$POP_DENSITY_s8 <- POP_DENSITY_s8

Hamilton_CT$POP_DENSITY_s1.sma <- POP_DENSITY_s1.sma
Hamilton_CT$POP_DENSITY_s2.sma <- POP_DENSITY_s2.sma
Hamilton_CT$POP_DENSITY_s3.sma <- POP_DENSITY_s3.sma
Hamilton_CT$POP_DENSITY_s4.sma <- POP_DENSITY_s4.sma
Hamilton_CT$POP_DENSITY_s5.sma <- POP_DENSITY_s5.sma
Hamilton_CT$POP_DENSITY_s6.sma <- POP_DENSITY_s6.sma
Hamilton_CT$POP_DENSITY_s7.sma <- POP_DENSITY_s7.sma
Hamilton_CT$POP_DENSITY_s8.sma <- POP_DENSITY_s8.sma
```

To create choropleth maps of the empirical variable and the eight simulated variables using `facet_wrap`, we first reorganize the data so that all the spatial moving average variables are in a single column, and there is a new column that identifies which variable they correspond to:

```r
Hamilton_CT2 <- Hamilton_CT %>% select(POP_DENSITY.sma, 
                                       POP_DENSITY_s1.sma,
                                       POP_DENSITY_s2.sma,
                                       POP_DENSITY_s3.sma,
                                       POP_DENSITY_s4.sma,
                                       POP_DENSITY_s5.sma,
                                       POP_DENSITY_s6.sma,
                                       POP_DENSITY_s7.sma,
                                       POP_DENSITY_s8.sma,
                                       geometry) %>% 
  gather(VAR, DENSITY_SMA, -geometry)
```

Now plot:

```r
ggplot() + 
  geom_sf(data = Hamilton_CT2, aes(fill = DENSITY_SMA), color = NA) + 
  facet_wrap(~VAR, ncol = 3) +
  scale_fill_distiller(palette = "YlOrRd", direction = 1) + # Select palette for colors 
  labs(fill = "Pop Den SMA") + # Change the label of the legend
  theme(axis.text.x = element_blank(), axis.text.y = element_blank()) # Remove the axis labels
```

<img src="22-Area-Data-III_files/figure-html/unnamed-chunk-14-1.png" width="672" />

The empirical variable is the map number in the upper left corner. The remaining 8 maps are simulated variables. Would you say the map of the empirical variable is fairly different from the map of the simulated variables? What are the key differences?

Perhaps similar insights could be derived from randomizing the original population density variable, instead of the spatial moving average. An additional advantage of the spatial moving average is its use in the development of scatterplots.

## Spatial Moving Average Scatterplots

Let us explore the use of spatial moving average scatterplots. First, we will extract the density information from the original `sf` object, reorganize, and append to `Hamilton_CT2` so that we can plot using faceting:

```r
Hamilton_CT2$DENSITY <- data.matrix(Hamilton_CT %>% select(POP_DENSITY,
                                               POP_DENSITY_s1,
                                               POP_DENSITY_s2,
                                               POP_DENSITY_s3,
                                               POP_DENSITY_s4,
                                               POP_DENSITY_s5,
                                               POP_DENSITY_s6,
                                               POP_DENSITY_s7,
                                               POP_DENSITY_s8,
                                               geometry) %>% # Extract density variables and geometry
  gather(VAR, DENSITY, -geometry) %>%
  select(DENSITY) %>% # Drop VAR from the object
  st_set_geometry(NULL)) # Drop geometry, turn into dataframe
```

Create the scatterplot of the empirical population density and its spatial moving average, and the scatterplots of the simulated variables and their spatial moving averages  for comparison (the plots include the 45 degree line):

```r
ggplot(data = Hamilton_CT2, aes(x = DENSITY, y = DENSITY_SMA, color = VAR)) +
  geom_point() +
  geom_abline(slope = 1, intercept = 0) +
  coord_equal() +
  facet_wrap(~ VAR, ncol = 3, nrow = 3)
```

<img src="22-Area-Data-III_files/figure-html/unnamed-chunk-16-1.png" width="672" />

What difference do you see between the empirical and simulated variables in these scatterplots?

Fitting a line to the scatterplots (i.e., adding a regression line), makes the difference between the empirical and simulated variables easier to appreciate. This line would take the following form, with $\beta$ as the slope of the line, and $\alpha$ the intercept:
$$
\overline{x_i} =\alpha + \beta x_i
$$

Plot the scatterplots with fitted lines:

```r
ggplot(data = Hamilton_CT2, aes(x = DENSITY, y = DENSITY_SMA, color = VAR)) +
  geom_point(alpha = 0.1) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed") +
  geom_smooth(method = "lm") +
  coord_equal() +
  facet_wrap(~ VAR, ncol = 3, nrow = 3)
```

<img src="22-Area-Data-III_files/figure-html/unnamed-chunk-17-1.png" width="672" />

You will notice that the slope of the line tends to be flat in the simulated variables; this is to be expected, since these variables are spatially random: _the values of the variable at $i$ are independent of the values of their local means!_. In other words, the possibility of a non-random spatial pattern is low.

The empirical variable, on the other hand, has a slope that is much closer to the 45 degree line. This indicates that the values of the variable at $i$ are not independent of their local means: in other words, $x_i$ is correlated with $\overline{x_i}$, and the possibility of a non-random pattern is high. This phenomenon is called _spatial autocorrelation_.

## Spatial Autocorrelation and Moran's $I$ coefficient

As seen above, the spatial moving average can provide evidence of the phenomenon of spatial autocorrelation, that is, when a variable displays spatial patterns whereby values at $i$ are not independent of the values of the variable in their neighborhood.

A convenient modification to the concept of the spatial moving average is as follows. Instead of using the variable $x$ for the calculation of the spatial moving average, we first center it on the global mean:
$$
z_i = x_i - \overline{x}
$$

In this way, the values of $z_i$ are given in _deviations from the mean_. By forcing the variable to be centered on the mean, the slope of the fit line is forced to pass through the origin.

Calculate the mean-centered version of POP_DENSIT, and then its spatial moving average:

```r
df_mean_center_scatterplot <- transmute(Hamilton_CT, 
                                        Density_z = POP_DENSITY - mean(POP_DENSITY), 
                                        SMA_z = lag.listw(Hamilton_CT.w, Density_z))
```

Compare the following two plots. You will see that they are identical, but in the mean-centered one the origin of the axes coincides with the means of $x$ and the spatial moving average:

```r
sc1 <- ggplot(data = subset(Hamilton_CT2, VAR == "POP_DENSITY.sma"),
              aes(x = DENSITY, y = DENSITY_SMA)) +
  geom_point(alpha = 0.1) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed") +
  geom_smooth(method = "lm") +
  ggtitle("Population Density") +
  coord_equal()
sc2 <- ggplot(data = df_mean_center_scatterplot, 
              aes(x = Density_z, y = SMA_z)) +
  geom_point(alpha = 0.1) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed") +
  geom_smooth(method = "lm", formula = y ~ x-1) +
  ggtitle("Mean-Centered Population Density") +
  coord_equal()
grid.arrange(sc1, sc2, ncol = 1)
```

<img src="22-Area-Data-III_files/figure-html/unnamed-chunk-19-1.png" width="672" />

Notice what happens when the variable $z_i$ multiplies its spatial moving average:
$$
z_i\overline{z_i} = z_i\sum_{j=1}^n{w_{ij}^{st}z_j}
$$

When $z_i$ is above its mean, it is a positive value and negative otherwise. Likewise, when $\overline{z_i}$ is above its mean, it is a positive value, and negative otherwise.

There are four posibilities with respect to the combinations of (relatively) high and low values.

1. Quadrant 1 (high & high):

If $z_i$ is above the mean, it is a relatively high value in the distribution (signed positive). If its neighbors are also relatively high values, the spatial moving average will be above the mean, and also signed positive. Their product will be positive (positive times positive equals positive).

2. Quadrant 2 (low & high): 

If $z_i$ is below the mean, it is a relatively low value in the distribution (signed negative). If its neighbors in contrast are relatively high values, the spatial moving average will be above the mean, and signed positive. Their product will be negative (negative times positive equals negative).

3. Quadrant 3 (low & low): 

If $z_i$ is below the mean, it is a relatively low value in the distribution (signed negative). If its neighbors are also relatively low values, the spatial moving average will be below the mean, and also signed negative. Their product will be positive (negative times negative equals positive).

4. Quadrant 4: 

If $z_i$ is above the mean, it is a relatively high value in the distribution (signed positive). If its neighbors are relatively low values, the spatial moving average will be below the mean, and signed negative. Their product will be negative (positive times negative equals negative).

These four quadrants are shown in the following plot:

```r
ggplot(data = df_mean_center_scatterplot, 
       aes(x = Density_z, y = SMA_z)) +
  geom_point(color = "gray") +
  geom_hline(yintercept = 0) +
  geom_vline(xintercept = 0) +
  annotate("text", label = "Q1: Positive", x= 2000, y = 2500) +
  annotate("text", label = "Q4: Negative", x= 2000, y = -2500) +
  annotate("text", label = "Q2: Negative", x= -2000, y = 2500) +
  annotate("text", label = "Q3: Positive", x= -2000, y = -2500) +
  coord_equal()
```

<img src="22-Area-Data-III_files/figure-html/unnamed-chunk-20-1.png" width="672" />

Let us say that we add all such products:
$$
\sum_{i=1}^n{z_i\overline{z_i}} = \sum_{i=1}^n{z_i\sum_{j=1}^n{w_{ij}^{st}z_j}}
$$

The more such products are positive, meaning more dots in Quadrants 1 and 3 in the scatterplot, the larger (and positive) the total sum will be. Likewise, as more such products are negative, meaning more dots in Quadrants 2 and 4, the larger (but negative!) the total sum will be. 

Either case would be indicative of a pattern. 

If the sum is positive, this would suggest that high & high values tend to be together, while low & low values also tend to be together.

In contrast, if the sum is negative, this would suggest that high values tend to be surrounded by low values, and viceversa.

## Moran's $I$ and Moran's Scatterplot

Based on the discussion above, let us define the following coefficient, called _Moran's I_:
$$
I = \frac{\sum_{i=1}^n{z_i\sum_{j=1}^n{w_{ij}^{st}z_j}}}{\sum_{i=1}^{n}{z_i^2}}
$$

The numerator in this expression is the sum of the products described above. The denominator is the variance of variable $x_i$, and is used here to scale Moran's $I$ so that it is contained roughly in the interval $(-1, 1)$ (the exact bounds depend on the characteristics of the zoning system).

Moran's $I$ is a coefficient of _spatial autocorrelation_.

We can calculate Moran's $I$ as follows (notice how it is the sum of the products of $z$ by its spatial moving average, divided by the variance):

```r
sum(df_mean_center_scatterplot$Density_z * df_mean_center_scatterplot$SMA_z) / sum(df_mean_center_scatterplot$Density_z^2)
```

```
## [1] 0.5179736
```

Since the value is positive, and relatively high, this would suggest a non-random spatial pattern of similar values (i.e., high & high and low & low).

Moran's $I$ is implemented in R in the `spdep` package, which makes its calculation easy, since you do not have to go manually through the process of calculating the spatial moving averages, etc.

The function `moran` requires as input arguments a variable, a set of spatial weights, the number of zones ($n$), and the total sum of all weights (termed $S_0$) - which in the case of row-standardized spatial weights is equal to the number of zones. Therefore:

```r
mc <- moran(Hamilton_CT$POP_DENSITY, Hamilton_CT.w, n = 188, S0 =  188)
mc$I
```

```
## [1] 0.5179736
```

You can verify that this matches the value calculated above. The kind of scatterplots that we used previously (called _Moran's scatterplots_) can also be created easily by means of the `moran.plot` function:

```r
mp <- moran.plot(Hamilton_CT$POP_DENSITY, Hamilton_CT.w)
```

<img src="22-Area-Data-III_files/figure-html/unnamed-chunk-23-1.png" width="672" />

## Hypothesis Testing for Spatial Autocorrelation

As usual, we need some criterion to decide whether the pattern is random.

Moran's $I$ can be used to develop a test of hypothesis. The expected value of Moran's $I$ under the null hypothesis of spatial independence and its variance have been derived.

A test for autocorrelation based on Moran's $I$ is implemented in the `spdep` package:

```r
moran.test(Hamilton_CT$POP_DENSITY, Hamilton_CT.w)
```

```
## 
## 	Moran I test under randomisation
## 
## data:  Hamilton_CT$POP_DENSITY  
## weights: Hamilton_CT.w    
## 
## Moran I statistic standard deviate = 12.722, p-value < 2.2e-16
## alternative hypothesis: greater
## sample estimates:
## Moran I statistic       Expectation          Variance 
##       0.517973553      -0.005347594       0.001691977
```

The null hypothesis is of spatial independence. The $p$-value is interpreted as the probability of making a mistake by rejecting the null hypothesis. In the present case, the $p$-value is such a small number that we can reject the null hypothesis with a high degree of confidence.

Moran's $I$ and Moran's scatterplots are amongst the most widely used tools in the analysis of spatial area data.
