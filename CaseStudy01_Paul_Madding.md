---
title: "A Study of Beers and Breweries in the US"
author: "Ryan Paul & Chad Madding"
date: "October 18, 2018"
output:
  html_document:
    keep_md: true
---



### Introduction

*With a strong presence across the 50 states and the District of Columbia, craft breweries are a vibrant and flourishing economic force at the local, state and national level. As consumers continue to demand a wide range of high quality, full-flavored beers, small and independent craft brewers are meeting this growing demand with innovative offerings, creating high levels of economic value in the process.*

**Bart Watson**, Chief Economist for the Brewers Association

https://www.brewersassociation.org/statistics/economic-impact-data/

We have been hired to gain incite into breweries in the United Stated. We will focus on providing information to a national brewery for them to look into investing in the craft brewery industry.

### Data

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

### Folder Information

There are 3 folders in the BeersAndBreweries repository:

   1. Data - This folder contains the two databases provided by our client. (Beers.csv, Breweries.csv)
   2. Directives - This folder contains the original request for information. (Case Study 01.docx, CaseStudy1Rubric.docx)
   3. The CaseStudy01 folder simply contains the graphics used in this report.

R libraries used in the report

```r
#load libraries
library(dplyr)
library(plyr)
library(ggplot2)
library(pastecs)
```

Read the two databases into R

```r
#read in the two databases
breweries <- read.csv("Data/Breweries.csv")
beers <- read.csv("Data/Beers.csv")
```

### Questions our client would like addressed

   1. How many breweries are present in each state?
   
**The table below list out the breweries in each state. There are three states with just one brewerey and Colorado leads the list with 47.**


```r
#count breweries in each state
brew_state <- sort(table(breweries$State))
#List out the table 
brew_state
```

```
## 
##  DC  ND  SD  WV  AR  DE  MS  NV  AL  KS  NH  NJ  TN  HI  KY  NM  SC  UT 
##   1   1   1   1   2   2   2   2   3   3   3   3   3   4   4   4   4   4 
##  WY  IA  ID  LA  NE  RI  OK  AK  GA  MD  CT  ME  MO  MT  VT  AZ  MN  FL 
##   4   5   5   5   5   5   6   7   7   7   8   9   9   9  10  11  12  15 
##  OH  NY  VA  IL  NC  WI  IN  MA  WA  PA  TX  OR  MI  CA  CO 
##  15  16  16  18  19  20  22  23  23  25  28  29  32  39  47
```

   2. We will now merge the beer data with the breweries data and print the first 6 observations and the last six observations to check the new merged file.


```r
#looking at each database to see problems before the merge
head(beers)
```

```
##                  Name Beer_ID   ABV IBU Brewery_id
## 1            Pub Beer    1436 0.050  NA        409
## 2         Devil's Cup    2265 0.066  NA        178
## 3 Rise of the Phoenix    2264 0.071  NA        178
## 4            Sinister    2263 0.090  NA        178
## 5       Sex and Candy    2262 0.075  NA        178
## 6        Black Exodus    2261 0.077  NA        178
##                            Style Ounces
## 1            American Pale Lager     12
## 2        American Pale Ale (APA)     12
## 3                   American IPA     12
## 4 American Double / Imperial IPA     12
## 5                   American IPA     12
## 6                  Oatmeal Stout     12
```

```r
head(breweries)
```

```
##   Brew_ID                      Name          City State
## 1       1        NorthGate Brewing    Minneapolis    MN
## 2       2 Against the Grain Brewery    Louisville    KY
## 3       3  Jack's Abby Craft Lagers    Framingham    MA
## 4       4 Mike Hess Brewing Company     San Diego    CA
## 5       5   Fort Point Beer Company San Francisco    CA
## 6       6     COAST Brewing Company    Charleston    SC
```

```r
#rename Brew_ID to Brewery_id to merge data
colnames(breweries)[1] <- "Brewery_id"
#both have a "Name" two for different groups
#rename Name to Brewery_Name
colnames(breweries)[2] <- "Brewery_Name"
#rename Name to Beer_Name
colnames(beers)[1] <- "Beer_Name"
#merge both data sets
brew_beer <- merge.data.frame(beers, breweries, by = "Brewery_id")
#print the first 6 observations
head(brew_beer, 6)
```

