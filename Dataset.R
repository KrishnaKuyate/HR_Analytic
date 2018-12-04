##Data Load and dataset structures:


###Data Load:
library(readr)
google <- read_csv("google.csv")
View(google)
amazon <- read_csv("amazon.csv")
View(amazon)


###Unserstand the dataset structure:
##Google:
#Structure
str(google)
#No. of variables:
ncol(google)
#No.of observations:
nrow(google)
#Variables name of dataset:
colnames(google)
#Summary:
summary(google)

##amazon:
#structure:
str(amazon)
#No.of variables:
ncol(amazon)
#Variables Name:
colnames(amazon)
#No. of obesarvations:
nrow(amazon)
#Summary
summary(amazon)


##Variable Defined:
#Amazons
amazon_pros<-amazon$pros
amazon_cons<-amazon$cons
#Google:
google_pros<-google$pros
google_cons<-google$cons











