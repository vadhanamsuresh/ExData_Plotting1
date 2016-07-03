## Install dplyr packages if needed
if(!require('dplyr')) {
    install.packages('dplyr')
}

## Load dplyr library
library(dplyr)

## read table - data has header row, ';' separators, '?' na strings
hhp <- read.table('./household_power_consumption/household_power_consumption.txt', header=TRUE, sep=';', na.strings = '?')

## subset the 2007/02/01, 2007/02/02 data
hhpsub <- hhp[between(as.Date(hhp$Date, '%d/%m/%Y'), as.Date('2007-02-01', '%Y-%m-%d'), as.Date('2007-02-02', '%Y-%m-%d')),]

## get the posixlt datetime and plot global active power as a line plot
plot(strptime(paste(as.character(hhpsub$Date), as.character(hhpsub$Time), sep=' '), '%d/%m/%Y %H:%M:%S'), hhpsub$Global_active_power, 
     type='l', ylab = 'Global Active Power (kilowatts)', xlab='')

## Export to png
dev.copy(png, 'plot2.png', width=480, height=480)

## Close the device
dev.off()