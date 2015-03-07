# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Read the data skipping the rows outside the time range of interest
#
data <- read.table('../household_power_consumption.txt', 
                   sep=";", 
                   skip=66637, # skip all data up to feb 2007
                   nrows=2880, # read in feb 1,2 only
                   na.strings="?", 
                   col.names=c('Date','Time','GAP', 'GRP', 'Voltage', 'GI', 
                               'Sub_metering_1',
                               'Sub_metering_2',
                               'Sub_metering_3'),
                   stringsAsFactors=c(TRUE,FALSE))

# Create a new column for the timestamp by parsing the date and time
data$Timestamp = strptime(paste(data$Date, data$Time), '%d/%m/%Y %H:%M:%S')

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Create the plot on a PNG device
png(filename='plot1.png')

hist(data$GAP, 
     col='red', 
     xlab='Global Active Power (kilowatts)', 
     main='Global Active Power')

dev.off()
    