#Sadiksha Adhikari
#21-11-2022
#Data downloaded from: https://archive.ics.uci.edu/ml/datasets/Student+Performance > Download: Data Folder
library(dplyr)

#Create a new R script with RStudio. Write your name, date and a one sentence file description as a comment on the top of the script (include a reference to the data source). Save the script as 'create_alc.R' in the ‘data’ folder of your project. Complete the rest of the steps in that script.
#done 

#Read both student-mat.csv and student-por.csv into R (from the data folder) and explore the structure and dimensions of the data. (1 point)
setwd("workspace/School_work/IODS-project/data/")
math <- read.table("student-mat.csv", sep = ";" , header=TRUE)
str(math)
dim(math)

por <- read.table("student-por.csv", sep = ";", header = TRUE)
str(por)
dim(por)

#Join the two data sets using all other variables than "failures", "paid", "absences", "G1", "G2", "G3" as (student) identifiers. Keep only the students present in both data sets. Explore the structure and dimensions of the joined data. (1 point)
#library(dplyr)
joining_columns1 <- colnames(por)
joining_columns2 <- colnames(math)
joining_columns <- c(joining_columns1, joining_columns2)
donot_use <- c("failures", "paid", "absences", "G1", "G2", "G3")
joining_columns <- joining_columns [! joining_columns  %in% donot_use]
joining_columns <- unique(joining_columns)
math_por <- inner_join(math, por, by = joining_columns, suffix = c(".math", ".por"))
colnames(math_por)
glimpse(math_por)
str(math_por)


#Get rid of the duplicate records in the joined data set. Either a) copy the solution from the exercise "3.3 The if-else structure" to combine the 'duplicated' answers in the joined data, or b) write your own solution to achieve this task. (1 point)
alc <- select(math_por, one_of(joining_columns))
for(column_name in donot_use) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

glimpse(alc)


#Take the average of the answers related to weekday and weekend alcohol consumption to create a new column 'alc_use' to the joined data. Then use 'alc_use' to create a new logical column 'high_use' which is TRUE for students for which 'alc_use' is greater than 2 (and FALSE otherwise). (1 point)
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)


#Glimpse at the joined and modified data to make sure everything is in order. The joined data should now have 370 observations. Save the joined and modified data set to the ‘data’ folder, using for example write_csv() function (readr package, part of tidyverse). (1 point)
glimpse(alc)
dim(alc)
#370 35
write.csv(alc, file = "math_por.csv",row.names = F )
