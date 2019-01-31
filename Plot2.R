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
png("plot2.png", height = 480, width = 480)

#construct line graph with x-axis as day of week (with no label) and y-axis as Global Active Power (kilowatts)
plot(subsetData$Global_active_power~subsetData$DateTime, type = "l", xlab = " ", ylab = "Global Active Power (kilowatts)")

#clear the plot
dev.off()