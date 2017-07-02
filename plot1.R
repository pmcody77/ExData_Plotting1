## Plotting Assignment #1 for Coursera course on Exploratory Data Analysis
## 
## Assumes the UC data set is already downloaded and extracted to working directory

#### Plot1.R

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

## CREATE THE PLOT
hist(subdata$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")

## SAVE AS PNG
dev.copy(png, file = "Plot1.png")
dev.off()
