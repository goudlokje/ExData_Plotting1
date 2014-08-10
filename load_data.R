data_dir <- 'data'
url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
zip_file <- 'hpc.zip'
csv_file <- 'household_power_consumption.txt'
# File to store the calculated data 
#   Don't recalculate the data unless we have to: use save files
bin_file <- 'data.bin'

#
# Choosing strategy
#
# t1 <- system.time({
# 	csv_ <- read.csv(csv_file, sep = ";", header = T, na.strings = "?")
# 	csv_ <- subset(csv_, (Date == "1/2/2007") | (Date == "2/2/2007"))
# })
# 
# t2 <- system.time({
# 	raw <- readLines("household_power_consumption.txt")
# 	filtered_lines <- grep("^([12]/2/2007|Date)",text, value=T, perl=T)
# 	filtered_text <- paste(filtered_lines, collapse="\n")
# 	csv <- read.table(sep = ";", header = T, na.strings = "?", text = filtered_text)
# })
# 
# print(t1)
#     user  system elapsed 
#   31.989   0.782  33.285 
#
# print(t2)
#     user  system elapsed 
#   20.444   0.151  20.708 
#

if (!file.exists(data_dir)) {
	dir.create(data_dir)
}

old_wd <- getwd()
setwd(data_dir)

# Do only as much work as is needed
#   If we have calculated our data before load it
if (file.exists(bin_file)) {
	load(bin_file)
} else {
	# Only download the csv file if we don't have it already
	if (! file.exists(csv_file)) {
		if (! file.exists(zip_file)) {
			# curl probably won't work on Windows, internal won't download https on Mac :(
			download.file(url, zip_file, 'curl')
		}

		#unzip(list=T, zip_file)
		unzip(zip_file)
	}

	# Go from CSV to data frame with the chosen strategy
	raw_lines <- readLines("household_power_consumption.txt")
	# Strip lines we won't use
	filtered_lines <- grep("^([12]/2/2007|Date)", raw_lines, value=T, perl=T)
	# Prepare string for read.table()
	filtered_text <- paste(filtered_lines, collapse="\n")

	data <- read.table(sep = ";", header = T, na.strings = "?", text = filtered_text)

	# Annotate data with calculated datetime field
	data$datetime <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

	# Save calculated state for future runs
	save(data, file = bin_file)
}

setwd(old_wd)
