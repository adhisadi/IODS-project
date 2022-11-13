#Sadiksha Adhikari
#09-11-2022
#This R file is for Data wrangling exercise for assignment 2: Regression and model validation

## During the data wrangling exercises you will pre-process a data set for further analysis. To complete the data wrangling part, you only need to produce an R script, no output in your course diary is needed. Use code comments to make your code easier to read. Always write your name, date and a one sentence file description as a comment on the top of the R script (include a reference to the data source). We recommend using RStudio for writing R code.

## Create a folder named ‘data’ in your IODS-project folder. Then create a new R script with RStudio. Write your name, date and a one sentence file description as a comment on the top of the script file. Save the script for example as 'create_learning2014.R' in the ‘data’ folder. Complete the rest of the steps in that script.


library(tidyverse)

## Read the full learning2014 data from http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt into R (the separator is a tab ("\t") and the file includes a header) and explore the structure and dimensions of the data. Write short code comments describing the output of these explorations. (1 point)
dataset <- read.table("https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep= "\t", header = T)
dim(dataset)
#The dataset contains 183 rows and 60 columns
str(dataset)
#All columns except gender are integers i.e numeral values. Gender has categorical data with characters. 

## Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points by combining questions in the learning2014 data, as defined in the Exercise Set and also on the bottom part of the following page (only the top part of the page is in Finnish). http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS2-meta.txt. Scale all combination variables to the original scales (by taking the mean). Exclude observations where the exam points variable is zero. (The data should then have 166 observations and 7 variables) (1 point)
dataset <- dataset %>% mutate(d_sm = D03+D11+D19+D27) %>% mutate(d_ri = D07+D14+D22+D30) %>% mutate(d_ue = D06+D15+D23+D31) %>% mutate(deep = d_sm+d_ri+d_ue)
dataset <-dataset %>% mutate(deep= deep/12) #n=12 comes from 12 variables that have been summed up to come up with variable deep, basically I am calculating mean here sum/n.

dataset <- dataset %>% mutate(st_os = ST01+ST09+ST17+ST25) %>% mutate(st_tm = ST04+ST12+ST20+ST28) %>% mutate(stra = st_os+st_tm)
dataset <-dataset %>% mutate(stra= stra/8) ##n=8 comes from 8 variables that have been summed up to come up with variable stra, basically I am calculating mean here sum/n

dataset <- dataset %>% mutate(su_lp = SU02+SU10+SU18+SU26) %>% mutate(su_um = SU05+SU13+SU21+SU29) %>% mutate(su_sb = SU08+SU16+SU24+SU32) %>% mutate(surf = su_lp+su_um+su_sb)
dataset <-dataset %>% mutate(surf= surf/12) ##n=12 comes from 12 variables that have been summed up to come up with variable surf, basically I am calculating mean here sum/n

#dataset <- dataset %>% mutate(Attitude = Da+Db+Dc+Dd+De+Df+Dg+Dh+Di+Dj) #not required as Attitude variable has already been calculated
dataset <- dataset %>% mutate(Attitude = Attitude/10) ##n=10 comes from 10 variables that have been summed up to come up with variable Attitude, basically I am calculating mean here sum/n


dataset <- dataset %>% select(gender, Age, Attitude, deep, stra, surf, Points)
dataset <- dataset %>% filter(Points > 0)

## Set the working directory of your R session to the IODS Project folder (study how to do this with RStudio). Save the analysis dataset to the ‘data’ folder, using for example write_csv() function (readr package, part of tidyverse). You can name the data set for example as learning2014.csv. See ?write_csv for help or search the web for pointers and examples. Demonstrate that you can also read the data again by using read_csv().  (Use `str()` and `head()` to make sure that the structure of the data is correct).  (3 points)
setwd("/Users/admin_adhisadi/workspace/School_work/IODS-project")
getwd()
#"/Users/admin_adhisadi/workspace/School_work/IODS-project"
write.csv(dataset, "data/assignment2_regression_and_model_validation_data_wrangling.csv", row.names = F)
learning2014 <- read.csv("data/assignment2_regression_and_model_validation_data_wrangling.csv")

str(learning2014)
str(learning2014)

head(learning2014)
head(dataset)
#learning2014 and dataset are same
