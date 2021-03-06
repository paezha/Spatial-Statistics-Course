Point Pattern Analysis III
========================================================
author: Megan Coad and Alexis Polidoro
date: 
autosize: true

This is the title slide

Key Points
========================================================

ADD POINTS HERE 


Hide the slide title by writting "title: false" at the beginning of the slide

Motivation
========================================================



Slide with code
========================================================

Some functions do not produce output, but many other do

Notice that this slide has code that is run but not displayed; the output is displayed on the slide (echo = FALSE)




Slide with code
========================================================

Of course, this allows us to illustrate things. This example is taken from 02-Introduction-to-Mapping.Rmd

The code is not displayed, but the output, a plot, will appear on the slide

![plot of chunk unnamed-chunk-3](Sample Slides-figure/unnamed-chunk-3-1.png)

Slide with code
========================================================

Sometimes you might want to illustrate the code, but not necessarily run it

Notice that this slide has code that is displayed but not run (eval = FALSE)


```r
summary(snow_deaths)
```

Slide with an image
========================================================

Other images can be when convenient be created outside the presentation and displayed. For example, this slide loads an external image saved in the same directory.

This figure was taken from 12-Point-Pattern-Analysis-III

![An Image](unnamed-chunk-9-1.png)


Slide with two columns
========================================================

It is possible to create to columns in the slide by separating content with "***"

***

And this is the second column

The second column includes a numbered list:

1. Item 1
2. Item 2
3. Item 3


Slide with two columns
========================================================

This column is a numbered list:

1. Item 1
2. Item 2
3. Item 3

***

This column is an image:

![An Image](unnamed-chunk-9-1.png)


Slide with two columns
========================================================

This column is a numbered list:

1. Item 1
2. Item 2
3. Item 3

***

This column is an image:

![plot of chunk unnamed-chunk-5](Sample Slides-figure/unnamed-chunk-5-1.png)


Slide with mathematical notation
========================================================

Like with markdown, it is possible to include mathematical notation inline, like this: $\hat{x}$

Or have mathematical notation in blocks. This was taken from 28-Area-Data-VI.Rmd
$$
z = f(x,y) = exp(\beta_0)exp(\beta_1x)exp(\beta_2y) + \epsilon_i
$$


Slide with mathematical notation
========================================================

But my equation is too close to the text!
$$
z = f(x,y) = exp(\beta_0)exp(\beta_1x)exp(\beta_2y) + \epsilon_i
$$

Slide with mathematical notation
========================================================

Type two spaces after a paragraph to introduce a line break.
  
$$
z = f(x,y) = exp(\beta_0)exp(\beta_1x)exp(\beta_2y) + \epsilon_i
$$


Line spacing
========================================================

Use two blank space for line breaks. See the difference:

This paragraph
does not break over two lines

This paragraph  
does break over two lines

This paragraph  
  
has an additional blank line

But you can only  
  
  
    
have one blank line, even if you use more than one break


Block quotes
========================================================

Use ">>" for block quotes:

>> This is probably the best course I have ever taken in all my geographical life


Text formatting
========================================================

_italics_ or *italics*

__bold__ or **bold**

`code`

superscripts^2^ and subscripts~2~


Links
========================================================

Include links, like this:

https://r4ds.had.co.nz/r-markdown.html

Or like [this](https://r4ds.had.co.nz/r-markdown.html)


Simple tables
========================================================

First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  | Content Cell

***

But prettier, more sophisticated tables can be created using `R` packages such as `kable`
