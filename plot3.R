## Install dplyr packages if needed
if(!require('dplyr')) {
    install.packages('dplyr')
}

## Load dplyr library
library(dplyr)

## read table - data has header row, ';' separators, '?' na strings
hhp <- read.table('./household_power_consumption/household_power_consumption.txt', header=TRUE, sep=';', na.strings = '?')

## subset the 2007/02/01, 2007/02/02 data
xhhpsub <- hhp[between(as.Date(hhp$Date, '%d/%m/%Y'), as.Date('2007-02-01', '%Y-%m-%d'), as.Date('2007-02-02', '%Y-%m-%d')),]

## add a new posixlt column which represents data+time
hhpsub$DateTime <- strptime(paste(as.character(hhpsub$Date), as.character(hhpsub$Time), sep=' '), '%d/%m/%Y %H:%M:%S')

## Plot sub_metering_1, 2,3 against DateTime
with(hhpsub, {
    plot(DateTime, Sub_metering_1, type='l', ylab = 'Energy sub metering', xlab='')
    
    lines(DateTime, Sub_metering_2, col='red')
    
    lines(DateTime, Sub_metering_3, col='blue')
    })

## Set the legend - Had to add spaces as copy to png was not a true reflection of rendering in window
legend('topright', col=c('black', 'red', 'blue'), legend=c('Sub_metering_1    ', 'Sub_metering_2    ', 'Sub_metering_3    '), 
       lwd=1, y.intersp = 1.4, cex=.8)

## export and close the device
dev.copy(png, 'plot3.png', width=480, height=480)

dev.off()