```
##   Brewery_id     Beer_Name Beer_ID   ABV IBU
## 1          1  Get Together    2692 0.045  50
## 2          1 Maggie's Leap    2691 0.049  26
## 3          1    Wall's End    2690 0.048  19
## 4          1       Pumpion    2689 0.060  38
## 5          1    Stronghold    2688 0.060  25
## 6          1   Parapet ESB    2687 0.056  47
##                                 Style Ounces       Brewery_Name
## 1                        American IPA     16 NorthGate Brewing 
## 2                  Milk / Sweet Stout     16 NorthGate Brewing 
## 3                   English Brown Ale     16 NorthGate Brewing 
## 4                         Pumpkin Ale     16 NorthGate Brewing 
## 5                     American Porter     16 NorthGate Brewing 
## 6 Extra Special / Strong Bitter (ESB)     16 NorthGate Brewing 
##          City State
## 1 Minneapolis    MN
## 2 Minneapolis    MN
## 3 Minneapolis    MN
## 4 Minneapolis    MN
## 5 Minneapolis    MN
## 6 Minneapolis    MN
```

```r
#print the last 6 observations
tail(brew_beer, 6)
```

```
##      Brewery_id                 Beer_Name Beer_ID   ABV IBU
## 2405        556             Pilsner Ukiah      98 0.055  NA
## 2406        557  Heinnieweisse Weissebier      52 0.049  NA
## 2407        557           Snapperhead IPA      51 0.068  NA
## 2408        557         Moo Thunder Stout      50 0.049  NA
## 2409        557         Porkslap Pale Ale      49 0.043  NA
## 2410        558 Urban Wilderness Pale Ale      30 0.049  NA
##                        Style Ounces                  Brewery_Name
## 2405         German Pilsener     12         Ukiah Brewing Company
## 2406              Hefeweizen     12       Butternuts Beer and Ale
## 2407            American IPA     12       Butternuts Beer and Ale
## 2408      Milk / Sweet Stout     12       Butternuts Beer and Ale
## 2409 American Pale Ale (APA)     12       Butternuts Beer and Ale
## 2410        English Pale Ale     12 Sleeping Lady Brewing Company
##               City State
## 2405         Ukiah    CA
## 2406 Garrattsville    NY
## 2407 Garrattsville    NY
## 2408 Garrattsville    NY
## 2409 Garrattsville    NY
## 2410     Anchorage    AK
```

   3. Report the number of NA's in each column.
   
**There are only two columns that have missing data. The ABV looks to be missing 62 entries and IBU has 1005 NA's out of the total 2410 observations.**
   

```r
#use colSum to sum up the NA's in each column
colSums(is.na(brew_beer))
```

```
##   Brewery_id    Beer_Name      Beer_ID          ABV          IBU 
##            0            0            0           62         1005 
##        Style       Ounces Brewery_Name         City        State 
##            0            0            0            0            0
```

   4. Compute the median alcohol content and international bitterness unit for each state. Plot a bar chart to compare.
   

```r
#Compute the median alcohol content (ABV) by state
medABV <- tapply(brew_beer$ABV, brew_beer$State, function(x) median = median(x, na.rm = TRUE))
#Compute the median international bitterness unit (IBU) by state
medIBU <- tapply(brew_beer$IBU, brew_beer$State, function(x) median = median(x, na.rm = TRUE))

#plot a bar chart to compare ABV and IBU
#convert AVB and IBU to a data frame
medABVbar <- data.frame(medABV)
medIBUbar <- data.frame(medIBU)

#add a State column to ABV and IBU
medABVbar$State <- rownames(medABVbar)
medIBUbar$State <- rownames(medIBUbar)

#plot a bar chart for ABV
ggplot(na.omit(medABVbar), aes(x=reorder(medABVbar$State, medABVbar$medABV), y=medABVbar$medABV)) +
  geom_bar(stat="identity", color="white", fill="blue") +
  ylab("Alcohol Content") + xlab("State") +
  ggtitle("Median ABV by State") +
  coord_flip() + theme(plot.title = element_text(hjust=0.5), text = element_text(size=7.5))
```

![](CaseStudy01_Paul_Madding_files/figure-html/Compute the median-1.png)<!-- -->

