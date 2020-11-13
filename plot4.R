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


##plot4
par(mfrow=c(2,2))

# Plot4-1

plot(Global_active_power ~ datetime, dataset_adj, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

# Plot4-2

plot(Voltage ~ datetime, dataset_adj, type = "l")

# Plot4-3

plot(Sub_metering_1 ~ datetime, dataset_adj, type = "l",
     ylab = "Energy sub metering",
     xlab = "")

lines(Sub_metering_2~datetime,dataset_adj,col='Red')
lines(Sub_metering_3~datetime,dataset_adj,col='Blue')

legend("topright", col=c("black", "red", "blue"), lty=1:1, lwd=1, bty="n",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot4-4

plot(Global_reactive_power ~ datetime, dataset_adj, type = "l")


dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
