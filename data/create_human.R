#Read in the “Human development” and “Gender inequality” data sets. Here are the links to the datasets:
setwd("workspace/School_work/IODS-project/data/")
library(tidyverse)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

#Meta file for these datasets can be seen here, and here are some technical notes. (1 point)
  #Explore the datasets: see the structure and dimensions of the data. Create summaries of the variables. (1 point)
str(hd)
dim(hd) #195 row 8 columns
str(gii)
dim(gii) #195 row 10 columns
  
#Look at the meta files and rename the variables with (shorter) descriptive names. (1 point)
hd <- rename(hd, 
             "HDI_R" = "HDI Rank",
             "HDI" = "Human Development Index (HDI)",
             "Life_Expectancy" = "Life Expectancy at Birth",
             "Expected_Edu_Year" = "Expected Years of Education", 
             "Edu_Mean_Years" = "Mean Years of Education",
             "GNI" = "Gross National Income (GNI) per Capita",
             "GNI_R_HDI_R" = "GNI per Capita Rank Minus HDI Rank"
             )
  
gii <- rename(gii,
              "GII_R" = "GII Rank",
              "GII" = "Gender Inequality Index (GII)",
              "Maternal_Mort" = "Maternal Mortality Ratio",
              "Adol_Birth" = "Adolescent Birth Rate",
              "Parl_Repr" = "Percent Representation in Parliament",
              "Edu_F" = "Population with Secondary Education (Female)",
              "Edu_M" = "Population with Secondary Education (Male)",
              "Labour_F" = "Labour Force Participation Rate (Female)",
              "Labour_M" = "Labour Force Participation Rate (Male)"
              )

#Mutate the “Gender inequality” data and create two new variables. The first one should be the ratio of Female and Male populations with secondary education in each country. (i.e. edu2F / edu2M). The second new variable should be the ratio of labor force participation of females and males in each country (i.e. labF / labM). (1 point)
gii <-  mutate(gii, 
               "Edu_F_M" = Edu_F / Edu_M,
               "Labour_F_M" = Labour_F / Labour_M)


#Join together the two datasets using the variable Country as the identifier. Keep only the countries in both data sets (Hint: inner join). The joined data should have 195 observations and 19 variables. Call the new joined data "human" and save it in your data folder. (1 point)
human <- inner_join(hd,gii, by="Country")
dim(human) #195 17

write_csv(human, "human.csv")

