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
png("plot3.png")
plot(data$Time, data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(data$Time, data$Sub_metering_2, col = "red")
lines(data$Time, data$Sub_metering_3, col = "blue")
legend("topright", lty = "solid", col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
