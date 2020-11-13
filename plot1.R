library(dplyr)
library(lubridate)

dataset<- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")

## check dataset
str(dataset)

##convert date format
dataset$Date <- as.Date(dataset$Date, "%d/%m/%Y")

## We will only be using data from the dates 2007-02-01 and 2007-02-02

dataset<- subset(dataset, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

##combine Date and Time to new col
dataset_adj <-dataset%>% mutate(datetime= strptime(paste(Date, Time, sep=" "), "%Y-%m-%d %H:%M:%S")) %>% mutate(datetime=as.POSIXct(datetime))

## plot1

hist(dataset$Global_active_power,
     main="Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     col="red")

dev.copy(png,"plot1.png", width=480, height=480)
dev.off()