Area Data VI
========================================================
author: Megan Coad and Alexis Polidoro
date: 
autosize: true


Key Points
========================================================

ADD POINTS HERE 



Incorrect Functional Form
========================================================


 - An incorrect functional form can lead to residual spatial autocorrelation
 - To illustrate this we can simulate a spatial process
 
$$
z = f(x,y) = exp(\beta_0)exp(\beta_1x)exp(\beta_2y) + \epsilon_i
$$

- this is a non-linear spatial process


Incorrect Functional Form Contd. 
========================================================

-  Suppose that we estimate the model as a linear regression that does not correctly capture the non-linearity  
- The model would be as follows:

```

Call:
lm(formula = z ~ u + v, data = HamiltonDAs)

Residuals:
    Min      1Q  Median      3Q     Max 
-2.7267 -0.8591  0.0028  0.8250  3.5826 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  -3.6765     0.3255  -11.29   <2e-16 ***
u            20.9207     0.8586   24.37   <2e-16 ***
v            44.8033     0.9305   48.15   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 1.231 on 294 degrees of freedom
Multiple R-squared:  0.8965,	Adjusted R-squared:  0.8958 
F-statistic:  1273 on 2 and 294 DF,  p-value: < 2.2e-16
```


Incorrect Functional Form Contd. 
========================================================



- the model gives the impression of a very good fit: all coefficients are significant, and the coefficient of multiple determination $R^2$ is moderately high.

- it is important to examine the residuals to verify that they are independent

- A map of the residuals can help examine their spatial pattern























```
Error in file(con, "rb") : cannot open the connection
```
