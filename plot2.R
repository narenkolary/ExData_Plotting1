## Reading dataset, assuming dataset file is in working directory
dataset <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
set1 <- dataset[dataset$Date == "1/2/2007",]
set2 <- dataset[dataset$Date == "2/2/2007",]
set3 <- rbind(set1, set2)

## Setting time and date values in appropriate classes
set3$Date <- as.Date(set3$Date, "%d/%m/%Y")
set3$Time <- strptime(set3$Time, "%H:%M:%S")
set3$Time <- format(set3$Time, "%T")
set4 <- within(set3, {timestamp = format(as.POSIXct(paste(set3$Date, set3$Time)), "%y-%m-%d %H:%M:%S")})

## Coercing character vectors to numeric
set4$Global_active_power <- as.numeric(as.character(set4$Global_active_power))
set4$Global_active_power[set4$Global_active_power == "?"] <- NA
set4$timestamp <- as.POSIXct(as.character(set4$timestamp))
set5 <- na.omit(set4)

## Plotting graph
plot(set5$timestamp, set5$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = 'l')
dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px")
dev.off()