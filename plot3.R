#clean data
t<-read.table(file = "household_power_consumption.txt",header = TRUE, sep = ";", na.strings = "?" )
t$Date<-as.Date(t[,1], format = "%d/%m/%Y")

t<-subset(t, t[,1]>=as.Date("2007-02-01") & t[,1]<=as.Date("2007-02-02") )
colnames(t)<- c("Date","Time","Global Active Power", "Global Reactive Power","Voltage", "Global Intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
library(chron)
t$Time<-chron(times. = t$Time)
Datetime<-paste(t$Date, t$Time)
t<-cbind(t,Datetime)
t$Datetime<-as.POSIXct(Datetime)

#Plot 3
with(t, plot(Sub_metering_1~ Datetime, type = "l", ylab = "Global Active Power (Kilowatts)", xlab =""))
lines(t$Sub_metering_2~ t$Datetime, type = "l", col = "RED")
lines(t$Sub_metering_3~ t$Datetime, type = "l", col = "BLUE")
legend("topright", col = c("black", "red", "blue"), lwd = c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
