# data wrangling

setwd("/Users/admin_adhisadi/workspace/School_work/IODS-project/data/")

#Load the ‘human’ data into R. Explore the structure and the dimensions of the data and describe the dataset briefly, assuming the reader has no previous knowledge of it (this is now close to the reality, since you have named the variables yourself). (0-1 point)
human <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human1.txt", 
                    sep =",", header = T)
str(human)
dim(human)
#195 rows 19 columns

#This dataset is human development index. Human Development Index (HDI)
#The HDI was created to emphasize that people and their capabilities should be the ultimate criteria for assessing the development of a country, not economic growth alone.
#Details of the dataset can be found here: https://hdr.undp.org/data-center/human-development-index#/indicies/HDI
#One can explore the dataset further in the same link.
#Other technical details found here: https://hdr.undp.org/system/files/documents//technical-notes-calculating-human-development-indices.pdf

# HDI.Rank: Human Development Index rank as the name suggests.    
# Life.Exp: Life expectancy at birth.   
# Edu.Exp : Expected years of schooling.        
# Edu.Mean: Mean years of schooling.      
# GNI: Gross national income (GNI) per capita.        
# GNI.Minus.Rank : GNI per capita rank minus HDI rank. 
# GII: Gender Inequality Index. 
# GII.Rank: Gender Inequality Index rank.     
# Mat.Mor :Maternal Mortality Ratio.    
# Ado.Birth : Adolescent Birth Rate. 
# Parli.F :Percent Representation in Parliament.
# Edu2.F : Female populations with secondary education.
# Edu2.M: Male populations with secondary education. 
# Labo.F  :labor force participation rate of females.  
# Labo.M  : labor force participation rate of males. 
# Edu2.FM : ratio of Female and Male populations with secondary education in each country.    
# Labo.FM :ratio of labor force participation of females and males in each country.

#Mutate the data: transform the Gross National Income (GNI) variable to numeric (using string manipulation). Note that the mutation of 'human' was NOT done in the Exercise Set. (1 point)
library(stringr)
str(human$GNI)
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric(human$GNI)
str(human$GNI)

#Exclude unneeded variables: keep only the columns matching the following variable names (described in the meta file above):  "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F" (1 point)
# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(keep))
complete.cases(human)
data.frame(human[-1], comp = complete.cases(human))

#Remove all rows with missing values (1 point).
human <- filter(human, complete.cases(human))

#Remove the observations which relate to regions instead of countries. (1 point)
# It looks like the last 7 observations are regions.
last <- nrow(human) - 7
human <- human[1:last, ]
#Define the row names of the data by the country names and remove the country name column from the data. The data should now have 155 observations and 8 variables. Save the human data in your data folder including the row names. You can overwrite your old ‘human’ data. (1 point)
rownames(human) <- human$Country
human <- select(human, -Country)
dim(human)
#155 row  8 columns
write.table(human, "human.txt", row.names = T) 

#checking
human2 <- read.table("human.txt")
dim(human2)
# 155 rows  8 columns

human3 <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human2.txt", 
                    sep =",", header = T)
identical(human2, human3)

