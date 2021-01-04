## Require library
library(readr)

## Get working directory of the file
setwd(getwd())

## Project url
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Download and unzip file
download.file(url, destfile = "data.zip", method="curl")
unzip("data.zip")

dat <- read.table("household_power_consumption.txt", 
                  skip=66000, nrows=5000, sep=";", na.strings = "?", 
                  stringsAsFactors = FALSE, header=FALSE)

## Reading the data for the 2 days. Note that we start from 66000 and read only 
## the next 5000 rows since it is ineffecient to read the unnecessary rows.
dat <- read.table("household_power_consumption.txt", 
                  skip=66000, nrows=5000, sep=";", na.strings = "?", 
                  stringsAsFactors = FALSE, header=FALSE)

## Reading the names
temp <-  read.table("household_power_consumption.txt", 
                    nrows=1, sep=";", na.strings = "?", 
                    stringsAsFactors = FALSE, header=TRUE)

## Adding names to our variable dat
names(dat) <- names(temp)
dat$Global_active_power <- as.numeric(dat$Global_active_power)

## Adding the datetime variable
dat <- dat[dat$Date == as.Date("01/02/2007") | dat$Date == as.Date("02/02/2007"),]
dat$datetime <- strptime(paste(dat$Date, dat$Time), format = "%d/%m/%Y %H:%M:%S")

## Making the png 
plot(dat$datetime, dat$Sub_metering_1, type="n", ylab = "Energy sub metering", xlab = "")
lines(dat$datetime, dat$Sub_metering_1, col = "darkgreen")
lines(dat$datetime, dat$Sub_metering_2, col = "red")
lines(dat$datetime, dat$Sub_metering_3, col = "blue")
legend("topright", lty = "solid", col = c("darkgreen", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.8)
dev.copy(png, 'plot3.png', width=480, height=480)
dev.off()