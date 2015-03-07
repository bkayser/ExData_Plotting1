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
png(filename='plot4.png')

# Set up the 2x2 grid of plots
par(mfrow=c(2,2))

# PLOT top-left
plot(data$Timestamp,
     data$GAP,
     ylab='Global Active Power',
     xlab='',
     type='l')

#PLOT top-right
plot(data$Timestamp,
     data$Voltage,
     ylab='Voltage',
     type='l',
     xlab='datetime')

# PLOT bottom-left
plot(data$Timestamp, 
     data$Sub_metering_1,
     ylab='Energy sub metering', 
     xlab='',
     type='n')

lines(data$Timestamp,
      data$Sub_metering_1,
      col='black')

lines(data$Timestamp,
      data$Sub_metering_2,
      col='red')

lines(data$Timestamp,
      data$Sub_metering_3,
      col='blue')

legend('topright',
       c(names(data)[7:9]),
       col=c('black','red','blue'),
       lwd=1,
       bty='n')

# PLOT bottom-right
plot(data$Timestamp,
     data$GRP,
     ylab='Global_reactive_power',
     type='l',
     xlab='datetime')

dev.off()
