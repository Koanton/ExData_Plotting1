##clean global environment
rm(list=ls())
setwd("C:/Users/anton/Documents/Data Science/Coursera Data Science/Course 4/Assignment 1")

# download and unzip the data file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", header=TRUE, colClasses=c("character","character","double","double","double","double","double","double","numeric"),na.strings="?")
unlink(temp)

# Create a new variable DateTime by adding Date and Time
data$DateTime<-paste(data$Date, data$Time)
# Format DateTime appropriately
data$DateTime<-as.POSIXlt(data$DateTime, format="%d/%m/%Y %H:%M:%S")

# Delete old Date and Time columns
data$Date<-NULL
data$Time<-NULL

# Keep only the relevant data
subData<-subset(data, data$DateTime>="2007-02-01 00:00:00" & data$DateTime<="2007-02-02 23:59:59")

# Create a 1x1 chart
par(mfrow=c(1,1))

# Create a line plot
plot(subData$DateTime, subData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

# Copy the chart to PNG
dev.copy(png, file="plot2.png")

# Disconnect PNG devide
dev.off()