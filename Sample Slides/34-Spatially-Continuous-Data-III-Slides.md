Spatially Continuous Data III
========================================================
author: Megan Coad and Alexis Polidoro 
date: 
autosize: true

Key Concepts
========================================================

- Measuring Spatial Dependence
- Semivarance, covariance
- Variographic Analysis

Recall: Residual Spatial Pattern
========================================================

- Trend surface analysis using Voronoi polygons, IDW, K-point means 
- Built-in mechanism for estimating unertainty of predictions
- ISSUE: We do not know the exact value at $p$ 

Interpolation and Randomness
========================================================

- Residuals are spatially dependent
- Allows us to make simple interpolations
- If residuals were random, it would be more difficult to interpolate

***

![plot of chunk unnamed-chunk-1](34-Spatially-Continuous-Data-III-Slides-figure/unnamed-chunk-1-1.png)

Measuring Spatial Dependence
========================================================
- Critical for investigating residual patterns (beyond positive + negative)
- We can measure spatial patterns using Moran's I
- Moran's I measures spatial dependence at a SINGLE SCALE - where the spatial weights are defined (i.e. adjacency)

Measuring Spatial Dependence: Correlograms
========================================================
- Sequence of Moran's I over different scales 
- Autocorrelation is stronger at a smaller scale
- Problem: does not account for distance, but number of observations

***

![plot of chunk unnamed-chunk-2](34-Spatially-Continuous-Data-III-Slides-figure/unnamed-chunk-2-1.png)

Autocovariance
========================================================
- Recall covariance: How 2 variables are related, either positively or inversely
- Autocovariance: Covariance of the process with itself at different locations
- Distances are spatially related if equal to a predefined spatial lag, $h$

***

$$
w_{ij}(h)=\bigg\{\begin{array}{l l}
1\text{ if } d_{ij} = h\\
0\text{ otherwise}\\
\end{array}
$$


The Spatial Lag, h
========================================================
- Changing the spatial lag $h$ allows us to calculate autocovariance at different scales 
- i.e.Covariogram & Semivariogram
- Pairs of are formed with observations at an appriximate lag $h$

Semivariograms
========================================================
- Numbers: pairs of observations used to calculate the semivariance at the corresponding lag

***
![plot of chunk unnamed-chunk-3](34-Spatially-Continuous-Data-III-Slides-figure/unnamed-chunk-3-1.png)


Covariograms
========================================================
- Estimate spatial dependence at any lag within the domain of the data
- Autocovariance is stronger at shorter spatial lags

***

![plot of chunk unnamed-chunk-4](34-Spatially-Continuous-Data-III-Slides-figure/unnamed-chunk-4-1.png)

Anatomy of a Semivariogram
========================================================
- Sill: point where there is no more or less similarity beween observations than would be implied by the variance of the sample
- Range: distance at which the sill is reached
- Nugget: Distance from origin to a discontinuity

***

![Figure 3. Elements of a semivariogram](semivariogram.jpg)

Fitting a Model to a Semivariogram
========================================================
- A set of models can be passed as an argument to `fit.variogram`; output is the model that provides the best fit to the empirical semivariogram


```r
variogram_z.t <- fit.variogram(variogram_z, model = vgm("Exp", "Sph", "Gau"))
```

Exponential Semivariogram
========================================================

![plot of chunk unnamed-chunk-6](34-Spatially-Continuous-Data-III-Slides-figure/unnamed-chunk-6-1.png)

Spherical Semivariogram
========================================================

![plot of chunk unnamed-chunk-7](34-Spatially-Continuous-Data-III-Slides-figure/unnamed-chunk-7-1.png)

Gaussian Semivariogram
========================================================

![plot of chunk unnamed-chunk-8](34-Spatially-Continuous-Data-III-Slides-figure/unnamed-chunk-8-1.png)

Concluding Remarks
========================================================
- Single-scale attributes of Moran's I are further explored through autocovariance
- We use variograms to illustrate autocovariance of spatially continuous data
