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

# Generate plot1 to png

png("plot1.png", width=480, height=480)

hist(tr$active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")

dev.off()

