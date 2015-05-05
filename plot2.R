#Project 1 for "Exploratory Data Analysis" Course
#Offered by Johns Hopkins University, Bloomberg School of Public Health
#Student Name: Margaret Prescott
#Course Start Date: 2015-May-04
#Project Due Date: 2015-May-10

library(data.table)
# The data file being used in this project is very large, and since only two days worth of data is needed,
# the fread function will be used to skip down to the first line in the data file that contains the first
# date (01-02-2007 and 02-02-2007 are the only dates to be used in this project). Since the rows for prior
# dates will be skipped, the first row containing the column names will likewise be skipped. A separate
# read of the file is needed to capture the column names

varNames <- names(fread("household_power_consumption.txt",nrows=1))
data <- fread("household_power_consumption.txt",skip="1/2/2007",nrows=2880)
setnames(data,1:9,varNames)

# Create a combined date and time column to make it possible to plot the other variables over time.
# The lubridate package must be installed for the next two lines to run properly. Once done, the data table
# will have a new, nicely formatted POSIXct column called datetime
library(lubridate)
data$datetime <- dmy_hms(paste(data$Date,data$Time))

# Open PNG device. Draw a line plot of the global active power values over time.
png("plot2.png", bg="white")
with(
  data,
  plot(
    datetime,
    Global_active_power,
    typ='l',
    xlab="",
    ylab="Global Active Power (kilowatts)"
  )
)
dev.off()

