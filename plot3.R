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

##plot3

plot(Sub_metering_1~datetime,dataset_adj, type="l",
     xlab= "",
     ylab= "Global Active Power (kilowatts)")

lines(Sub_metering_2~datetime,dataset_adj,col='Red')
lines(Sub_metering_3~datetime,dataset_adj,col='Blue')

legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()