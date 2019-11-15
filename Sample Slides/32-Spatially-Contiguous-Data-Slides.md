Spatially Continous Data II
========================================================
author: Megan Coad and Alexis Polidoro
date: 
autosize: true


Key Points
========================================================

- Understand how to calculate Local Standard Deviation
- Understand Trend surface Analysis
- Know how to explore spatial variability
- Precision vs Accuracy 


 Uncertainty in the predictions
========================================================



In a previous chapter we introduced three methods for obtaining point estimates; tile-based methods (Voronoi Polygons), inverse distance weighting, and $k$-point means 
- These methods do not provide an estimate for the random element, so it is not possible to assess uncertainty directly
- There are different ways in which some crude assessment of uncertainty could be attached to the point estimates
- a simple approach could be to use the sample variance to calculate intervals of confidence



Calculating Intervals of Confidence
========================================================

1. Calculate standard deviation of the sample 


```r
sd(Walker_Lake$V)
```

```
[1] 301.1554
```

- The standard deviation is the average deviation from the mean. We could use this value to say that typical deviations from our point estimates are a function of this standard deviation 
- A problem with using this approach is that the distribution of the variable is not normal, and the distribution of $\hat{\epsilon}_p$ is unknown
- the standard deviation is centered on the mean (meaning that it is a poor estimate for observations away from the mean)
- in any case the standard deviation of the sample is too large for local point estimates if there is spatial pattern (since we know that the local mean will vary systematically).


Local Standard Deviation Steps 
========================================================
- Consider the case of k-point means, the point estimate is based on the values of the k-nearest neighbors
- The standard deviation could be calculated also based in the values of the k-nearest neighbors, meaning that it would be based on the local mean
1. create a target grid for interpolation, and extract the coordinates of observations 

```r
target_xy = expand.grid(x = seq(0.5, 259.5, 2.2), y = seq(0.5, 299.5, 2.2))
source_xy = cbind(x = Walker_Lake$X, y = Walker_Lake$Y)
```

2. Interpolation using $k=5$ neighbors 

```r
kpoint.5 <- kpointmean(source_xy = source_xy, z = Walker_Lake$V, target_xy = target_xy, k = 5)
```

3. plot the interpolated field 

![plot of chunk unnamed-chunk-5](32-Spatially-Contiguous-Data-Slides-figure/unnamed-chunk-5-1.png)

Local Standard Deviation Contd. 
========================================================
 4. plot the _local_ standard deviation:
 
![plot of chunk unnamed-chunk-6](32-Spatially-Contiguous-Data-Slides-figure/unnamed-chunk-6-1.png)

- The local standard deviation indicates the typical deviation from the local mean
- The standard deviation locally is usually lower than the standard deviation of the sample, and it tends to be larger for the tails (locations where the values are rare)

- The local standard deviation is a crude estimator of the uncertainty because we do not know the underlying distribution


Trend surface analysis
========================================================
- a form of multivariate regression that uses the coordinates of the observations to fit a surface to the data
- a simulated example will illustrate how this works. First we simulate a set of observations. 

- Then simulate a spatial process

- We can fit a trend surface to the data as follows. In this case, the trend is linear:

```

Call:
lm(formula = z ~ u + v, data = df)

Residuals:
      Min        1Q    Median        3Q       Max 
-0.278252 -0.050810 -0.003983  0.063733  0.220237 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  0.52330    0.02036   25.70   <2e-16 ***
u            0.26283    0.02614   10.05   <2e-16 ***
v            0.67690    0.02690   25.16   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.09906 on 177 degrees of freedom
Multiple R-squared:  0.7959,	Adjusted R-squared:  0.7936 
F-statistic:   345 on 2 and 177 DF,  p-value: < 2.2e-16
```
- Given a trend surface model, we can estimate the value of the variable $z$ at locations where it was not measured
- this is done by interpolating on a fine grid that can be used for vizualization or further analysis


Interpolating on a Fine Grid 
========================================================

1. create a grid for interpolation. We will call the coordinates `x.p` and `y.p`. These we generate by creating a sequence of values in the domain of the data, for instance in the [0,1] interval:

