## Reading dataset, assuming dataset file is in working directory
dataset <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
set1 <- dataset[dataset$Date == "1/2/2007",]
set2 <- dataset[dataset$Date == "2/2/2007",]
set3 <- rbind(set1, set2)

## Setting time and date values in appropriate classes
set3$Date <- as.Date(set3$Date, "%d/%m/%Y")
set3$Time <- strptime(set3$Time, "%H:%M:%S")
set3$Time <- format(set3$Time, "%T")

## Coercing character vectors to numeric
set3$Global_active_power <- as.numeric(as.character(set3$Global_active_power))

## Plotting graph
hist(set3$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px")
dev.off()