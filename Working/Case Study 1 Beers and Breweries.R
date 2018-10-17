---
  title: 'Case Study 1: Beers and Breweries'
author: "Ryan Paul"
date: "10/13/2018"
output: html_document
---
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = FALSE)
```
```{r librariesAndHelpers}
library(dplyr)
library(ggplot2)
library(reshape2)
#function to trim white space
trim <- function (x) gsub("^\\s+|\\s+$", "", x)
```
# Case Study 1
## How many breweries are present in each state?
Below you can see how many "craft" breweries are in each state.
```{r breweriesByState}
#Load in the breweries data
breweryData <- read.csv("Data/Breweries.csv")
breweryData$State <- trim(breweryData$State)
#Check for empty states
breweriesWithNoState <- breweryData[is.na(breweryData$State),]
#There are none
#Group breweries by state and provide a count
stateGroupedBreweryData <- breweryData %>%
  group_by(State) %>%
  count()
#Changing column name of count
names(stateGroupedBreweryData)[2] <- "BreweriesCount"
#Creating a bar chart and ordering by states descending
stateBreweryCountBarChart <- ggplot(data=stateGroupedBreweryData,
                                    aes(x=reorder(State,-BreweriesCount), y=BreweriesCount, fill = State)) +
  geom_bar(stat="identity") +
  labs(y = "Craft Breweries", x = "State") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        plot.title = element_text(hjust = 0.5)) +
  ggtitle("Number of Craft Breweries by State") +
  guides(fill=FALSE) # Removing legend
stateBreweryCountBarChart
```
## Merge beer data with the breweries data. Print the first 6 observations and the last six observations to check the merged file. HOW DO WE SPRUCE THIS UP?
Merging the Beer and Brewery data sets on the Brewery ID (`Brewery_id in the beer data and Brew_ID in the brewery dataset). Once merged we open up new areas of analysis beyond just analyzing the beers or breweries and their locations on their own.
```{r mergingBeerAndBreweries}
beerData <- read.csv("Data/Beers.csv")
beerAndBreweryData <- merge(breweryData, beerData, by.x="Brew_ID", by.y="Brewery_id")
head(beerAndBreweryData, 6)
tail(beerAndBreweryData, 6)
```
## Report the number of NA's in each column
Running a function on all columns to create a new dataframe with columns and a count of NA values.
```{r nasByColumn}
na_count <-sapply(beerAndBreweryData, function(rowval) sum(length(which(is.na(rowval)))))
na_count <- data.frame(na_count)
na_count
```
## Compute the median alcohol content and international bitterness unit for each state. Plot a bar chart to compare.
The data will be regrouped by state, summarized while ignoring NA values, and plotted on a barchart.
```{r medianAbvAndIbuPerState}
#Group and summarize data, get the median of abv and ibu and ignore NA
beerSummaryByState <- beerAndBreweryData %>%
  group_by(State) %>%
  summarise(MedianABV = median(ABV, na.rm = TRUE), MedianIBU = median(IBU, na.rm = TRUE)) %>%
  as.data.frame()
#melting medians together for grouped barchart
beerSummaryByStateMelt <- melt(beerSummaryByState[,c("State", "MedianABV", "MedianIBU")], value.name = "MedianValue")
#Actually never mind, that doesn't make any sense, abv is supa small
#Median ABV plot, There are no NA ABVs but just in case they do in the future
medianAbvByStateBarChart <- ggplot(data=beerSummaryByState[!is.na(beerSummaryByState$MedianABV),],
                                   aes(x=reorder(State, -MedianABV), y=MedianABV, fill = State)) +
  geom_bar(stat="identity") +
  labs(y = "Median ABV (UNITS???)", x = "State") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        plot.title = element_text(hjust = 0.5)) +
  ggtitle("Median ABV of Craft Beers by State") +
  guides(fill=FALSE) # Removing legend
medianAbvByStateBarChart
#Median IBU Bar Plot. Removing SD because it has NA for IBU
medianIbuByStateBarChart <- ggplot(data=beerSummaryByState[!is.na(beerSummaryByState$MedianIBU),] , 
                                   aes(x=reorder(State, -MedianIBU), y=MedianIBU, fill = State)) +
  geom_bar(stat="identity") +
  labs(y = "Median IBU (UNITS???)", x = "State") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        plot.title = element_text(hjust = 0.5)) +
  ggtitle("Median IBU of Craft Beers by State") +
  guides(fill=FALSE) # Removing legend
medianIbuByStateBarChart
```
## Which state has the maximum alcoholic (ABV) beer? Which state has the most bitter (IBU) beer?
We will add some columns to the state summary beer data frame we have above.
```{r maxAbvAndMaxIbu}
#resummarizing state grouped data to add max
beerSummaryByState <- beerAndBreweryData %>%
  group_by(State) %>%
  summarise(MedianABV = median(ABV, na.rm = TRUE), MedianIBU = median(IBU, na.rm = TRUE), MaxABV = max(ABV, na.rm = TRUE), MaxIBU = max(IBU, na.rm = TRUE)) %>%
  as.data.frame()
#Plot the Max ABV, running is.finite because getting the max of NA give -Int, not an issue for ABV, but just to be consistent and if the data from one state is missing like SD's IBU, i'll keep it in.
maxAbvByStateBarChart <- ggplot(data=beerSummaryByState[is.finite(beerSummaryByState$MaxABV),],
                                aes(x=reorder(State, -MaxABV), y=MaxABV, fill = State)) +
  geom_bar(stat="identity") +
  labs(y = "Max ABV (UNITS???)", x = "State") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        plot.title = element_text(hjust = 0.5)) +
  ggtitle("Max ABV of Craft Beers by State") +
  guides(fill=FALSE) # Removing legend
maxAbvByStateBarChart
#Max IBU Bar Plot. Removing SD because it has -Inf for IBU
maxIbuByStateBarChart <- ggplot(data=beerSummaryByState[is.finite(beerSummaryByState$MaxIBU),] , 
                                aes(x=reorder(State, -MaxIBU), y=MaxIBU, fill = State)) +
  geom_bar(stat="identity") +
  labs(y = "Max IBU (UNITS???)", x = "State") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        plot.title = element_text(hjust = 0.5)) +
  ggtitle("Max IBU of Craft Beers by State") +
  guides(fill=FALSE) # Removing legend
maxIbuByStateBarChart
```
## Summary Statistics for the ABV variable
Simply running `summary` on the abv column with NAs removed.
```{r summaryStatsAbv}
summary(beerAndBreweryData[!is.na(beerAndBreweryData$ABV),]$ABV)
```
## Is there an apparent relationship between the bitterness of the beer and its alcoholic content? Draw a scatter plot.
Making a scatter plot with IBU as the X and ABV as the Y.
```{r abvVsIbu}
#Median IBU Bar Plot. Removing SD because it has NA for IBU
abvVsIbuScatterPlot <- ggplot(data=beerAndBreweryData[complete.cases(beerAndBreweryData),] , 
                              aes(x=IBU, y=ABV), fill=State) +
  geom_point(stat="identity") +
  labs(y = "IBU (UNITS???)", x = "ABV") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        plot.title = element_text(hjust = 0.5)) +
  ggtitle("IBU vs ABV of Craft Beers") +
  guides(fill=FALSE) # Removing legend
abvVsIbuScatterPlot