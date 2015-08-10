plot4 <- function() {
    
    # Download the data
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    temp <- tempfile()
    download.file(url, temp)
    data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", header = T)
    unlink(temp)
    
    # Set the column formats and subset for dates we need
    data$Date <- as.Date(data$Date, '%d/%m/%Y')
    data$Global_active_power <- as.numeric(data$Global_active_power)
    data$Voltage <- as.numeric(data$Voltage)
    data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
    dataToUse <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")
    dataToUse$DateTime <- as.POSIXct(paste(dataToUse$Date, dataToUse$Time), format <- '%Y-%m-%d %H:%M:%S')
    
    # Create and save the plot
    png("plot4.png", width=480, height=480)
    
    # Set the grid for the plots
    par(mfrow=c(2, 2))
    
    # Get the first plot
    plot(x = dataToUse$DateTime, y = dataToUse$Global_active_power, col = "transparent", ylab = "Global Active Power (kilowatts)", xlab = '')
    lines(x = dataToUse$DateTime, y = dataToUse$Global_active_power)
    
    # Get the second plot
    plot(range(dataToUse$DateTime), range(dataToUse$Voltage), xlab = "datetime", ylab = "Voltage", type="n")
    lines(x = dataToUse$DateTime, y = dataToUse$Voltage)
    
    # Get the third plot
    plot(x = dataToUse$DateTime, y = dataToUse$Sub_metering_1, col = "transparent", ylab = "Energy sub metering", xlab = '')
    lines(x = dataToUse$DateTime, y = dataToUse$Sub_metering_1)
    lines(x = dataToUse$DateTime, y = dataToUse$Sub_metering_2, col = "Red")
    lines(x = dataToUse$DateTime, y = dataToUse$Sub_metering_3, col = "Blue")
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), lwd = c(2.5, 2.5, 2.5), col = c("Black", "Red", "Blue"), bty = "n")
    
    # Get the fourth plot
    plot(dataToUse$DateTime, dataToUse$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type="l")
    
    dev.off()
}