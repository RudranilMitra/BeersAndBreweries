---
title: "A Study of Beers and Breweries in the US"
author: "Ryan Paul & Chad Madding"
date: "October 18, 2018"
output:
  html_document:
    keep_md: true
---



## Introduction

*With a strong presence across the 50 states and the District of Columbia, craft breweries are a vibrant and flourishing economic force at the local, state and national level. As consumers continue to demand a wide range of high quality, full-flavored beers, small and independent craft brewers are meeting this growing demand with innovative offerings, creating high levels of economic value in the process.*

**Bart Watson**, Chief Economist for the Brewers Association

https://www.brewersassociation.org/statistics/economic-impact-data/

This project will focus on gaining incite into breweries in the United Stated. We will focus on providing information to a national brewery for them to look into investing in the craft brewery industry.

## Data

The data for this study will consist of two databases collected and supplied by our client.

**Data/Beers.csv**

| Variable | Description |
| -------- | ----------- |
| Name | name of beer |
| BeerID | unique id number of the beer |
| ABV | alcohol by volume of beer |
| IBU | international bitterness units of the beer |
| Style | style of beer |
| Ounces | unit of measurement for the beer by oz |

**Data/Breweries.csv**

| Variable | Description |
| -------- | ----------- |
| Name | name of beer |
| Brew_ID | unique identification number of the brewery |
| Name | name of brewery |
| City | city where brewery is located |
| State | state where brewery is located |

## Folder Information

This will be information about folders

## Questions our client would like addresses

Load libraries

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```
## -------------------------------------------------------------------------
```

```
## You have loaded plyr after dplyr - this is likely to cause problems.
## If you need functions from both plyr and dplyr, please load plyr first, then dplyr:
## library(plyr); library(dplyr)
```

```
## -------------------------------------------------------------------------
```

```
## 
## Attaching package: 'plyr'
```

```
## The following objects are masked from 'package:dplyr':
## 
##     arrange, count, desc, failwith, id, mutate, rename, summarise,
##     summarize
```


Read the two databases into R

```r
#read in the two databases
breweries <- read.csv("Data/Breweries.csv")
beers <- read.csv("Data/Beers.csv")
```


   1. How many breweries are present in each state?
   
   2. Merge beer data with the breweries data. Print the first 6 observations and the last six observations to check the merged file.
   
   3. Report the number of NA's in each column.
   
   4. Compute the median alcohol content and international bitterness unit for each state. Plot a bar chart to compare.
   
   5. Which state has the maximum alcoholic (ABV) beer? Which state has the most bitter (IBU) beer?
   
   6. Summary statistics for the ABV variable.
   
   7. Is there an apparent relationship between the bitterness of the beer and its alcoholic content? Draw a scatter plot.
   
## Conclusion

Summarize your findings from this exercise.

**sessionInfo**

R version 3.5.1 (2018-07-02)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows >= 8 x64 (build 9200)
