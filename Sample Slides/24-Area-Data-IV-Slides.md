Area Data IV
========================================================
author: Megan Coad and Alexis Polidoro
date: 
autosize: true


Key Points
========================================================

- Understand how to visualize Moran's I and local Moran's I
- Understand other forms of Local Analysis of Spatial Association
- know what Bonferroni correction does and when to use it

Recall: Decomposing Moran's I
========================================================



- Moran's I coefficient of spatial autocorrelation is derived based on the idea of aggregating the products of a (mean-centered) variable by its spatial moving average, and then dividing by the variance
- when plotting Moran's scatterplot some observations are highlighted because they make a particularly large contribution to $I$.



 Local Moran's I and Mapping
========================================================
- The local version of Moran's $I$ is implemented in `spdep` as `localmoran`, and can be called with a variable and a set of spatial weights as arguments
- The value of the function is a matrix with local Moran's $I$ coefficients, and their corresponding expected values and variances
- hypothesis testing can be conducted by comparing the empirical statistic to its distribution under the null hypothesis of spatial independence







Local Moran's I and Mapping Contd
========================================================
- For further exploration you can join the local statistics to the dataframe and Map them 
- The map shows whether pop. density in an are is high surrounded by high densities or low surrounded by zones of low density 



A Short Note on Hypothesis Testing
========================================================
- Local tests as introduced above are affected by an issue called _multiple testing_.
- A risk when conducting a large number of tests is that some of them might appear significant _purely by chance!_ The more tests we conduct, the more likely that at least a few of them will be significant by chance
- A crude rule to adjust for this is called _Bonferroni correction_.
- If we apply this correction to the analysis above, we see that instead of 0.05, the p-value needed for significance is much lower:

```
[1] 0.0001428571
```

- Bonferroni correction is known to be overly strict, and sharper approaches exist to correct for multiple testing. Observations that are flagged as significant with the Bonferroni correction, will also be significant under more refined corrections, so it provides a most conservative decision rule.

Detection of Hot and Cold Spots
========================================================

- local statistics can be very useful in detecting what might be termed "hot" and "cold" spots. 
- A _hot spot_ is a group of observations that are significantly high
- A _cold spot_ is a group of observations that are significantly low
