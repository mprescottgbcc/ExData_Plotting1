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

# Create a combined date and time column to make it possible to plot the other variables over time
# The lubridate package must be installed for the next two lines to run properly. Once done, the data table
# will have a new, nicely formatted POSIXct column called datetime
library(lubridate)
data$datetime <- dmy_hms(paste(data$Date,data$Time))

# Open a PNG device, set the layout and start plotting
png("plot4.png",bg="white")

par(mfrow=c(2,2)) #set up a 2 by 2 plot layout

#top left plot
with(
  data,
  plot(
    datetime,
    Global_active_power,
    typ='l',
    xlab="",
    ylab="Global Active Power"
  )
)

#top right plot
with(
  data,
  plot(
    datetime,
    Voltage,
    typ='l',
  )
)

#bottom left plot
plot(
  data$datetime,data$Sub_metering_1,
  typ='l',
  ylim=c(0,max(data$Sub_metering_1,data$Sub_metering_2,data$Sub_metering_3)),
  xlab="",
  ylab="Energy sub metering"
)
lines(data$datetime,data$Sub_metering_2,col='red')
lines(data$datetime,data$Sub_metering_3,col='blue')
legend(
  "topright",
  legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
  lty=c(1,1,1),
  col=c("black","red","blue"),
  bty="n"
)

#bottom right plot
with(
  data,
  plot(
    datetime,
    Global_reactive_power,
    typ='l',
  )
)

dev.off()

# You should now have a shiny new PNG in your working directory :)
