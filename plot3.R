# Load Packages
library(tidyverse)

# Load Data Set
data.full <- read.table("household_power_consumption.txt", dec = ".", sep = ";", header = TRUE)

# Transformations
Sys.setlocale("LC_TIME", "English")
data.full$Date <- as.Date(data.full$Date, "%d/%m/%Y")

# Subset 2007-02-01 y 2007-02-02
data <- data.full %>% 
        filter(Date == "2007-02-01" | Date =="2007-02-02")


timeline <- as.POSIXct(paste(data$Date, data$Time, sep = " "), format = "%Y-%m-%d %H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Creating graph
png("plot3.png", width = 480, height = 480)

plot(timeline, data$Sub_metering_1, 
     type = "l", 
     ylab = "Energy Submetering", 
     xlab = "")

lines(timeline, data$Sub_metering_2, type = "l", col = "red")

lines(timeline, data$Sub_metering_3, type = "l", col = "blue")

legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, 
       lwd = 2.5, 
       col = c("black", "red", "blue"))

dev.off()