```r
u.p <- seq(from = 0.0, to = 1.0, by = 0.05)
v.p <- seq(from = 0.0, to = 1.0, by = 0.05)
```

2. For prediction, we want all combinations of `x.p` and `y.p`, so we expand these two vectors into a grid, by means of the function `expand.grid`:

```r
df.p <- expand.grid(u = u.p, v = v.p)
```
3.  the `predict` function can be used in conjunction with the results of the estimation. 

```r
preds <- predict(trend.l, newdata = df.p, se.fit = TRUE, interval = "prediction", level = 0.95)
```


Interpolating on a Fine Grid Contd. 
========================================================
- A convenient way to visualize the results of the analysis above is by means of a 3D plot
1. First create matrices with the point estimates of the trend surface (`z.p`), and the lower and upper bounds (`z.p_l`, `z.p_u`):

```r
z.p <- matrix(data = preds$fit[,1], nrow = 21, ncol = 21, byrow = TRUE)
z.p_l <- matrix(data = preds$fit[,2], nrow = 21, ncol = 21, byrow = TRUE)
z.p_u <- matrix(data = preds$fit[,3], nrow = 21, ncol = 21, byrow = TRUE)
```

2. The plot is created using the coordinates used for interpolation and the matrices with the point estimates `z.p` and the upper and lower bounds.

*ADD IMAGE HERE*

-  we now not only have an estimate of the underlying field, but also a measure of uncertainty for our predictions, since our estimated values are bound, with 95% confidence, between the lower and upper surfaces.

Interpolating on a Fine Grid Contd. 
========================================================
- lets apply trend surface analysis to the Walker Lake dataset
- first calculate the polynomial terms of the coordinates, for instance to the 3rd degree (this can be done to any arbitrary degree, however keeping in mind the caveats discussed previously with respect to trend surface analysis):
- We can proceed to estimate various models

- Inspection of the results suggests that the cubic trend surface provides the best fit, with the highest adjusted coefficient of determination and the cubic trend yields the smallest standard error, which implies that the intervals of confidence are tighter, and hence the degree of uncertainty is smaller.

- See further examples on Slides 

Intrepretation of the Models
========================================================
- If the confidence inrerval is very wide the model is not very reliable 
- If they also include negative numbers in the lower bound it can indicate an unreliable model

- This can lead us to questions whether the point estimates are correct

*ADD IMAGE*

- the trend surface does a mediocre job with the point estimates as well.

- A possible reason for this is that the model failed to capture the spatial variability. 



Exploring Spatial Variability 
========================================================
- plot the residuals of the model, after labeling them as "positive" or "negative":


- Visual inspection of the distribution of the residuals strongly suggests that they are not random
- We can check this by means of Moran's I coefficient


***

![plot of chunk unnamed-chunk-16](32-Spatially-Contiguous-Data-Slides-figure/unnamed-chunk-16-1.png)




Checking Distribution with Moran's I 
========================================================

1.  create a list of spatial weights as follows:

```r
WL.listw <- nb2listw(knn2nb(knearneigh(as.matrix(Walker_Lake[,2:3]), k = 5)))
```

The results of the autocorrelation analysis of the residuals are:

```

	Moran I test under randomisation

data:  WL.trend3$residuals  
weights: WL.listw    

Moran I statistic standard deviate = 17.199, p-value < 2.2e-16
alternative hypothesis: greater
sample estimates:
Moran I statistic       Expectation          Variance 
     0.4633803457     -0.0021321962      0.0007325452 
```

- Given the low $p$-value, we fail to reject the null hypothesis, and conclude, with a high level of confidence, that the residuals are not independent


Accuracy and precision
========================================================

- Accuracy refers to how close the predicted values $\hat{z}_p$ are to the true values of the field
- Precision refers to how much uncertainty is associated with such predictions

![Figure 1. Accuracy and precision](Spatially Continuous Data II - Figure 1.jpg)

Panel a) in the figure represents a set of accurate points

Panel b) is a set of inaccurate and imprecise points.

Panel c) is a set of precise but inaccurate points.

Finally, Panel d) is a set of accurate and precise points.
