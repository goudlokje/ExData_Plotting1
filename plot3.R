source('load_data.R')

# Set locale to english to match the x-axis tick labels
Sys.setlocale(category = "LC_ALL", locale = "en_GB")

# Plot 3
png('plot3.png', 480, 480, bg="transparent")

with(data, { 
	plot(datetime,Sub_metering_1,col="black", type='l', ylab = "Energy sub metering", xlab = "")
	lines(datetime, Sub_metering_2, col="red")
	lines(datetime, Sub_metering_3, col="blue")
	legend("topright",col = c('black','red','blue'), legend=grep('^Sub',names(data), value=T), lty=1)
})

dev.off()
