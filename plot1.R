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

# Open a PNG device. Create a histogram for the Global Active Power variable in the data table.
png("plot1.png", bg="white")
with(
  data,
  hist(
    Global_active_power,
    main = "Global Active Power",
    xlab = "Global Active Power (kilowatts)",
    col="red",
  )
)
dev.off()

# You should now have a shiny new plot in your working directory :)

