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

### Turn on the graphics device and produce the plot
png("plot1.png")
hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()
