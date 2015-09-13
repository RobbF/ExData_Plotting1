##upload data from source file, limiting upload to only selected dates
edat <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), sep=';', stringsAsFactors = FALSE)

##upload first row of file to use column names
etitles <- read.table(pipe('grep "Date" "household_power_consumption.txt"'), sep=';')
colnames(edat) <- as.matrix(etitles)

##create column with class 'Date' combining date and time, converted to POSIXct 
edat[,'Date'] <- as.Date(edat[,'Date'], "%d/%m/%Y")
edat[,'datetime'] <- as.POSIXct(paste(edat[,'Date'], edat[,'Time']))

##create multiple base plots to be displayed simultaneously
##print these plots directly to png with dimension 480px x 480px
png(filename = 'plot4.png', width = 480, height = 480)
par(mfrow = c(2,2))
with(edat, {
plot(edat[,'datetime'], edat$Global_active_power, pch = '', xlab = "", ylab = "Global Active Power")
lines(edat[,'datetime'], edat$Global_active_power)
plot(edat[,'datetime'], edat$Voltage, pch = '', xlab = 'datetime', ylab = "Voltage")
lines(edat[,'datetime'], edat$Voltage)
plot(edat[,'datetime'], edat$Sub_metering_1, pch = '', xlab = "", ylab = "Energy sub metering")
lines(edat[,'datetime'], edat$Sub_metering_1)
lines(edat[,'datetime'], edat$Sub_metering_2, col = 'red')
lines(edat[,'datetime'], edat$Sub_metering_3, col = 'blue')
legend('topright', lty = 1, bty = 'n', col = c('black','red','blue'), legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
plot(edat[,'datetime'], edat$Global_reactive_power, pch = '', xlab = 'datetime', ylab = 'Global_reactive_power')
lines(edat[,'datetime'], edat$Global_reactive_power)
})
dev.off()