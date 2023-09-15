---
  title: "MA [46]15 Homework 1 SOLUTIONS"
author: Xinyu Dong
format: gfm
---
  
  In this homework I'm analyzing a small subset of the IPUMS dataset.
I start by loading the packages and the data.

```{r init}
library(tidyverse)
library(ggthemes)
load("ipums_hw_data.RData")
ipums_hw_data
```

Descriptions for the variables in the data set are given below.

| Variable | Description       |
|:--------|:-------------------|
|YEAR     | reports the four-digit year when the household was enumerated or included in the census, the ACS, and the PRCS. |
|SERIAL   | An identifying number unique to each household record in a given sample. |
|HHINCOME | Reports the total money income of all household members age 15+ during the previous year. |
|PERWT    | Indicates how many persons in the U.S. population are represented by a given person in an IPUMS sample. |
|RACE     | Simple version of race. The concept of race has changed over the more than 150 years represented in IPUMS. Currently, the Census Bureau and others consider race to be a sociopolitical construct, not a scientific or anthropological one. Many detailed categories consist of national origin groups. |
|RACED    | Detailed version of race.  |
|POVERTY  | Expresses each family's total income for the previous year as a percentage of the poverty thresholds established by the Social Security Administration. |
  |SPMPOV   | Indicates whether a family is classified as poor according to the Supplemental Poverty Measure (SPM). |
  
  The number of observations in the data set is less than 0.01% of the full IPUMS data for the relevant years.
This data was collected from [IPUMS USA](https://usa.ipums.org/) and was cleaned and reduced in size to improve ease-of-use.
You can search for individual variables [here](https://usa.ipums.org/usa-action/variables/search).




## Question 1
```{r q1}
ggplot(data = ipums_hw_data, aes(x = log(HHINCOME), y = log(POVERTY))) + 
  geom_point(aes(color = RACE),alpha = 0.25) +
  scale_color_colorblind()
```
From the graph above, there is a positive linear relationship between the two variables.


## Question 2
```{r q2}
ggplot(ipums_hw_data, aes(x = HHINCOME, y = RACE, color = RACE)) +
  geom_boxplot(varwidth = TRUE) +
  scale_color_colorblind(guide = guide_none())
```


## Question 3
```{r q3}
ggplot(ipums_hw_data, aes(x = RACE, fill = SPMPOV, weight = PERWT)) +
  geom_bar(position = "fill") +
  theme(axis.text.x = element_text(angle = 15)) +
  scale_y_continuous(labels = scales::percent_format(scale = 100), name = "proportion") +
  scale_fill_discrete(name=NULL)
```
The `position = "fill"` in the `geom_bar` call sets the position of the bars to represent the weighted proportion of observations while the `weight = PERWT` in the `aes` call helps to set PERWT as the weight of the observations.


## Question 4
  ```{r q4}
knitr::include_graphics("raced_vs_mean_hhincome.svg")
rmean <- aggregate(HHINCOME ~ RACE + RACED, data = ipums_hw_data, FUN = mean)
ggplot(ipums_hw_data, aes(x = HHINCOME, y = RACE, color = RACE)) +
  geom_point(data = rmean, aes(x = HHINCOME, y = RACE)) + 
  stat_summary(fun = "mean", geom = "point", color = "black", size = 4, alpha = 0.4) +
  scale_x_continuous(labels = scales::dollar_format(prefix = "$", suffix = "k", scale = 0.001)) +
  labs(title = "Mean household income by detailed race", subtitle = "Large grey dots are means for simplified race variable", x = "mean household income", y = "") +
  scale_color_discrete(guide = guide_none())
```
Compared to figure 8, the figure above shows fewer details. 



