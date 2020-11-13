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
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
data$Voltage <- as.numeric(data$Voltage)

# Creating graph
png("plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2)) 

# plot 1-1
plot(timeline, data$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power", 
     cex = 0.2)

# plot 1-2
plot(timeline, data$Voltage, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Voltage")

# plot 2-1
plot(timeline, data$Sub_metering_1, 
     type = "l", 
     xlab = "",
     ylab = "Energy Submetering")

lines(timeline, data$Sub_metering_2, type = "l", col = "red")

lines(timeline, data$Sub_metering_3, type = "l", col = "blue")

legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd = 2.5, 
       col = c("black", "red", "blue"))

# plot 2-2
plot(timeline, data$Global_reactive_power, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Global_reactive_power")

dev.off()

