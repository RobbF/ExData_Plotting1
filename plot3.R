##upload data from source file, limiting upload to only selected dates
edat <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), sep=';', stringsAsFactors = FALSE)

##upload first row of file to use column names
etitles <- read.table(pipe('grep "Date" "household_power_consumption.txt"'), sep=';')
colnames(edat) <- as.matrix(etitles)

##create column with class 'Date' combining date and time, converted to POSIXct 
edat[,'Date'] <- as.Date(edat[,'Date'], "%d/%m/%Y")
edat[,'Date/Time'] <- as.POSIXct(paste(edat[,'Date'], edat[,'Time']))

##create line graph analyzing 3 separate measurements of submetering over two day period
##print this plot directly to png
png('plot3.png')
plot(edat[,'Date/Time'], edat$Sub_metering_1, pch = '', xlab = "", ylab = "Energy sub metering")
lines(edat[,'Date/Time'], edat$Sub_metering_1)
lines(edat[,'Date/Time'], edat$Sub_metering_2, col = 'red')
lines(edat[,'Date/Time'], edat$Sub_metering_3, col = 'blue')
legend('topright', lty = 1, col = c('black','red','blue'), legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
dev.off()