```r
#Remove SD from the list due to no IBU data
medIBUbar <- medIBUbar[-grep("SD", medIBUbar$State),]
#plot a bar chart for IBU
ggplot((medIBUbar), aes(x=reorder(medIBUbar$State, medIBUbar$medIBU), y=medIBUbar$medIBU)) +
  geom_bar(stat="identity", color="white", fill="blue") +
  ylab("IBU") + xlab("State") +
  ggtitle("Median IBU by State") +
  coord_flip() + theme(plot.title = element_text(hjust=0.5), text = element_text(size=7.5))
```

![](CaseStudy01_Paul_Madding_files/figure-html/Compute the median-2.png)<!-- -->

   5. Which state has the maximum alcoholic (ABV) beer? Which state has the most bitter (IBU) beer?

**In the dataset provided to us, Colorado has the higest alcoholic (ABV) beer and Oregon has the most bitter (IBU).**
      

```r
#state wuth the maximum alcoholic (ABV) beer
brew_beer$State[which.max(brew_beer$ABV)]
```

```
## [1]  CO
## 51 Levels:  AK  AL  AR  AZ  CA  CO  CT  DC  DE  FL  GA  HI  IA  ID ...  WY
```

```r
#state with the most bitter (IBU) beer
brew_beer$State[which.max(brew_beer$IBU)]
```

```
## [1]  OR
## 51 Levels:  AK  AL  AR  AZ  CA  CO  CT  DC  DE  FL  GA  HI  IA  ID ...  WY
```

   6. Summary statistics for the ABV variable.

| Value | Description |
|-------|-------------|
| 2348 | the number of values (nbr.val) |
| 0 | number of null values (nbr.null) |
| 62 | number of missing values (nbr.na) |
| 0.001 | minimal value (min) |
| 0.128 | maximal value (max) |
| 0.127 | range (range, that is, max-min) |
| 140.348 | sum of all non-missing values (sum) |
| 0.056 | median (median) |
| 0.060 | mean (mean) |
| 0.00028 | standard error on the mean (SE.mean) |
| 0.00055 | confidence interval of the mean (CI.mean) at the p=0.95 level |
| 0.00018 | variance (var) |
| 0.01354 | standard deviation (std.dev) |
| 0.22655 | variation coefficient (coef.var) (sd/mean) |


```r
#summary stats for ABV
options(scipen=100)
options(digits=2)
stat.desc(brew_beer$ABV)
```

```
##      nbr.val     nbr.null       nbr.na          min          max 
##   2348.00000      0.00000     62.00000      0.00100      0.12800 
##        range          sum       median         mean      SE.mean 
##      0.12700    140.34800      0.05600      0.05977      0.00028 
## CI.mean.0.95          var      std.dev     coef.var 
##      0.00055      0.00018      0.01354      0.22655
```

   7. Is there an apparent relationship between the bitterness of the beer and its alcoholic content? Draw a scatter plot.
   

```r
#ggplot to check for correlation between IBU and ABV
ggplot(brew_beer, aes(x = IBU, y = ABV)) + geom_point(na.rm=TRUE)+geom_smooth(method=lm,se=FALSE, na.rm=TRUE)
```

![](CaseStudy01_Paul_Madding_files/figure-html/scatter plot-1.png)<!-- -->

**The scatter plot above looks to show a positive correlation between the ABV and IBU.**

**Looking at the numbers below we can see a very significant correlation between the alcohol content (ABV) and the bitterness (IBU) of a beer. One thing to keep in mind, there are 62 missing entries in AVB and 1005 in the IBU data leading to a lower degrees of freedom, but at a thousand in the current data set the correlation data is still relevant. This is observational data so even with the correlation any inferences made to the larger population would be speculative.**


```r
# Pearson to check for correlation 
cor.test(brew_beer$ABV, brew_beer$IBU, method = "pearson")
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  brew_beer$ABV and brew_beer$IBU
## t = 30, df = 1000, p-value <0.0000000000000002
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  0.64 0.70
## sample estimates:
##  cor 
## 0.67
```

### Conclusion

Summarize your findings from this exercise.

**sessionInfo**

R version 3.5.1 (2018-07-02)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows >= 8 x64 (build 9200)
