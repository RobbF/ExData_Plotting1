##upload data from source file, limiting upload to only selected dates
edat <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), sep=';', stringsAsFactors = FALSE)

##upload first row of file to use column names
etitles <- read.table(pipe('grep "Date" "household_power_consumption.txt"'), sep=';')
colnames(edat) <- as.matrix(etitles)

##create the global active power histogram, with specified labels and colors
##print plot to png file with dimensions 480px x 480px and close png file
png(filename = 'plot1.png', height = 480, width = 480)
hist(edat[,"Global_active_power"], col = 'red', xlab = 'Global Active Power (kilowatts)', main = "Global Active Power")
dev.off()