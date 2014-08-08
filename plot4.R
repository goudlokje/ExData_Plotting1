source('load_data.R')

# Set locale to english to match the x-axis tick labels
Sys.setlocale(category = "LC_ALL", locale = "en_GB")

# Plot 4
png('plot4.png', 480, 480, bg="transparent")

par("mfcol" = c(2,2))
with(data, plot(datetime, Global_active_power, type='l', ylab = "Global Active Power", xlab = ""))

with(data, { 
	plot(datetime,Sub_metering_1,col="black", type='l', ylab = "Energy sub metering", xlab = "")
	lines(datetime, Sub_metering_2, col="red")
	lines(datetime, Sub_metering_3, col="blue")
	legend("topright", col = c('black','red','blue'), legend=grep('^Sub',names(data), value=T), lty=1, bty="n")
})

with(data, plot(datetime, Voltage, type='l'))
with(data, plot(datetime, Global_reactive_power, type='l'))
dev.off()
