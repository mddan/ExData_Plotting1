# Create new data folder, download assignment data and extract files to the relevant directory:

if(!file.exists("./A1_data")){dir.create("./A1_data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./A1_data/raw.zip")
unzip(zipfile="./A1_data/raw.zip",exdir="./A1_data")

# Read and transform data, in preparation for analysis

## Create the raw data
raw <- read.table("./A1_data/household_power_consumption.txt", header = TRUE, sep = ";", colClasses = "character")

## Subset the raw data
data <- raw[raw$Date == "1/2/2007" | raw$Date == "2/2/2007",]

## Create the final transformed (tr) dataset which will be used for analysis
datetime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

tr <- data.frame(datetime = datetime, 
                 active_power = as.numeric(data$Global_active_power),
                 reactive_power = as.numeric(data$Global_reactive_power),
                 voltage = as.numeric(data$Voltage),
                 intensity = as.numeric(data$Global_intensity),
                 sub1 = as.numeric(data$Sub_metering_1),
                 sub2 = as.numeric(data$Sub_metering_2),
                 sub3 = as.numeric(data$Sub_metering_3)
                 )

# Generate plot4 to png

png("plot4.png", width=480, height=480)

par(mfrow = c(2, 2)) 

plot(tr$datetime, tr$active_power, xlab="", ylab="Global Active Power", type="l")

plot(tr$datetime, tr$voltage, xlab="datetime", ylab="Voltage", type="l")
plot(tr$datetime, tr$sub1, ylab="Energy sub metering", xlab="", type="l")
points(tr$datetime, tr$sub2, col="red", type="l")
points(tr$datetime, tr$sub3, col="blue", type="l")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty = "n")

plot(tr$datetime, tr$reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")

dev.off()

