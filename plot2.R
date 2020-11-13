# Load Packages
library(tidyverse)

# Load Data Set
data.full <- read.table("household_power_consumption.txt", dec = ".", sep = ";", header = TRUE)

# Transformations
Sys.setlocale("LC_TIME", "English")
data.full$Date <- as.Date(data.full$Date, "%d/%m/%Y")
data.full$Global_active_power <- as.numeric(data.full$Global_active_power)

# Subset 2007-02-01 y 2007-02-02
data <- data.full %>% 
        filter(Date == "2007-02-01" | Date =="2007-02-02")

# Creating timeline
timeline <- as.POSIXct(paste(data$Date, data$Time, sep=" "), format = "%Y-%m-%d %H:%M:%S")

# Creating graph
png("plot2.png", width = 480, height = 480)

plot(timeline, data$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")

dev.off()




