source('load_data.R')

# Set locale to english to match the x-axis tick labels
Sys.setlocale(category = "LC_ALL", locale = "en_GB")

# Plot 2
png('plot2.png', 480, 480, bg="transparent")
with(data, plot(datetime, Global_active_power, type='l', ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.off()
