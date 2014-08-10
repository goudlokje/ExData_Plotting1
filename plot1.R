# Load data object
source('load_data.R')

# Plot 1
png('plot1.png', 480, 480, bg="transparent")
hist(data$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
