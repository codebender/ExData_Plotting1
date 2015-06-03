# load dependencies
library(lubridate)

# read data
powerData <- read.table("household_power_consumption.txt", header = T,
  sep = ";", na.strings = "?",
  colClasses=c(rep("character",2), rep("numeric",7)))

# create datetime parsed with lubridate
powerData$dateTime <- dmy_hms(paste(powerData$Date, powerData$Time))
powerData$Date <- NULL
powerData$Time <- NULL

# subset to Date range 02/01/2007 - 02/02/2007
plotData <- powerData[powerData$dateTime >= ymd("2007-02-01") &
                        powerData$dateTime < ymd("2007-02-03"), ]

#set device to png device
png(filename = "plot2.png", width=480, height=480, bg = "transparent")
# construct plot
plot(plotData$dateTime,plotData$Global_active_power, type = "l",
  ylab = "Global Active Power (kilowatts)", xlab = "")
# turn off device
dev.off()
