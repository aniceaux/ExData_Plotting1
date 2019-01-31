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
png("plot3.png", height = 480, width = 480)

#construct line graph with x-axis as day of week (with no label) and y-axis as "Energy sub metering"
plot(subsetData$Sub_metering_1~subsetData$DateTime, type = "l", xlab = "", ylab = "Energy sub metering")
#set line color to black
lines(subsetData$DateTime, subsetData$Sub_metering_1, col = "black")
#set line color to red
lines(subsetData$DateTime, subsetData$Sub_metering_2, col = "red")
#set line color to blue
lines(subsetData$DateTime, subsetData$Sub_metering_3, col = "blue")
#create legend in top right corner with the vatiables listed; set line type to solid; line 1 is black, line 2 is red, line 3 is blue
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1 ,col=c("black", "red", "blue"))

#clear the plot
dev.off()