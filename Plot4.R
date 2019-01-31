library(data.table)
#fread() to quickly read in the txt file dataset; use na.strings argument for NA values
hpcFile <- fread("household_power_consumption.txt", na.strings = "?")

#format the dates in the dataset
hpcFile$Date <- as.Date(hpcFile$Date, format = "%d/%m/%Y")

#subset the large dataset to only inlcude data from Feb 1, 2007 and Feb 2, 2007
subsetData <- subset(hpcFile, hpcFile$Date >= "2007-02-01" & hpcFile$Date <= "2007-02-02")

#create a new column that combines Date & Time
subsetData$DateTime <- as.POSIXct(paste(subsetData$Date, subsetData$Time))



#save plot in png format, 480x480 dimensions
png("plot4.png", height = 480, width = 480)

#construct multiple graphs in one window; par(mfrow) creates a vector where the first value is # of rows and the second value is # of columns
par(mfrow = c(2, 2))
with(subsetData, {
  #construct line graph with x-axis as day of week (with no label) and y-axis as Global Active Power
  plot(subsetData$Global_active_power~subsetData$DateTime, type = "l", xlab = "", ylab = "Global Active Power")
  #construct line graph with x-axis as day of week with datetime label and y-axis as Voltage
  plot(subsetData$Voltage~subsetData$DateTime, type = "l", xlab = "datetime", ylab = "Voltage")
  #construct line graph with x-axis as day of week (with no label) and Energy sub metering
  plot(subsetData$Sub_metering_1~subsetData$DateTime, type = "l", xlab = "", ylab = "Energy sub metering")
  #set line color to black
  lines(subsetData$DateTime, subsetData$Sub_metering_1, col = "black")
  #set line color to red
  lines(subsetData$DateTime, subsetData$Sub_metering_2, col = "red")
  #set line color to blue
  lines(subsetData$DateTime, subsetData$Sub_metering_3, col = "blue")
  #create legend in top right corner with the vatiables listed; set line type to solid; line 1 is black, line 2 is red, line 3 is blue; bty = n removes the box from the leged
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2, col=c("black", "red", "blue"), bty="n")
  plot(subsetData$Global_reactive_power~subsetData$DateTime, type = "l", xlab = "datetime", ylab = "Global_reactive_power")  
  
})

#clear the plot
dev.off()