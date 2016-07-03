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

## add a new posixlt column which represents data+time
hhpsub$DateTime <- strptime(paste(as.character(hhpsub$Date), as.character(hhpsub$Time), sep=' '), '%d/%m/%Y %H:%M:%S')

## Setup 2X2
par(mfrow=c(2,2))

## 1st Plot - top left
plot(hhpsub$DateTime, hhpsub$Global_active_power, type='l', ylab = 'Global Active Power (kilowatts)', xlab='')

## 2nd Plot - top right
plot(hhpsub$DateTime, hhpsub$Voltage, type='l', ylab = 'Voltage', xlab='datetime')

## 3rd plot - bottom left
with(hhpsub, {
    plot(DateTime, Sub_metering_1, type='l', ylab = 'Energy sub metering', xlab='')
    
    lines(DateTime, Sub_metering_2, col='red')
    
    lines(DateTime, Sub_metering_3, col='blue')
    })

## Add legend without a box and adjustments
legend('topright', col=c('black', 'red', 'blue'), legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       lwd=1, y.intersp = 1.4, cex=.8, bty="n")

## 4th plot - bottom right
plot(hhpsub$DateTime, hhpsub$Global_reactive_power, type='l', ylab = 'Global_reactive_power', xlab='datetime')

## copy png and close
dev.copy(png, 'plot4.png', width=480, height=480)

dev.off()