plot2 <- function() {
    
    # Download the data
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    temp <- tempfile()
    download.file(url, temp)
    data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", header = T)
    unlink(temp)
    
    # Set the column formats and subset for dates we need
    data$Date <- as.Date(data$Date, '%d/%m/%Y')
    data$Global_active_power <- as.numeric(data$Global_active_power)
    dataToUse <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")
    dataToUse$DateTime <- as.POSIXct(paste(dataToUse$Date, dataToUse$Time), format <- '%Y-%m-%d %H:%M:%S')
    
    # Create and save the plot
    png("plot2.png", width=480, height=480)
    plot(x = dataToUse$DateTime, y = dataToUse$Global_active_power, col = "transparent", ylab = "Global Active Power (kilowatts)", xlab = '')
    lines(x = dataToUse$DateTime, y = dataToUse$Global_active_power)
    dev.off()
}