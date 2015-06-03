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
png(filename = "plot4.png", width=480, height=480, bg = "transparent")

#split into quadrants
par(mfrow = c(2, 2))

# construct plots
plot(plotData$dateTime,plotData$Global_active_power, type = "l",
  ylab = "Global Active Power", xlab = "")

plot(plotData$dateTime,plotData$Voltage, type = "l",
  ylab = "Voltage", xlab = "datetime")

plot(plotData$dateTime, plotData$Sub_metering_1, type = "l",
     ylab = "Energy sub metering", xlab = "")
lines(plotData$dateTime, plotData$Sub_metering_2, type="l", col="Red")
lines(plotData$dateTime, plotData$Sub_metering_3, type="l", col="Blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2",
  "Sub_metering_3"), lty = 1, bty = "n",
  col = c("black", "red", "blue"))

plot(plotData$dateTime,plotData$Global_reactive_power, type = "l",
  xlab = "datetime", ylab = "Global_reactive_power")

# turn off device
dev.off()
