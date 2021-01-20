Point Pattern Analysis IV
========================================================
author: Alexis Polidoro and Megan Coad 
date: 
autosize: true

Key Concepts
========================================================

- F- or Empty Space function 
- Identifying Patterns at Multiple Scales
- K-function 




Quick Recap: G-function 
========================================================
- Cumulative distribution of events to their nearest event
- 40% of events have nearest neighbour at a distance less than X 

***

![plot of chunk unnamed-chunk-2](14-Point-Pattern-Analysis-Slides-figure/unnamed-chunk-2-1.png)

F-function
========================================================
- Another useful tool for point patterns
- Distribution of "point to nearest event" 
- Single scale 

F-function Continued...
========================================================

![plot of chunk unnamed-chunk-3](14-Point-Pattern-Analysis-Slides-figure/unnamed-chunk-3-1.png)

***
- Empirical below theoretical = clustering
![plot of chunk unnamed-chunk-4](14-Point-Pattern-Analysis-Slides-figure/unnamed-chunk-4-1.png)


Patterns At Multiple Scales: Issues
========================================================
- missing patterns at different scales: clustering at small scale, regularity at larger scales

![plot of chunk unnamed-chunk-5](14-Point-Pattern-Analysis-Slides-figure/unnamed-chunk-5-1.png)

K-function
========================================================
- Solution to the limitations of the F-function 
- Interpreted as counting events in a given radius
- Detects patterns at multiple scales


K-function Continued
========================================================
- empirical>theoretical: clustering 

![plot of chunk unnamed-chunk-6](14-Point-Pattern-Analysis-Slides-figure/unnamed-chunk-6-1.png)

***

![plot of chunk unnamed-chunk-7](14-Point-Pattern-Analysis-Slides-figure/unnamed-chunk-7-1.png)

Concluding Remarks
========================================================
- F-function determines point to their nearest event at a single scale 
- Single scale does not detect all patterns in a null landscape 
- K-function is a useful tool to detemermine nearest events at multiple scales
