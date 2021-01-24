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

#Plot1
par(mfcol = c(1,1), mfrow= c(1,1))
hist(t$`Global Active Power`, freq = TRUE, col = "RED", xlab = "Global Active Power (Kilowatts)", main = "Global Active Power")

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()