plot1 <- function() {
    
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
    
    # Create and save the histogram
    png("plot1.png", width=480, height=480)
    hist(dataToUse$Global_active_power / 1000, col = "Red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
    dev.off()
}