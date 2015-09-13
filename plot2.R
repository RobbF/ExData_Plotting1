##upload data from source file, limiting upload to only selected dates
edat <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), sep=';', stringsAsFactors = FALSE)

##upload first row of file to use column names
etitles <- read.table(pipe('grep "Date" "household_power_consumption.txt"'), sep=';')
colnames(edat) <- as.matrix(etitles)

##create column with class 'Date' combining date and time, converted to POSIXct 
edat[,'Date'] <- as.Date(edat[,'Date'], "%d/%m/%Y")
edat[,'Date/Time'] <- as.POSIXct(paste(edat[,'Date'], edat[,'Time']))

##create line graph analyzing global active power over two day period
##print plot directly to png file with dimensions 480px x 480px
png(filename = 'plot2.png', height = 480, width = 480)
plot(edat[,'Date/Time'], edat$Global_active_power, pch = '', xlab = "", ylab = "Global Active Power (kilowatts)")
lines(edat[,'Date/Time'], edat$Global_active_power)
dev.off()

