### Read the data into a temporary file
URL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(URL, temp, "curl")

### Unzip the temporary file into a data frame called 'data'
data <- read.table(unzip(temp), header = TRUE, sep = ";", na.strings = "?")

### Convert the dates into a more easily manipulated format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

### Subset the dates we want
data <- data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"),]

### Combine the times given with the dates given, then use strptime to get something
### we can use to track the data by the minute
data$Time <- strptime(paste(as.character(data$Date), as.character(data$Time)), "%Y-%m-%d %H:%M:%S")

### Turn on the graphics device and produce the plot
png("plot4.png")

### We want 2x2 plots on a single page
par(mfcol = c(2,2))

### First plot, just like the plot in plot2.png
plot(data$Time, data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

### Second plot (lower left), just like the plot in plot3.png
plot(data$Time, data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(data$Time, data$Sub_metering_2, col = "red")
lines(data$Time, data$Sub_metering_3, col = "blue")
legend("topright", box.lwd = 0, lty = "solid", col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

### Third plot (upper right)
plot(data$Time, data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

### Fourth plot (lower right)
plot(data$Time, data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()
