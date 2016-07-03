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

## plot Global active power hist
hist(hhpsub$Global_active_power, xlab='Global Active Power (kilowatts)', col='red', main='Global Active Power')

## Export to png
dev.copy(png, 'plot1.png', width=480, height=480)

## Turn the device off
dev.off()