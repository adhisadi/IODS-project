library(tidyverse)
#1. Load the data sets (BPRS and RATS) into R using as the source the GitHub repository of MABS, where they are given in the wide form:
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

#As before, write the wrangled data sets to files in your IODS-project data-folder.
#at the end

#Also, take a look at the data sets: check their variable names, view the data contents and structures, and create some brief summaries of the variables , so that you understand the point of the wide form data. (1 point)
names(BPRS)
str(BPRS)
glimpse(BPRS)
summary(BPRS)

names(RATS)
str(RATS)
glimpse(RATS)
summary(RATS)

#2. Convert the categorical variables of both data sets to factors. (1 point)

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

#3. Convert the data sets to long form. Add a week variable to BPRS and a Time variable to RATS. (1 point)

BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>% arrange(weeks)
BPRSL <- BPRSL  %>% mutate(week = as.integer(substr(BPRSL$weeks,5,5)))

RATSL <- pivot_longer(RATS, cols=-c(ID,Group), 
                      names_to = "WD",values_to = "Weight")  %>%  
  mutate(Time = as.integer(substr(WD,3,4))) %>% arrange(Time)

#4. Now, take a serious look at the new data sets and compare them with their wide form versions: Check the variable names, view the data contents and structures, and create some brief summaries of the variables. Make sure that you understand the point of the long form data and the crucial difference between the wide and the long forms before proceeding the to Analysis exercise. (2 points)
names(BPRSL)
str(BPRSL)
glimpse(BPRSL)
summary(BPRSL)

names(RATSL)
str(RATSL)
glimpse(RATSL)
summary(RATSL)


write_csv(BPRSL, "data/BPRSL.csv")
write_csv(RATSL, "data/RATSL.csv")


