aoraw <- read.csv("appleorange.csv", stringsAsFactors=FALSE, header=FALSE)
head(aoraw,10); tail(aoraw,10)

## Viewing data and found the data lies in 3-700 rows
aodata<-aoraw[3:700,]
head(aodata,10); tail(aodata,10)

## Giving column names
names(aodata)<-c("country", "countrynumber", "products", "productnumber", "tonnes", "year")

## Here Country number are taken as a character value
aodata$countryNumber<-as.numeric(aodata$countryNumber)

## remove rows which says "Food supply quantity (tonnes) (tonnes)"
fslines <- which(aodata$country == "Food supply quantity (tonnes) (tonnes)")
## -ve index select rows except those rows
aodata <- aodata[(-1 * fslines),]

## remove extra text from the tonnes column
aodata$tonnes <- gsub("\xca", "", aodata$tonnes)
aodata$tonnes <- gsub(", tonnes \\(\\)", "", aodata$tonnes)

## convert tonnes column to numeric
aodata$tonnes<-as.numeric(aodata$tonnes)

## giving random year to the data, since whole column was empty
aodata$year <- 2009

## apples <- aodata[aodata$productnumber == 2617, c(1,2,5)]
## names(apples)[3] <- "apples"
## oranges <- aodata[aodata$productnumber == 2611, c(2,5)]
## names(oranges)[2] <- "oranges"
## cleanao2 <- merge(apples, oranges, by="countrynumber", all=TRUE)

library(reshape2)
cleanao3 <- dcast(aodata[,c(1:3,5)], formula = country + countrynumber ~ products, value.var="tonnes")
names(cleanao3)[3:4] <- c("apples", "oranges")

