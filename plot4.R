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
set4$Sub_metering_1 <- as.numeric(as.character(set4$Sub_metering_1))
set4$Sub_metering_1[set4$Sub_metering_1 == "?"] <- NA
set4$Sub_metering_2 <- as.numeric(as.character(set4$Sub_metering_2))
set4$Sub_metering_2[set4$Sub_metering_2 == "?"] <- NA
set4$Sub_metering_3 <- as.numeric(as.character(set4$Sub_metering_3))
set4$Sub_metering_3[set4$Sub_metering_3 == "?"] <- NA
set4$Global_active_power <- as.numeric(as.character(set4$Global_active_power))
set4$Global_active_power[set4$Global_active_power == "?"] <- NA
set4$Voltage <- as.numeric(as.character(set4$Voltage))
set4$Voltage[set4$Voltage == "?"] <- NA
set4$Global_reactive_power <- as.numeric(as.character(set4$Global_reactive_power))
set4$Global_reactive_power[set4$Global_reactive_power == "?"] <- NA
set4$timestamp <- as.POSIXct(as.character(set4$timestamp))
set5 <- na.omit(set4)

## Plotting graph
par(mfrow=c(2,2))
plot(set5$timestamp, set5$Global_active_power, xlab = "", ylab = "Global Active Power", type = 'l')
plot(set5$timestamp, set5$Voltage, xlab = "datetime", ylab = "Voltage", type = 'l')
plot(set5$timestamp, set5$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = 'l')
lines(set5$timestamp, set5$Sub_metering_2, col = "red")
lines(set5$timestamp, set5$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(set5$timestamp, set5$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = 'l')
dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px")
dev.off()