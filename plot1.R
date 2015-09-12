# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Read the data skipping the rows outside the time range of interest
#
library(dplyr)

# The whole table is read into about 133MB of memory which is fine.
data <- read.table('../household_power_consumption.txt', 
                   sep=";", 
                   na.strings="?", 
                   header=T,
                   colClasses = c('factor','factor','numeric','numeric','numeric','numeric','numeric','numeric','numeric'),
                   col.names=c('Date','Time','GAP', 'GRP', 'Voltage', 'GI', 
                               'Sub_metering_1',
                               'Sub_metering_2',
                               'Sub_metering_3'),
                   stringsAsFactors=c(TRUE,FALSE)) %>%
        subset(Date == '1/2/2007' | Date == '2/2/2007')

# Create a new column for the timestamp by parsing the date and time
data$Timestamp = strptime(paste(data$Date, data$Time), '%d/%m/%Y %H:%M:%S')

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Create the plot on a PNG device
png(filename='plot1.png', width=480, height=480)

hist(data$GAP, 
     col='red', 
     xlab='Global Active Power (kilowatts)', 
     main='Global Active Power')

dev.off()
    
