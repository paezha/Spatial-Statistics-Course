Introduction to Mapping in R 
========================================================
author: Megan Coad and Alexis Polidoro
date: 
autosize: true

Key Concepts
========================================================

- How do we Map in R? 
- Why do we Map? 
- Applications in R 


Loading Data Into R 
========================================================

Necessary for Spatial Analysis 


```r
rm(list = ls())
```


```r
library(geog4ga3)
```


```r
data("snow_deaths")
```


Graphing in R
========================================================

- Effective method for visualizing the contents of the dataframe
- Example of Broad Street Pumps and Deaths from John Snow Cholera Example

![plot of chunk unnamed-chunk-4](Slide 1 -figure/unnamed-chunk-4-1.png)


Leaflet Maps
========================================================

Interacting panning of Cholera Example

![An Image](leaflet.png)

***

- Interactive Mapping
- Can look into this further using additional packages
- Heat Maps can also be used for preliminary spatial analysis

Graphing in R
========================================================

![plot of chunk unnamed-chunk-5](Slide 1 -figure/unnamed-chunk-5-1.png)

***

-Identifying different Variables 

Concluding Remarks
========================================================

- Clear Workspace
- R offers an abundance of ways to analyze information 
- Graphs are Important 

- R offers an abundance of ways to analyze information 
- Maps communicate information about a topic 
- We use code to visualize problems 


