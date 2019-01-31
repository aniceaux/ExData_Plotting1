library(data.table)

#fread() to quickly read in the txt file dataset; use na.strings argument for NA values
hpcFile <- fread("household_power_consumption.txt", na.strings = "?")

#format the dates in the dataset
hpcFile$Date <- as.Date(hpcFile$Date, format = "%d/%m/%Y")

#subset the large dataset to only inlcude data from Feb 1, 2007 and Feb 2, 2007
subsetData <- subset(hpcFile, hpcFile$Date >= "2007-02-01" & hpcFile$Date <= "2007-02-02")

#create a new column that combines Date & Time
subsetData$DateTime <- as.POSIXct(paste(subsetData$Date, subsetData$Time))

#preview the subsetted dataset
head(subsetData)

#write subsetted data to working directory
write.table(subsetData, "household_power_consumption_Feb1-2.txt", sep = ";", row.names = TRUE)



#save plot in png format, 480x480 dimensions
png("plot1.png", height = 480, width = 480)

#construct histogram with title, global active power on x-axis, frequency on the y-axis, and red bars
hist(subsetData$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")

#clear the plot
dev.off()