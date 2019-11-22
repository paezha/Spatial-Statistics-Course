Spatially Continuous Data IV
========================================================
author: Megan Coad and Alexis Polidoro
date: 
autosize: true



Key Points
========================================================

- Exploiting information using K-Point means 
- Understand how to do Kriging and the benifits of it 


Using residual spatial pattern to estimate prediction errors
========================================================



- To begin this step, re-calculate the trend surface analysis of best fir for the data (for the walker lake data it was a cubic model)
- The trend surface provides a smooth estimate of the field, however, it is not sufficient to capture all systematic variation, and fails to produce random residuals
- A  way of enhancing this approach to interpolation is to _exploit_ the information that remains in the residuals, for instance by the use of $k$-point means.




```

Call:
lm(formula = V ~ X3 + X2Y + X2 + X + XY + Y + Y2 + XY2 + Y3, 
    data = Walker_Lake)

Residuals:
    Min      1Q  Median      3Q     Max 
-564.19 -197.41    7.91  194.25  929.72 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept) -8.620e+00  1.227e+02  -0.070 0.944035    
X3           1.533e-04  4.806e-05   3.190 0.001522 ** 
X2Y          6.139e-05  3.909e-05   1.570 0.117000    
X2          -6.651e-02  1.838e-02  -3.618 0.000330 ***
X            9.172e+00  2.386e+00   3.844 0.000138 ***
XY          -4.420e-02  1.430e-02  -3.092 0.002110 ** 
Y            4.794e+00  2.040e+00   2.350 0.019220 *  
Y2          -1.806e-03  1.327e-02  -0.136 0.891822    
XY2          7.679e-05  2.956e-05   2.598 0.009669 ** 
Y3          -4.170e-05  2.819e-05  -1.479 0.139759    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 276.7 on 460 degrees of freedom
Multiple R-squared:  0.1719,	Adjusted R-squared:  0.1557 
F-statistic: 10.61 on 9 and 460 DF,  p-value: 5.381e-15
```


































```
Error in file(con, "rb") : cannot open the connection
```
