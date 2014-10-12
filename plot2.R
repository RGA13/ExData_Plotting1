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
#  STEP 2: Create graph in png file
##################################################################################################
png(file = "plot2.png")
Sys.setlocale("LC_TIME", "English")    # This is only needed if the operating system language is not English
vdate <- as.character(df$Date)
vtime <- as.character(df$Time)
vdatetime <- paste(vdate,vtime)
df$DateTime <- strptime(vdatetime, "%d/%m/%Y %H:%M:%S")
with(df, plot(DateTime, Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)"))
with(df, lines(DateTime, Global_active_power))
dev.off()