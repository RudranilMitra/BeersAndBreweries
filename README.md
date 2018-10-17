#### A Study of Beers and Breweries in the US
#### authors: Ryan Paul & Chad Madding
#### due date: October 18, 2018


## Introduction

*With a strong presence across the 50 states and the District of Columbia, craft breweries are a vibrant and flourishing economic force at the local, state and national level. As consumers continue to demand a wide range of high quality, full-flavored beers, small and independent craft brewers are meeting this growing demand with innovative offerings, creating high levels of economic value in the process.*

**Bart Watson**, Chief Economist for the Brewers Association

https://www.brewersassociation.org/statistics/economic-impact-data/

This project will focus on gaining incite into breweries in the United Stated. We will focus on providing information to a national brewery for them to look into investing in the craft brewery industry.

## Data

The data for this study will consist of two databases collected and supplied by our employer.

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

There are 4 folders in the BeersAndBreweries repository:

   1. Data - This folder contains the two databases provided by our client. (Beers.csv, Breweries.csv)
   2. Directives - This folder contains the original request for information. (Case Study 01.docx, CaseStudy1Rubric.docx)
   4. Working - This folder contains the scripts and information used to create our report
   3. The CaseStudy01 folder simply contains the graphics used in this report.

## Questions client would like addressed

   1. How many breweries are present in each state?
   
   2. Merge beer data with the breweries data. Print the first 6 observations and the last six observations to check the merged file.
   
   3. Report the number of NA's in each column.
   
   4. Compute the median alcohol content and international bitterness unit for each state. Plot a bar chart to compare.
   
   5. Which state has the maximum alcoholic (ABV) beer? Which state has the most bitter (IBU) beer?
   
   6. Summary statistics for the ABV variable.
   
   7. Is there an apparent relationship between the bitterness of the beer and its alcoholic content? Draw a scatter plot.
   
## Conclusion

We recommend looking at states other than Colorado, California, Michigan, Oregon, and Texas to start in. Look at states that are not saturated with breweries but with an established beer presence.

IPA’s and Pale Ales would be a great starting point in style. Both are the top selection in the US.

You may need to get more IBU values from the beers you have in the data.

## sessionInfo
R version 3.5.1 (2018-07-02)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows >= 8 x64 (build 9200)
