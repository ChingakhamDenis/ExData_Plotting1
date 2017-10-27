t <- file("household_power_consumption.txt")
# Filter down the data from 2007-02-01 and 2007-02-02
dt <- read.table(text = grep("^[1,2]/2/2007", readLines(t), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)
##Merging Date and Time Column to datetime
datetime <- strptime(paste(dt$Date, dt$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
globalActivePower <- as.numeric(dt$Global_active_power)
globalReactivePower <- as.numeric(dt$Global_reactive_power)
voltage <- as.numeric(dt$Voltage)
sm1 <- as.numeric(dt$Sub_metering_1)
sm2 <- as.numeric(dt$Sub_metering_2)
sm3 <- as.numeric(dt$Sub_metering_3)

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2))

plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")
plot(datetime, sm1, type="l", ylab="Energy Submetering", xlab="")
##Annoting the graph
lines(datetime, sm2, type="l", col="red")
lines(datetime, sm3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"), bty = "o")

plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()
