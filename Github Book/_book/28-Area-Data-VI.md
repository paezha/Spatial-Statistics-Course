---
title: "15 Area Data VI"
output: html_notebook
---

# Area Data VI

*NOTE*: You can download the source files for this book from [here](https://github.com/paezha/Spatial-Statistics-Course). The source files are in the format of R Notebooks. Notebooks are pretty neat, because the allow you execute code within the notebook, so that you can work interactively with the notes. 

In the previous chapter, you learned about how to use local spatial statistics for exploratory spatial data analysis. 

If you wish to work interactively with this chapter you will need the following:

* An R markdown notebook version of this document (the source file).

* A package called `geog4ga3`.

NOTE: This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code. 

In previous practice/session, you learned about how to use local spatial statistics for exploratory spatial data analysis. 

For this practice you will need the following:

* This R markdown notebook.
* A shape file called "Hamilton CMA tts06"

The shape file includes spatial information for Traffic Analysis Zones (TAZ) in the Hamilton Census Metropolitan Area (as polygons).

## Learning Objectives

In this practice, you will:

1. Revisit the notion of autocorrelation as a model diagnostic.
2. Remedial action.
3. Flexible functional forms and models with spatially-varying coefficients.
   3.1 Trend surface analysis.
   3.2 The expansion method.
   3.3 Geographically weighted regression (GWR).
4. Spatial error model (SEM).

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
library(sf)
```

```
## Linking to GEOS 3.6.1, GDAL 2.2.3, PROJ 4.9.3
```

```r
#library(broom)
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
#library(reshape2)
library(plotly)
```

```
## 
## Attaching package: 'plotly'
```

```
## The following object is masked from 'package:ggplot2':
## 
##     last_plot
```

```
## The following object is masked from 'package:stats':
## 
##     filter
```

```
## The following object is masked from 'package:graphics':
## 
##     layout
```

```r
library(knitr)
library(kableExtra)
library(spgwr)
```

```
## NOTE: This package does not constitute approval of GWR
## as a method of spatial analysis; see example(gwr)
```

```r
library(geog4ga3)
```

Begin by loading the data needed for this chapter:

```r
data("HamiltonDAs")
```

The file is of the Dissemination Areas in the Hamilton CMA, in Canada.

## Residual spatial autocorrelation revisited

Previously you learned about the use of Moran's I coefficient as a diagnostic in regression analysis.

Residual spatial autocorrelation is a symptom of a model that has not been properly specified. There are two reasons for this that are of interest:

1) The functional form is incorrect.
2) The model failed to include relevant variables.

Lets explore these in turn.

### Incorrect Functional Form

To illustrate this, we will simulate a spatial process as follows:
$$
z = f(x,y) = exp(\beta_0)exp(\beta_1x)exp(\beta_2y) + \epsilon_i
$$

Clearly, this is a non-linear spatial process.

The simulation is as follows, with a random term with a mean of zero and standard deviation of 1. **The random terms are independent by design**:

```r
set.seed(10)
b0 = 1
b1 = 2
b2 = 4
xy_coords <- st_coordinates(st_centroid(HamiltonDAs))
```

```
## Warning in st_centroid.sf(HamiltonDAs): st_centroid assumes attributes are
## constant over geometries of x
```

```r
HamiltonDAs <- mutate(HamiltonDAs,
                            x = (xy_coords[,1] - min(xy_coords[,1]))/100000,
                            y = (xy_coords[,2] - min(xy_coords[,2]))/100000,
                            z = exp(b0) * exp(b1 * x) * exp(b2 * y) +
                              rnorm(n = 297, mean = 0, sd = 1))
```

This is the summary of the simulated variables:

```r
summary(HamiltonDAs[, 8:10])
```

```
##        x                y                z                   geometry  
##  Min.   :0.0000   Min.   :0.0000   Min.   : 3.919   MULTIPOLYGON :297  
##  1st Qu.:0.2284   1st Qu.:0.1354   1st Qu.: 7.842   epsg:26917   :  0  
##  Median :0.2695   Median :0.1712   Median : 9.370   +proj=utm ...:  0  
##  Mean   :0.2724   Mean   :0.1863   Mean   :10.370                      
##  3rd Qu.:0.3127   3rd Qu.:0.2195   3rd Qu.:11.710                      
##  Max.   :0.5312   Max.   :0.4079   Max.   :22.809
```

Suppose that we estimate the model as a linear regression that does not correctly capture the non-linearity. The model would be as follows:

```r
model1 <- lm(formula = z ~ x + y, data = HamiltonDAs) 
summary(model1)
```

```
## 
## Call:
## lm(formula = z ~ x + y, data = HamiltonDAs)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -2.7267 -0.8591  0.0028  0.8250  3.5826 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  -3.6765     0.3255  -11.29   <2e-16 ***
## x            20.9207     0.8586   24.37   <2e-16 ***
## y            44.8033     0.9305   48.15   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.231 on 294 degrees of freedom
## Multiple R-squared:  0.8965,	Adjusted R-squared:  0.8958 
## F-statistic:  1273 on 2 and 294 DF,  p-value: < 2.2e-16
```

At first glance, the model gives the impression of a very good fit: all coefficients are significant, and the coefficient of multiple determination $R^2$ is moderately high.

At this point, it is important to examine the residuals to verify that they are independent. Lets add the residuals of this model to your dataframes:

```r
HamiltonDAs$model1.e <- model1$residuals
```

A map of the residuals can help examine their spatial pattern:

```r
  plot_ly(HamiltonDAs) %>%
    add_sf(color = ~(model1.e > 0), colors = c("red", "dodgerblue4"))
```

<!--html_preserve--><div id="htmlwidget-26dc660ce6a3eebfb88b" style="width:672px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-26dc660ce6a3eebfb88b">{"x":{"visdat":{"25045a7b34b7":["function () ","plotlyVisDat"],"2504165c5f6":["function () ","data"]},"cur_data":"2504165c5f6","attrs":{"2504165c5f6":{"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"x":{},"y":{},"_bbox":[560916.611536223,4767184.04219115,621054.054190107,4814333.99341374],"mode":"lines","fill":"toself","color":{},"colors":["red","dodgerblue4"],"inherit":true}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"xaxis":{"showgrid":false,"zeroline":false,"ticks":"","showticklabels":false,"domain":[0,1],"automargin":true,"scaleanchor":"y","scaleratio":-0.514771718507519},"yaxis":{"showgrid":false,"zeroline":false,"ticks":"","showticklabels":false,"domain":[0,1],"automargin":true},"hovermode":"closest","showlegend":true},"source":"A","config":{"cloud":false},"data":[{"fillcolor":"rgba(255,0,0,0.5)","x":{},"y":{},"_bbox":[560916.611536223,4767184.04219115,621054.054190107,4814333.99341374],"mode":"lines","fill":"toself","type":"scatter","name":"FALSE","marker":{"color":"rgba(255,0,0,1)","line":{"color":"rgba(255,0,0,1)"}},"textfont":{"color":"rgba(255,0,0,1)"},"error_y":{"color":"rgba(255,0,0,1)"},"error_x":{"color":"rgba(255,0,0,1)"},"line":{"color":"rgba(255,0,0,1)"},"xaxis":"x","yaxis":"y","frame":null},{"fillcolor":"rgba(16,78,139,0.5)","x":{},"y":{},"_bbox":[560916.611536223,4767184.04219115,621054.054190107,4814333.99341374],"mode":"lines","fill":"toself","type":"scatter","name":"TRUE","marker":{"color":"rgba(16,78,139,1)","line":{"color":"rgba(16,78,139,1)"}},"textfont":{"color":"rgba(16,78,139,1)"},"error_y":{"color":"rgba(16,78,139,1)"},"error_x":{"color":"rgba(16,78,139,1)"},"line":{"color":"rgba(16,78,139,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

To test the residuals for spatial autocorrelation we first create a set of spatial weights:

```r
HamiltonDAs.w <- nb2listw(poly2nb(as(HamiltonDAs, "Spatial")))
```

With this, we can now calculate Moran's $I$:

```r
moran.test(HamiltonDAs$model1.e, HamiltonDAs.w)
```

```
## 
## 	Moran I test under randomisation
## 
## data:  HamiltonDAs$model1.e  
## weights: HamiltonDAs.w    
## 
## Moran I statistic standard deviate = 10.373, p-value < 2.2e-16
## alternative hypothesis: greater
## sample estimates:
## Moran I statistic       Expectation          Variance 
##       0.350300067      -0.003378378       0.001162633
```

The test does not allow us to reject the null hypothesis of spatial independence. Thus, despite the apparent goodness of fit of the model, there is reason to believe something is missing.

Lets now use a variable transformation to approximate the underlying non-linear process:

```r
model2 <- lm(formula = log(z) ~ x + y, data = HamiltonDAs)
summary(model2)
```

```
## 
## Call:
## lm(formula = log(z) ~ x + y, data = HamiltonDAs)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.32033 -0.06456  0.00671  0.07647  0.31233 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  0.96853    0.02864   33.81   <2e-16 ***
## x            2.08863    0.07554   27.65   <2e-16 ***
## y            3.97537    0.08187   48.56   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.1083 on 294 degrees of freedom
## Multiple R-squared:  0.9016,	Adjusted R-squared:  0.901 
## F-statistic:  1348 on 2 and 294 DF,  p-value: < 2.2e-16
```

This model does not necessarily have a better goodness of fit. However, when we test for spatial autocorrelation:

```r
HamiltonDAs$model2.e <- model2$residuals
moran.test(HamiltonDAs$model2.e, HamiltonDAs.w)
```

```
## 
## 	Moran I test under randomisation
## 
## data:  HamiltonDAs$model2.e  
## weights: HamiltonDAs.w    
## 
## Moran I statistic standard deviate = 0.59638, p-value = 0.2755
## alternative hypothesis: greater
## sample estimates:
## Moran I statistic       Expectation          Variance 
##       0.016946454      -0.003378378       0.001161482
```

Once that the correct functional form has been specified, the model is better at capturing the underlying process (check how the coefficients approximate to a high degree the true coefficients of the model). In addition, we can conclude that the residuals are independent, and therefore are now also spatially random: meaning the there is nothing left of the process but white noise.

### Omitted Variables

Using the same example, suppose now that the functional form of the model is correctly specified, but a relevant variable is missing:

```r
model3 <- lm(formula = log(z) ~ x, data = HamiltonDAs)
summary(model3)
```

```
## 
## Call:
## lm(formula = log(z) ~ x, data = HamiltonDAs)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.78563 -0.19306 -0.05461  0.14453  0.91857 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  1.90764    0.06334  30.118  < 2e-16 ***
## x            1.36012    0.22197   6.127 2.85e-09 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.3246 on 295 degrees of freedom
## Multiple R-squared:  0.1129,	Adjusted R-squared:  0.1099 
## F-statistic: 37.54 on 1 and 295 DF,  p-value: 2.853e-09
```

As before, lets append the residuals to the dataframes:

```r
HamiltonDAs$model3.e <- model3$residuals
```

We can plot a map of the residuals to examine their spatial pattern:

```r
  plot_ly(HamiltonDAs) %>%
    add_sf(color = ~(model3.e > 0), colors = c("red", "dodgerblue4"))
```

<!--html_preserve--><div id="htmlwidget-434ec92e8ca6a0d25397" style="width:672px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-434ec92e8ca6a0d25397">{"x":{"visdat":{"250436805cf3":["function () ","plotlyVisDat"],"25047e12513b":["function () ","data"]},"cur_data":"25047e12513b","attrs":{"25047e12513b":{"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"x":{},"y":{},"_bbox":[560916.611536223,4767184.04219115,621054.054190107,4814333.99341374],"mode":"lines","fill":"toself","color":{},"colors":["red","dodgerblue4"],"inherit":true}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"xaxis":{"showgrid":false,"zeroline":false,"ticks":"","showticklabels":false,"domain":[0,1],"automargin":true,"scaleanchor":"y","scaleratio":-0.514771718507519},"yaxis":{"showgrid":false,"zeroline":false,"ticks":"","showticklabels":false,"domain":[0,1],"automargin":true},"hovermode":"closest","showlegend":true},"source":"A","config":{"cloud":false},"data":[{"fillcolor":"rgba(255,0,0,0.5)","x":{},"y":{},"_bbox":[560916.611536223,4767184.04219115,621054.054190107,4814333.99341374],"mode":"lines","fill":"toself","type":"scatter","name":"FALSE","marker":{"color":"rgba(255,0,0,1)","line":{"color":"rgba(255,0,0,1)"}},"textfont":{"color":"rgba(255,0,0,1)"},"error_y":{"color":"rgba(255,0,0,1)"},"error_x":{"color":"rgba(255,0,0,1)"},"line":{"color":"rgba(255,0,0,1)"},"xaxis":"x","yaxis":"y","frame":null},{"fillcolor":"rgba(16,78,139,0.5)","x":{},"y":{},"_bbox":[560916.611536223,4767184.04219115,621054.054190107,4814333.99341374],"mode":"lines","fill":"toself","type":"scatter","name":"TRUE","marker":{"color":"rgba(16,78,139,1)","line":{"color":"rgba(16,78,139,1)"}},"textfont":{"color":"rgba(16,78,139,1)"},"error_y":{"color":"rgba(16,78,139,1)"},"error_x":{"color":"rgba(16,78,139,1)"},"line":{"color":"rgba(16,78,139,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

In this case, the visual inspection makes it clear that there is an issue with spatially autocorrelated residuals, something that a test reinforces:

```r
moran.test(HamiltonDAs$model3.e, HamiltonDAs.w)
```

```
## 
## 	Moran I test under randomisation
## 
## data:  HamiltonDAs$model3.e  
## weights: HamiltonDAs.w    
## 
## Moran I statistic standard deviate = 24.921, p-value < 2.2e-16
## alternative hypothesis: greater
## sample estimates:
## Moran I statistic       Expectation          Variance 
##       0.846098172      -0.003378378       0.001161895
```

As seen above, the model with the full set of relevant variables resolves this problem.

## Remedial Action

When spatial autocorrelation is detected in the residuals, further work is warranted. The preceding examples illustrate two possible solutions to the issue of residual pattern: 

1. Modifications of the model to approximate the true functional form of the process; and
2. Inclusion of relevant variables.

Ideally, we would try to ensure that the model is properly specified. In practice, however, it is not always evident what the functional form of the model should be. The search for an appropriate functional form can be guided by theoretical considerations, empirical findings, and experimentation. With respect to inclusion of relevant variables, it is not always possible to find all the information we desire. This could be because of limited resources, or because some aspects of the process are not known and therefore we do not even know what additional information should be collected.

In these cases, it is a fact that residual spatial autocorrelation is problematic.

Fortunately, a number of approaches have been proposed in the literature that can be used for remedial action.

In the following sections we will review some of them.

## Flexible Functional Forms and Models with Spatially-varying Coefficients

Some models use variable transformations to create more flexible functions, while others use adaptive estimation strategies.

### Trend Surface Analysis

Trend surface analysis is a simple way to generate relatively flexible surfaces.

This approach consists of using the coordinates as covariates, and transforming them into polynomials of different orders. Seen this way, linear regression is the analog of a trend surface of first degree:
$$
z = f(x,y) = \beta_0 + \beta_1x + \beta_2y
$$
where $x$ and $y$ are the coordinates.

A figure illustrates how the function above creates a regression _plane_. First, create a grid of coordinates for plotting:

```r
df <- expand.grid(x = seq(from = -2, to = 2, by = 0.2), y = seq(from = -2, to = 2, by = 0.2))
```

Next, select some values for the coefficients (feel free to experiment with these values):

```r
b0 <- 0.5 #0.5
b1 <- 1 #1
b2 <- 2 #2
z1 <- b0 + b1 * df$x + b2 * df$y
z1 <- matrix(z1, nrow = 21, ncol = 21)
```

The plot is as follows:

```r
plot_ly(z = ~z1) %>% add_surface() %>%
  layout(scene = list(xaxis = list(ticktext = c("-2", "0", "2"), tickvals = c(0, 10, 20)), 
                      yaxis = list(ticktext = c("-2", "0", "2"), tickvals = c(0, 10, 20))
                      )
         )
```

<!--html_preserve--><div id="htmlwidget-c76b14cc1e7fb271e726" style="width:672px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-c76b14cc1e7fb271e726">{"x":{"visdat":{"250473c4876":["function () ","plotlyVisDat"]},"cur_data":"250473c4876","attrs":{"250473c4876":{"z":{},"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"surface","inherit":true}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"scene":{"xaxis":{"ticktext":["-2","0","2"],"tickvals":[0,10,20]},"yaxis":{"ticktext":["-2","0","2"],"tickvals":[0,10,20]},"zaxis":{"title":"z1"}},"hovermode":"closest","showlegend":false,"legend":{"yanchor":"top","y":0.5}},"source":"A","config":{"cloud":false},"data":[{"colorbar":{"title":"z1","ticklen":2,"len":0.5,"lenmode":"fraction","y":1,"yanchor":"top"},"colorscale":[["0","rgba(68,1,84,1)"],["0.0416666666666667","rgba(70,19,97,1)"],["0.0833333333333333","rgba(72,32,111,1)"],["0.125","rgba(71,45,122,1)"],["0.166666666666667","rgba(68,58,128,1)"],["0.208333333333333","rgba(64,70,135,1)"],["0.25","rgba(60,82,138,1)"],["0.291666666666667","rgba(56,93,140,1)"],["0.333333333333333","rgba(49,104,142,1)"],["0.375","rgba(46,114,142,1)"],["0.416666666666667","rgba(42,123,142,1)"],["0.458333333333333","rgba(38,133,141,1)"],["0.5","rgba(37,144,140,1)"],["0.541666666666667","rgba(33,154,138,1)"],["0.583333333333333","rgba(39,164,133,1)"],["0.625","rgba(47,174,127,1)"],["0.666666666666667","rgba(53,183,121,1)"],["0.708333333333333","rgba(79,191,110,1)"],["0.75","rgba(98,199,98,1)"],["0.791666666666667","rgba(119,207,85,1)"],["0.833333333333333","rgba(147,214,70,1)"],["0.875","rgba(172,220,52,1)"],["0.916666666666667","rgba(199,225,42,1)"],["0.958333333333333","rgba(226,228,40,1)"],["1","rgba(253,231,37,1)"]],"showscale":true,"z":[[-5.5,-5.1,-4.7,-4.3,-3.9,-3.5,-3.1,-2.7,-2.3,-1.9,-1.5,-1.1,-0.699999999999999,-0.3,0.100000000000001,0.5,0.9,1.3,1.7,2.1,2.5],[-5.3,-4.9,-4.5,-4.1,-3.7,-3.3,-2.9,-2.5,-2.1,-1.7,-1.3,-0.9,-0.499999999999999,-0.0999999999999999,0.3,0.7,1.1,1.5,1.9,2.3,2.7],[-5.1,-4.7,-4.3,-3.9,-3.5,-3.1,-2.7,-2.3,-1.9,-1.5,-1.1,-0.7,-0.299999999999999,0.1,0.5,0.9,1.3,1.7,2.1,2.5,2.9],[-4.9,-4.5,-4.1,-3.7,-3.3,-2.9,-2.5,-2.1,-1.7,-1.3,-0.9,-0.5,-0.0999999999999992,0.3,0.700000000000001,1.1,1.5,1.9,2.3,2.7,3.1],[-4.7,-4.3,-3.9,-3.5,-3.1,-2.7,-2.3,-1.9,-1.5,-1.1,-0.7,-0.3,0.100000000000001,0.5,0.900000000000001,1.3,1.7,2.1,2.5,2.9,3.3],[-4.5,-4.1,-3.7,-3.3,-2.9,-2.5,-2.1,-1.7,-1.3,-0.9,-0.5,-0.0999999999999996,0.300000000000001,0.7,1.1,1.5,1.9,2.3,2.7,3.1,3.5],[-4.3,-3.9,-3.5,-3.1,-2.7,-2.3,-1.9,-1.5,-1.1,-0.7,-0.3,0.100000000000001,0.500000000000001,0.9,1.3,1.7,2.1,2.5,2.9,3.3,3.7],[-4.1,-3.7,-3.3,-2.9,-2.5,-2.1,-1.7,-1.3,-0.9,-0.5,-0.0999999999999999,0.3,0.700000000000001,1.1,1.5,1.9,2.3,2.7,3.1,3.5,3.9],[-3.9,-3.5,-3.1,-2.7,-2.3,-1.9,-1.5,-1.1,-0.7,-0.3,0.1,0.5,0.900000000000001,1.3,1.7,2.1,2.5,2.9,3.3,3.7,4.1],[-3.7,-3.3,-2.9,-2.5,-2.1,-1.7,-1.3,-0.9,-0.5,-0.0999999999999999,0.3,0.7,1.1,1.5,1.9,2.3,2.7,3.1,3.5,3.9,4.3],[-3.5,-3.1,-2.7,-2.3,-1.9,-1.5,-1.1,-0.7,-0.3,0.1,0.5,0.9,1.3,1.7,2.1,2.5,2.9,3.3,3.7,4.1,4.5],[-3.3,-2.9,-2.5,-2.1,-1.7,-1.3,-0.899999999999999,-0.5,-0.0999999999999996,0.3,0.7,1.1,1.5,1.9,2.3,2.7,3.1,3.5,3.9,4.3,4.7],[-3.1,-2.7,-2.3,-1.9,-1.5,-1.1,-0.699999999999999,-0.299999999999999,0.100000000000001,0.5,0.9,1.3,1.7,2.1,2.5,2.9,3.3,3.7,4.1,4.5,4.9],[-2.9,-2.5,-2.1,-1.7,-1.3,-0.9,-0.5,-0.0999999999999996,0.3,0.7,1.1,1.5,1.9,2.3,2.7,3.1,3.5,3.9,4.3,4.7,5.1],[-2.7,-2.3,-1.9,-1.5,-1.1,-0.7,-0.299999999999999,0.100000000000001,0.5,0.9,1.3,1.7,2.1,2.5,2.9,3.3,3.7,4.1,4.5,4.9,5.3],[-2.5,-2.1,-1.7,-1.3,-0.9,-0.5,-0.0999999999999996,0.3,0.7,1.1,1.5,1.9,2.3,2.7,3.1,3.5,3.9,4.3,4.7,5.1,5.5],[-2.3,-1.9,-1.5,-1.1,-0.7,-0.3,0.100000000000001,0.5,0.9,1.3,1.7,2.1,2.5,2.9,3.3,3.7,4.1,4.5,4.9,5.3,5.7],[-2.1,-1.7,-1.3,-0.899999999999999,-0.5,-0.0999999999999996,0.300000000000001,0.700000000000001,1.1,1.5,1.9,2.3,2.7,3.1,3.5,3.9,4.3,4.7,5.1,5.5,5.9],[-1.9,-1.5,-1.1,-0.7,-0.3,0.1,0.5,0.9,1.3,1.7,2.1,2.5,2.9,3.3,3.7,4.1,4.5,4.9,5.3,5.7,6.1],[-1.7,-1.3,-0.9,-0.5,-0.0999999999999996,0.3,0.700000000000001,1.1,1.5,1.9,2.3,2.7,3.1,3.5,3.9,4.3,4.7,5.1,5.5,5.9,6.3],[-1.5,-1.1,-0.7,-0.3,0.1,0.5,0.9,1.3,1.7,2.1,2.5,2.9,3.3,3.7,4.1,4.5,4.9,5.3,5.7,6.1,6.5]],"type":"surface","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

A trend surface of second degree, or quadratic, would be as follows. Notice how it includes _all_ possible quadratic terms, including the product $xy$:
$$
z = f(x,y) = \beta_0 + \beta_1x^2 + \beta_2x + \beta_3xy + \beta_4y + \beta_5y^2
$$

Use the same grid as above to create now a regression _surface_. Select some coefficients:

```r
b0 <- 0.5 #0.5
b1 <- 2 #2
b2 <- 1 #1
b3 <- 1 #1
b4 <- 1.5 #1.5
b5 <- 0.5 #2.5
z2 <- b0 + b1 * df$x^2 + b2 * df$x + b3 * df$x * df$y + b4 * df$y + b5 * df$y^2
z2 <- matrix(z2, nrow = 21, ncol = 21)
```

And the plot is as follows:

```r
plot_ly(z = ~z2) %>% add_surface() %>%
  layout(scene = list(xaxis = list(ticktext = c("-2", "0", "2"), tickvals = c(0, 10, 20)), 
                      yaxis = list(ticktext = c("-2", "0", "2"), tickvals = c(0, 10, 20))
                      )
         )
```

<!--html_preserve--><div id="htmlwidget-fd7b79236bd5fac9f0d6" style="width:672px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-fd7b79236bd5fac9f0d6">{"x":{"visdat":{"250425c71ffa":["function () ","plotlyVisDat"]},"cur_data":"250425c71ffa","attrs":{"250425c71ffa":{"z":{},"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"surface","inherit":true}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"scene":{"xaxis":{"ticktext":["-2","0","2"],"tickvals":[0,10,20]},"yaxis":{"ticktext":["-2","0","2"],"tickvals":[0,10,20]},"zaxis":{"title":"z2"}},"hovermode":"closest","showlegend":false,"legend":{"yanchor":"top","y":0.5}},"source":"A","config":{"cloud":false},"data":[{"colorbar":{"title":"z2","ticklen":2,"len":0.5,"lenmode":"fraction","y":1,"yanchor":"top"},"colorscale":[["0","rgba(68,1,84,1)"],["0.0416666666666667","rgba(70,19,97,1)"],["0.0833333333333333","rgba(72,32,111,1)"],["0.125","rgba(71,45,122,1)"],["0.166666666666667","rgba(68,58,128,1)"],["0.208333333333333","rgba(64,70,135,1)"],["0.25","rgba(60,82,138,1)"],["0.291666666666667","rgba(56,93,140,1)"],["0.333333333333333","rgba(49,104,142,1)"],["0.375","rgba(46,114,142,1)"],["0.416666666666667","rgba(42,123,142,1)"],["0.458333333333333","rgba(38,133,141,1)"],["0.5","rgba(37,144,140,1)"],["0.541666666666667","rgba(33,154,138,1)"],["0.583333333333333","rgba(39,164,133,1)"],["0.625","rgba(47,174,127,1)"],["0.666666666666667","rgba(53,183,121,1)"],["0.708333333333333","rgba(79,191,110,1)"],["0.75","rgba(98,199,98,1)"],["0.791666666666667","rgba(119,207,85,1)"],["0.833333333333333","rgba(147,214,70,1)"],["0.875","rgba(172,220,52,1)"],["0.916666666666667","rgba(199,225,42,1)"],["0.958333333333333","rgba(226,228,40,1)"],["1","rgba(253,231,37,1)"]],"showscale":true,"z":[[9.5,9.02,8.58,8.18,7.82,7.5,7.22,6.98,6.78,6.62,6.5,6.42,6.38,6.38,6.42,6.5,6.62,6.78,6.98,7.22,7.5],[7.78,7.34,6.94,6.58,6.26,5.98,5.74,5.54,5.38,5.26,5.18,5.14,5.14,5.18,5.26,5.38,5.54,5.74,5.98,6.26,6.58],[6.22,5.82,5.46,5.14,4.86,4.62,4.42,4.26,4.14,4.06,4.02,4.02,4.06,4.14,4.26,4.42,4.62,4.86,5.14,5.46,5.82],[4.82,4.46,4.14,3.86,3.62,3.42,3.26,3.14,3.06,3.02,3.02,3.06,3.14,3.26,3.42,3.62,3.86,4.14,4.46,4.82,5.22],[3.58,3.26,2.98,2.74,2.54,2.38,2.26,2.18,2.14,2.14,2.18,2.26,2.38,2.54,2.74,2.98,3.26,3.58,3.94,4.34,4.78],[2.5,2.22,1.98,1.78,1.62,1.5,1.42,1.38,1.38,1.42,1.5,1.62,1.78,1.98,2.22,2.5,2.82,3.18,3.58,4.02,4.5],[1.58,1.34,1.14,0.979999999999999,0.859999999999999,0.779999999999999,0.739999999999999,0.739999999999999,0.779999999999999,0.86,0.98,1.14,1.34,1.58,1.86,2.18,2.54,2.94,3.38,3.86,4.38],[0.82,0.62,0.46,0.34,0.26,0.22,0.22,0.26,0.34,0.46,0.62,0.82,1.06,1.34,1.66,2.02,2.42,2.86,3.34,3.86,4.42],[0.22,0.0599999999999996,-0.0600000000000003,-0.14,-0.18,-0.18,-0.14,-0.0600000000000001,0.0599999999999999,0.22,0.42,0.66,0.940000000000001,1.26,1.62,2.02,2.46,2.94,3.46,4.02,4.62],[-0.22,-0.34,-0.42,-0.46,-0.46,-0.42,-0.34,-0.22,-0.0599999999999999,0.14,0.38,0.66,0.980000000000001,1.34,1.74,2.18,2.66,3.18,3.74,4.34,4.98],[-0.5,-0.58,-0.62,-0.62,-0.58,-0.5,-0.38,-0.22,-0.0199999999999999,0.22,0.5,0.82,1.18,1.58,2.02,2.5,3.02,3.58,4.18,4.82,5.5],[-0.62,-0.66,-0.66,-0.62,-0.54,-0.42,-0.26,-0.0599999999999996,0.18,0.46,0.78,1.14,1.54,1.98,2.46,2.98,3.54,4.14,4.78,5.46,6.18],[-0.58,-0.58,-0.54,-0.459999999999999,-0.339999999999999,-0.179999999999999,0.0200000000000007,0.260000000000001,0.540000000000001,0.860000000000001,1.22,1.62,2.06,2.54,3.06,3.62,4.22,4.86,5.54,6.26,7.02],[-0.38,-0.34,-0.26,-0.14,0.0200000000000002,0.22,0.46,0.740000000000001,1.06,1.42,1.82,2.26,2.74,3.26,3.82,4.42,5.06,5.74,6.46,7.22,8.02],[-0.0199999999999996,0.0600000000000003,0.18,0.340000000000001,0.540000000000001,0.780000000000001,1.06,1.38,1.74,2.14,2.58,3.06,3.58,4.14,4.74,5.38,6.06,6.78,7.54,8.34,9.18],[0.5,0.62,0.78,0.98,1.22,1.5,1.82,2.18,2.58,3.02,3.5,4.02,4.58,5.18,5.82,6.5,7.22,7.98,8.78,9.62,10.5],[1.18,1.34,1.54,1.78,2.06,2.38,2.74,3.14,3.58,4.06,4.58,5.14,5.74,6.38,7.06,7.78,8.54,9.34,10.18,11.06,11.98],[2.02,2.22,2.46,2.74,3.06,3.42,3.82,4.26,4.74,5.26,5.82,6.42,7.06,7.74,8.46,9.22,10.02,10.86,11.74,12.66,13.62],[3.02,3.26,3.54,3.86,4.22,4.62,5.06,5.54,6.06,6.62,7.22,7.86,8.54,9.26,10.02,10.82,11.66,12.54,13.46,14.42,15.42],[4.18,4.46,4.78,5.14,5.54,5.98,6.46,6.98,7.54,8.14,8.78,9.46,10.18,10.94,11.74,12.58,13.46,14.38,15.34,16.34,17.38],[5.5,5.82,6.18,6.58,7.02,7.5,8.02,8.58,9.18,9.82,10.5,11.22,11.98,12.78,13.62,14.5,15.42,16.38,17.38,18.42,19.5]],"type":"surface","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

Higher order polynomials (i.e., cubic, quartic, etc.) are possible in principle. Something to keep in mind is that the higher the order of the polynomial, the more flexible the surface, which may lead to the following issues:

1. Multicollinearity.

Powers of variables tend to be highly correlated with each other. See the following table of correlations for the `x` coordinate in the example:
<table class="table" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> x </th>
   <th style="text-align:right;"> x^2 </th>
   <th style="text-align:right;"> x^3 </th>
   <th style="text-align:right;"> x^4 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> x </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.92 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> x^2 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.96 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> x^3 </td>
   <td style="text-align:right;"> 0.92 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> x^4 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.96 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
  </tr>
</tbody>
</table>

When two variables are highly collinear, the model has difficulties discriminating their relative contribution to the model. This is manifested by inflated standard errors that may depress the significance of the coefficients, and occasionally by sign reversals.

2. Overfitting.

Overfitting is another possible consequence of using a trend surface that is too flexible. This happens when a model fits too well the observations used for callibration, but because of this it may fail to fit well new information.

To illustrate overfitting consider a simple example. Below we simulate a simple linear model with $y_i =  x_i + \epsilon_i$ (the random terms are drawn from the uniform distribution). We also simulate new data using the exact same process:

```r
# Dataset for estimation
df.of1 <- data.frame(x = seq(from = 1, to = 10, by = 1))
df.of1 <- mutate(df.of1, y = x + runif(10, -1, 1))
# New data
new_data <- data.frame(x = seq(from = 1, to = 10, by = 0.5))
df.of2 <- mutate(new_data, y = x + runif(nrow(new_data), -1, 1))
```

This is the scatterplot of the observations in the estimation dataset:

```r
p <- ggplot(data = df.of1, aes(x = x, y = y)) 
p + geom_point(size = 3)
```

<img src="28-Area-Data-VI_files/figure-html/unnamed-chunk-24-1.png" width="672" />

A model with a first order trend (essentially linear regression), does not fit the observations perfectly, but when confronted with new data (plotted as red squares), it predicts them with reasonable accuracy:

```r
mod.of1 <- lm(formula = y ~ x, data = df.of1)
pred1 <- predict(mod.of1, newdata = new_data) #mod.of1$fitted.values
p + geom_abline(slope = mod.of1$coefficients[2], intercept = mod.of1$coefficients[1], 
                color = "blue", size = 1) +
  geom_point(data = df.of2, aes(x = x, y = y), shape = 0, color = "red") +
  geom_segment(data = df.of2, aes(xend = x, yend = pred1)) + 
  geom_point(size = 3) +
  xlim(c(1, 10))
```

<img src="28-Area-Data-VI_files/figure-html/unnamed-chunk-25-1.png" width="672" />

Compare to a polynomial of very high degree (nine in this case). The model is much more flexible, to the extent that it perfectly matches the observations in the estimation dataset. However, this flexibility has a downside. When the model is confronted with new information, its performance is less satisfactory.

```r
mod.of2 <- lm(formula = y ~ poly(x, degree = 9, raw = TRUE), data = df.of1)
poly.fun <- predict(mod.of2, data.frame(x = seq(1, 10, 0.1)))
pred2 <- predict(mod.of2, newdata = new_data) #mod.of1$fitted.values

p + 
  #stat_function(fun = fun.pol, 
  geom_line(data = data.frame(x = seq(1, 10, 0.1), y = poly.fun), aes(x = x, y = y),
                color = "blue", size = 1) + 
  geom_point(data = df.of2, aes(x = x, y = y), shape = 0, color = "red") +
  geom_segment(data = df.of2, aes(xend = x, yend = pred2)) + 
  geom_point(size = 3) +
  xlim(c(1, 10))
```

<img src="28-Area-Data-VI_files/figure-html/unnamed-chunk-26-1.png" width="672" />

We can compute the _root mean square_ (RMS), for each of the two models. The RMS is a measure of error calculated as the square root of the mean of the squared differences between two values (in this case the prediction of the model and the new information). This statistic is a measure of the typical deviation between two sets of values. Given new information, the RMS would tell us the expected size of the error when making a prediction using a given model.

The RMS for model 1 is:

```r
sqrt(mean((df.of2$y - pred1)^2))
```

```
## [1] 0.525595
```

And for model 2:

```r
sqrt(mean((df.of2$y - pred2)^2))
```

```
## [1] 1.681143
```

You will notice how model 2, despite fitting the estimation data better than model 1, typically produces larger errors when new information becomes available.

3. Edge effects.

Another consequence of overfitting, is that the resulting functions tend to display extreme behavior when taken outside of their estimation range, where the largest polynomial terms tend to dominate. 

The plot below is the same high degree polynomial estimated above, just plotted in a slightly larger range of plus/minus one unit:

```r
poly.fun <- predict(mod.of2, data.frame(x = seq(0, 11, 0.1)))
p + 
  geom_line(data = data.frame(x = seq(0, 11, 0.1), y = poly.fun), aes(x = x, y = y),
                color = "blue", size = 1) + 
  geom_point(data = df.of2, aes(x = x, y = y), shape = 0, color = "red") +
  geom_segment(data = df.of2, aes(xend = x, yend = pred2)) + 
  geom_point(size = 3)
```

<img src="28-Area-Data-VI_files/figure-html/unnamed-chunk-29-1.png" width="672" />

### Models with Spatially-varying Coefficients

Another way to generate flexible functional forms is by means of models with spatially varying coefficients. Two approaches are reviewed here.

#### Expansion Method

The expansion method ([Casetti, 1972](http://onlinelibrary.wiley.com/doi/10.1111/j.1538-4632.1972.tb00458.x/full)) is an approach to generate models with contextual effects. It follows a philosophy of specifying first a substantive model with variables of interest, and then an expanded model with contextual variables. In geographical analysis, typically the contextual variables are trend surfaces estimated using the coordinates of the observations.

To illustrate this, suppose that there is the following initial model of proportion of donors in a population, with two variables of substantive interest (say, income and education):
$$
d_i = \beta_i(x_i,y_i) + \beta_1(x_i,y_i)I_i + \beta_3(x_i,y_i)Ed_i + \epsilon_i
$$

Note how the coefficients are now a function of the coordinates at $i$. Unlike previous models that had _global_ coefficients, the coefficients in this model are allowed to adapt by location.

Unfortunately, it is not possible to estimate one coefficient per location. In this case, there are $n\times k$ coefficients, which exceeds the size of the sample ($n$). It is not possible to retrieve more information from the sample than $n$ parameters (this is called the incidental parameter problem.)

A possible solution is to specify a function for the coefficients, for instance, by specifying a trend surface for them:
$$
\begin{array}{l}
\beta_0(x_i, y_i) = \beta_{01} +\beta_{02}x_i + \beta_{03}y_i\\
\beta_1(x_i, y_i) = \beta_{11} +\beta_{12}x_i + \beta_{13}y_i\\
\beta_2(x_i, y_i) = \beta_{21} +\beta_{22}x_i + \beta_{23}y_i
\end{array}
$$
By specifying the coefficients as a function of the coordinates, we allow them to vary by location.

Next, if we substitute these coefficients in the intial model, we arrive at a final expanded model:
$$
d_i = \beta_{01} +\beta_{02}x_i + \beta_{03}y_i + \beta_{11}I_i +\beta_{12}x_iI_i + \beta_{13}y_iI_i + \beta_{21}Ed_i +\beta_{22}x_iEd_i + \beta_{23}y_iEd_i + \epsilon_i
$$

This model has now nine coefficients, instead of $n\times 3$, and can be estimated as usual.

It is important to note that since models generated based on the expansion method are based on the use of trend surfaces, similar caveats apply with respect to multicollinearity and overfitting.

#### Geographically Weighted Regression (GWR)

A different strategy to estimate models with spatially-varying coefficients is a semi-parametric approach, called geographically weighted regression (see [Brunsdon et al., 1996](http://onlinelibrary.wiley.com/doi/10.1111/j.1538-4632.1996.tb00936.x/abstract)).

Instead of selecting a functional form for the coefficients as the expansion method does, the functions are left unspecified. The spatial variation of the coefficients results from an estimation strategy that takes subsamples of the data in a systematic way.

If you recall kernel density analysis, a kernel was a way of weighting observations based on their distance from a focal point.

Geographically weighted regression applies a similar concept, with a moving window that visits a focal point and estimates a weighted least squares model at that location. The results of the regression are conventionally applied to the focal point, in such a way that not only the coefficients are localized, but also every other regression diagnostic (e.g., the coefficient of determination, the standard deviation, etc.)

A key aspect of implementing this model is the selection of the kernel bandwidth, that is, the size of the window. If the window is too large, the local models tend towards the global model (estimated using the whole sample). If the window is too small, the model tends to overfit, since in the limit each window will contain only one, or a very small number of observations.

The kernel bandwidth can be selected if we define some loss function to minimize. A conventional approach (but not the only one), is to minimize a cross-validation score of the following form:
$$
CV (\delta) = \sum_{i=1}^n{\big(y_i - \hat{y}_{\neq i}(\delta)\big)^2}
$$
In this notation, $\delta$ is the bandwidth, and $\hat{y}_{\neq i}(\delta)$ is the value of $y$ predicted by a model with a bandwidth of $\delta$ _after excluding the observation at $i$_. This is called a _leave-one-out_ cross-validation procedure, used to prevent the estimation from shrinking the bandwidth to zero.

GWR is implemented in the package `spgwr`. To estimate models using this approach, the function `sel.GWR`, which takes as inputs a formula specifying the dependent and independent variables, a `SpatialPolygonsDataFrame` (or a `SpatialPointsDataFrame`), and the kernel function (in the example below a Gaussian kernel). Since our data come in the form of simple features, we use `as(x, "Spatial")` to convert to a `Spatial*DataFrame` object:

```r
delta <- gwr.sel(formula = z ~ x + y, 
                 data = as(HamiltonDAs, "Spatial"), 
                 gweight = gwr.Gauss)
```

```
## Bandwidth: 25621.66 CV score: 416.6583 
## Bandwidth: 41415.33 CV score: 439.9313 
## Bandwidth: 15860.64 CV score: 373.3401 
## Bandwidth: 9827.993 CV score: 326.3479 
## Bandwidth: 6099.614 CV score: 301.3906 
## Bandwidth: 3795.349 CV score: 307.3175 
## Bandwidth: 5784.775 CV score: 300.0247 
## Bandwidth: 5317.712 CV score: 298.6785 
## Bandwidth: 4736.221 CV score: 298.7873 
## Bandwidth: 5058.919 CV score: 298.4138 
## Bandwidth: 5051.908 CV score: 298.4127 
## Bandwidth: 5032.504 CV score: 298.4117 
## Bandwidth: 5034.856 CV score: 298.4117 
## Bandwidth: 5034.926 CV score: 298.4117 
## Bandwidth: 5034.918 CV score: 298.4117 
## Bandwidth: 5034.918 CV score: 298.4117 
## Bandwidth: 5034.918 CV score: 298.4117 
## Bandwidth: 5034.918 CV score: 298.4117
```

The function `gwr` estimates the suite of local models given a bandwidth:

```r
model.gwr <- gwr(formula = z ~ x + y, 
                 bandwidth = delta, 
                 data = as(HamiltonDAs, "Spatial"),
                 gweight = gwr.Gauss)
model.gwr
```

```
## Call:
## gwr(formula = z ~ x + y, data = as(HamiltonDAs, "Spatial"), bandwidth = delta, 
##     gweight = gwr.Gauss)
## Kernel function: gwr.Gauss 
## Fixed bandwidth: 5034.918 
## Summary of GWR coefficient estimates at data points:
##                  Min.  1st Qu.   Median  3rd Qu.     Max.  Global
## X.Intercept. -16.8369  -5.8339  -2.0390  -0.6852   2.0016 -3.6765
## x              6.1497  16.5814  19.1775  24.9633  36.8438 20.9207
## y             22.3026  31.5813  36.8539  47.5515  84.3637 44.8033
```

The results are given for each location where a local regression was estimated. Lets join these results to `sf` dataframe for plotting:

```r
HamiltonDAs$beta0 <- model.gwr$SDF@data$X.Intercept.
HamiltonDAs$beta1 <- model.gwr$SDF@data$x
HamiltonDAs$beta2 <- model.gwr$SDF@data$y
HamiltonDAs$localR2 <- model.gwr$SDF@data$localR2
HamiltonDAs$gwr.e <- model.gwr$SDF@data$gwr.e
```

The results can be mapped as shown below (try mapping `beta1`, `beta2`, `localR2`, or the residuals `gwr.e`):

```r
ggplot(data = HamiltonDAs, aes(fill = beta0)) + 
  geom_sf(color = "white") +
  scale_fill_distiller(palette = "YlOrRd", trans = "reverse")
```

<img src="28-Area-Data-VI_files/figure-html/unnamed-chunk-33-1.png" width="672" />

You can verify that the residuals are not spatially autocorrelated:

```r
moran.test(HamiltonDAs$gwr.e, HamiltonDAs.w)
```

```
## 
## 	Moran I test under randomisation
## 
## data:  HamiltonDAs$gwr.e  
## weights: HamiltonDAs.w    
## 
## Moran I statistic standard deviate = 0.016155, p-value = 0.4936
## alternative hypothesis: greater
## sample estimates:
## Moran I statistic       Expectation          Variance 
##      -0.002827161      -0.003378378       0.001164184
```

Some caveats with respect to GWR. 

Since estimation requires the selection of a kernel bandwidth, and a kernel bandwidth requires the estimation of many times leave-one-out regressions, GWR can be computationally quite demanding, especially for large datasets.

GWR has become a very popular method, however, there is conflicting evidence regarding its ability to retrieve a known spatial process [@Paez2011gwr]. For this reasons, interpretation of the spatially-varying coefficients must be conducted with a grain of salt, although this seems to be less of a concern with larger samples - but at the moment it is not known how large a sample is safe (and larger samples also become computationally more demanding). As well, the estimation method is known to be sensitive to unusual observations [@Farber2007gwr]. At the moment, I recommend that GWR be used for prediction only, and in this respect it seems to perform as well, or even better than alternatives approaches [@Paez2008gwr].

## Spatial Error Model (SEM)

A model that can be used to take direct remedial action with respect to residual spatial autocorrelation is the spatial error model.

This model is specified as follows:
$$
y_i = \beta_0 + \sum_{j=1}^k{\beta_kx_{ij}} + \epsilon_i
$$

However, it is no longer assumed that the residuals $\epsilon$ are independent, but instead display map pattern, in the shape of a moving average:
$$
\epsilon_i = \lambda\sum_{i=1}^n{w_{ij}^{st}\epsilon_i} + \mu_i
$$

A second set of residuals $\mu$ are assumed to be independent.

It is possible to show that this model is no longer linear in the coefficients (but this would require a little bit of matrix algebra). For this reason, ordinary least squares is no longer an appropriate estimation algorithm, and models of this kind are instead estimated based on maximum likelihood.

Spatial error models are implemented in the package `spdep`.

As a remedial model, it can account for a model with a misspecified functional form. We know that the underlying process is not linear, but we specify a linear relationship between the covariates in the form of $z = \beta_0 + \beta_1x + \beta_2y$:

```r
model.sem1 <- errorsarlm(formula = z ~ x + y, 
                        data = HamiltonDAs, 
                        listw = HamiltonDAs.w)
summary(model.sem1)
```

```
## 
## Call:
## errorsarlm(formula = z ~ x + y, data = HamiltonDAs, listw = HamiltonDAs.w)
## 
## Residuals:
##       Min        1Q    Median        3Q       Max 
## -2.801195 -0.845856  0.054448  0.793607  2.753617 
## 
## Type: error 
## Coefficients: (asymptotic standard errors) 
##             Estimate Std. Error z value  Pr(>|z|)
## (Intercept) -3.89916    0.63027 -6.1865 6.151e-10
## x           20.99256    1.66815 12.5844 < 2.2e-16
## y           45.92072    1.80719 25.4100 < 2.2e-16
## 
## Lambda: 0.5839, LR test value: 70.68, p-value: < 2.22e-16
## Asymptotic standard error: 0.063578
##     z-value: 9.184, p-value: < 2.22e-16
## Wald statistic: 84.345, p-value: < 2.22e-16
## 
## Log likelihood: -446.2198 for error model
## ML residual variance (sigma squared): 1.0996, (sigma: 1.0486)
## Number of observations: 297 
## Number of parameters estimated: 5 
## AIC: 902.44, (AIC for lm: 971.12)
```

The coefficient $\lambda$ is positive (indicative of positive autocorrelation) and high, since about 50% of the moving average of the residuals $\epsilon$ in the neighborhood of $i$ contribute to the value of $\epsilon_i$. 

You can verify that the residuals are spatially uncorrelated (note that the alternative is "less" because of the negative sign of Moran's I coefficient):

```r
moran.test(model.sem1$residuals, HamiltonDAs.w, alternative = "less")
```

```
## 
## 	Moran I test under randomisation
## 
## data:  model.sem1$residuals  
## weights: HamiltonDAs.w    
## 
## Moran I statistic standard deviate = -0.99147, p-value = 0.1607
## alternative hypothesis: less
## sample estimates:
## Moran I statistic       Expectation          Variance 
##      -0.037200709      -0.003378378       0.001163727
```

Now consider the case of a missing covariate:

```r
model.sem2 <- errorsarlm(formula = log(z) ~ x, 
                        data = HamiltonDAs, 
                        listw = HamiltonDAs.w)
summary(model.sem2)
```

```
## 
## Call:
## errorsarlm(formula = log(z) ~ x, data = HamiltonDAs, listw = HamiltonDAs.w)
## 
## Residuals:
##        Min         1Q     Median         3Q        Max 
## -0.4528582 -0.0706124  0.0077446  0.0831516  0.4621741 
## 
## Type: error 
## Coefficients: (asymptotic standard errors) 
##             Estimate Std. Error z value  Pr(>|z|)
## (Intercept)  1.75329    0.20266  8.6512 < 2.2e-16
## x            1.89674    0.65840  2.8808  0.003966
## 
## Lambda: 0.92272, LR test value: 492.33, p-value: < 2.22e-16
## Asymptotic standard error: 0.021523
##     z-value: 42.87, p-value: < 2.22e-16
## Wald statistic: 1837.9, p-value: < 2.22e-16
## 
## Log likelihood: 159.879 for error model
## ML residual variance (sigma squared): 0.015466, (sigma: 0.12436)
## Number of observations: 297 
## Number of parameters estimated: 4 
## AIC: -311.76, (AIC for lm: 178.57)
```

In this case, the residual pattern is particularly strong, with more than 90% of the moving average contributing to the residuals. Alas, in this case, the remedial action falls short of cleaning the residuals, and we can see that they still remain spatially correlated:

```r
moran.test(model.sem2$residuals, HamiltonDAs.w, alternative = "less")
```

```
## 
## 	Moran I test under randomisation
## 
## data:  model.sem2$residuals  
## weights: HamiltonDAs.w    
## 
## Moran I statistic standard deviate = -3.3739, p-value = 0.0003705
## alternative hypothesis: less
## sample estimates:
## Moran I statistic       Expectation          Variance 
##      -0.118141071      -0.003378378       0.001156981
```

This would suggest the need for alternative action (such as the search for additional covariates).

Ideally, a model should be well-specified, and remedial action should be undertaken only when other alternatives have been exhausted.
