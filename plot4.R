##################################################################################################
#  STEP 0: If Dataset file not present, downlowad and unzip Dataset in current working directory
##################################################################################################
if(!file.exists("household_power_consumption.txt")) {
  fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileurl, "exdata-data-household_power_consumption.zip")
  unzip("exdata-data-household_power_consumption.zip")
}

##################################################################################################
#  STEP 1: Read file 
##################################################################################################
library(sqldf)
df <- read.csv.sql("household_power_consumption.txt", sql = "SELECT * from file WHERE Date in ('1/2/2007','2/2/2007') ", sep = ";", header = TRUE)

##################################################################################################
#  STEP 2: Create "topleft" graph in png file
##################################################################################################
png(file = "plot4.png")
Sys.setlocale("LC_TIME", "English")    # This is only needed if the operating system language is not English
par(mfrow = c(2, 2), mar = c(6, 5, 2, 1))
vdate <- as.character(df$Date)
vtime <- as.character(df$Time)
vdatetime <- paste(vdate,vtime)
df$DateTime <- strptime(vdatetime, "%d/%m/%Y %H:%M:%S")
with(df, plot(DateTime, Global_active_power, type = "n", xlab = "", ylab = "Global Active Power"))
with(df, lines(DateTime, Global_active_power))

##################################################################################################
#  STEP 3: Create "topright" graph in png file
##################################################################################################
with(df, plot(DateTime, Voltage, type = "n", xlab = "datetime", ylab = "Voltage"))
with(df, lines(DateTime, Voltage))

##################################################################################################
#  STEP 4: Create "bottomleft" graph in png file
##################################################################################################
with(df, plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
with(df, lines(DateTime, Sub_metering_1, col = "black"))
with(df, lines(DateTime, Sub_metering_2, col = "red"))
with(df, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", lwd = 1, col = c("black", "red", "blue"))

##################################################################################################
#  STEP 5: Create "bottomright" graph in png file and close device
##################################################################################################
with(df, plot(DateTime, Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power"))
with(df, lines(DateTime, Global_reactive_power))
dev.off()
