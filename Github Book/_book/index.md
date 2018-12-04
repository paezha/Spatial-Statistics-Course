--- 
title: "Applied Spatial Statistics"
author: "Antonio Paez"
date: "2018-12-03"
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography: [bibliography.bib, packages.bib]
biblio-style: apalike
link-citations: yes
#github-repo: rstudio/bookdown-demo
description: "This book was created as a resource for teaching applied spatial statistics at McMaster University by Antonio Paez, with support from Anastassios Dardas and Rajiv Ubhi."
---

# Preface {-}

The objective of this book is to introduce selected topics in applied spatial statistics. The foundation for the book are the notes that I have developed over several years of teaching applied spatial statistics at McMaster University. This course is a senior level specialist course for geographers and students in other disciplines who are working towards specializations in Geographic Information Systems. 

Over the course of the years, my colleagues and I at McMaster have used at least three different textbooks for teaching spatial statistics. I have personally used McGrew and Monroe [-@Mcgrew2009] to introduce fundamental statistical concepts to geographers. This book (currently on its third edition with Lembo) does a fine job of introducing statistics as a tool for decision making, and is an very valuable resource to study matters of inference, for instance. Many of the examples in the book are geographical, however, the book is relatively limited in its coverage of _spatial statistics_ (particularly models for spatial processes), which is a limitation for teaching a specialist course on this topic.

My book of choice early on (approximately between 2003 and 2010) was the excellent book Interactive Spatial Data Analysis by Bailey and Gatrell [-@Bailey1995]. I started using their book as a graduate student, but even then the limitations of the software that accompanied the book were apparent - in particular the absence of updates or a central repository for code. Despite the regretable obsolesence of the software, the book provided, and still does, a very accessible yet rigorous treatment of many topics of interest in spatial statistics. Bailey and Gatrell's book was, I believe, the first attempt to bridge the need of teaching mid- and upper-level university courses in spatial statistics, and the challenges of doing so with very specialized texts on this topic, including the excellent but demanding Spatial Econometrics [@Anselin1988], Advanced Spatial Statistics [@Griffith1988], Spatial Data Analysis in the Social and Environmental Sciences [@Haining1990], not to mention Statistics for Spatial Data [@Cressie1993].

Subsequently, my book of choice for teaching spatial statistics became O'Sullivan and Unwin's Geographical Information Analysis [@Osullivan2010]. This book updates some topics that were not covered by Bailey and Gatrell. To give an example, much work happened in the mid- to late-nineties with the development of _local forms_ of spatial analysis, including Getis and Ord pioneering research on concentration statistics [@Getis1992], Anselin's Local Indicators of Spatial Association [@Anselin1995], and Brunsdon, Fotheringham, and Charlton's research on geographically weighted regression [@Brunsdon1996]. These and related local forms of spatial analysis have become hugely influential in the intervening years, and are duly covered by O'Sullivan and Unwin in a way that merges well with a course focusing on spatial statistics - although other specialist texts also exist that delve in much more depth into this topic [e.g., @Fotheringham1999; and @Lloyd2010local].

These resources, and many more, have proved invaluable for my teaching for the past few years, and I believe that their influence will be evident in the present book.

So, if there are some excellent resources for teaching and learning spatial statistics, why am I moved to unleash on the world yet another book on this topic?



introduces data analysis for applied spatial scientists. These could be geographers, earth scientists, environmental scientists, planners, or others who work with georeferenced datasets.

My aim with this book has been to introduce key concepts and techniques in the analysis of spatial data in an intuitive way. While there are more advanced treatments of many of these topics, this book should be appealing to students or others who are approaching this topic for the first time.

The book is organized thematically following the cannonical approach seen, for instance, in Bailey and Gatrell [-@Bailey1995] and O'Sullivan and Unwin [-@Osullivan2010]. This approach is to conceptualize data by their unit of support.

Each chapter covers a topic that builds on previous material. In this way, this is not necessarily meant as a reference (there are better books for that). The chapters are followed by an activity.

I have used these materials for teaching spatial data analysis in different settings. In a flipped classroom setting, the chapters are used as practice material by the students before class. The activity is then completed in class, with the instructor providing support and motivating some discussion. Used in a traditional lecture style, the materials provide structure and visual aids. The activities can be completed by the students as homework or during lab time.
