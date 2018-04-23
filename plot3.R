#plot3.R

##Dataset: Electric power consumption [20Mb] - Individual household electric power consumption Data Set

# 9 variables in the dataset are taken from the UCI web site:
#   
# Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if ( !file.exists("data") ) {  dir.create("data") }
download.file(fileUrl, destfile="./data/household_power_consumption.zip", method="curl")
unzip("./data/household_power_consumption.zip", exdir="./data")
dateDownloaded <- date()
dateDownloaded
#testOK: readLines(file("./data/household_power_consumption.txt"), n=10)

df = read.csv2(file="./data/household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)
df$Date <- strptime(df$Date, "%d/%m/%Y")  ##convert date string to date datatype
dfs <- df[df$Date=="2007-02-01" | df$Date=="2007-02-02",]
df <- dfs; rm(dfs)  #remove full file variable from memory
df$DateTime <- strptime(paste(df$Date, df$Time), "%Y-%m-%d %H:%M:%S")  ##convert date string to date datatype
str(df); head(df); summary(df)


## PLOT 3
plot(x=df$DateTime, y=df$Sub_metering_1, type="n", xlab="", ylab="Energy Sub Metering")
lines(x=df$DateTime, y=df$Sub_metering_1, type="l", col="black")
lines(x=df$DateTime, y=df$Sub_metering_2, type="l", col="red")
lines(x=df$DateTime, y=df$Sub_metering_3, type="l", col="blue")
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, width=480, height=480, units="px", file="./plot3.png"); dev.off()
