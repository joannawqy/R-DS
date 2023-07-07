power <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?")

power[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

power <- power[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# plot1
plot(power[, dateTime], power[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# plot2
plot(power[, dateTime],power[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# plot3
plot(power[, dateTime], power[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(power[, dateTime], power[, Sub_metering_2], col="red")
lines(power[, dateTime], power[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# plot4
plot(power[, dateTime], power[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()