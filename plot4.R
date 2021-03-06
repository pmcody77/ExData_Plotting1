## Plotting Assignment #1 for Coursera course on Exploratory Data Analysis
## 
## Assumes the UC data set is already downloaded and extracted to working directory

#### Plot4.R

#####
##  Loading and preparing the data frame to plot from
#####
#set coltypes so numeric columns come in as numbers not characters when loaded in (but date must be converted)
coltypes <- c("character", "character", "double", "double","double","double","double","double","double") 
hhdata <- read.table("household_power_consumption.txt", header = TRUE, sep=";", colClasses = coltypes, na.strings = c("?"))
#convert date and time variables from characters to one variable called datetime
hhdata$datetime <- strptime(paste(hhdata$Date,hhdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
#subset the dataframe to the dates of interest
startdate <- strptime("2007-02-01", "%Y-%m-%d")
enddate <- strptime("2007-02-03", "%Y-%m-%d")  #will use < this date, thus including the 2nd
hhdata$includedate <- (hhdata$datetime >= startdate & hhdata$datetime < enddate)
subdata <- subset(hhdata, includedate == TRUE)

png("Plot4.png",  width = 480, height = 480, units = "px")

## Set up for four plots
par(mfrow = c(2,2))

## CREATE THE PLOT(s)
## plot 1:
plot(subdata$datetime, subdata$Global_active_power, ylab="Global Active Power (kilowatts)", xlab = "", type="l")

## plot 2:
plot(subdata$datetime, subdata$Voltage, ylab="Voltage", xlab = "datetime", type="l")

## plot 3:
plot(subdata$datetime, subdata$Sub_metering_1, ylab="Energy sub metering", xlab = "", type="l")
lines(subdata$datetime, subdata$Sub_metering_2, col="red", type="l")
lines(subdata$datetime, subdata$Sub_metering_3, col="blue", type="l")
legend("topright", lwd = c(1,1,1), col = c("black", "red", "blue"), bty="n", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

## plot 4:
plot(subdata$datetime, subdata$Global_reactive_power, ylab="Global_reactive_power", xlab = "datetime", type="l")

## SAVE AS PNG
dev.off()
