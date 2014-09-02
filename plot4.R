## Please set the working directory the same as the unziped file 'household_power_consumption.zip', 
## it means, the same directory as 'household_power_consumption.txt' is. 

## Read file 'household_power_consumption.txt' and direct data to 'df' data frame.
df<-read.table("household_power_consumption.txt", header=T,sep=";")

## Convert data in column 'Date' to 'date' format.
df$Date<-as.Date(df$Date, format="%d/%m/%Y")

## Check if 'lubridate' package is available. If it's not, it will be installed and finaly called.
if("lubridate" %in% rownames(installed.packages()) == FALSE) {install.packages("lubridate")}
library(lubridate)

## Create a column which joins columns 'Date' and 'Time' in one, and finally converts to 'time' format.
df$DateTime<-ymd_hms(paste(df$Date,df$Time,sep=" "))

## Convert data in column 'Global_active_power' from 'factor' to 'numeric'.
df$Global_active_power<-suppressWarnings(as.numeric(as.character(df$Global_active_power)))

## Convert data in column 'Global_reactive_power' from 'factor' to 'numeric'.
df$Global_reactive_power<-suppressWarnings(as.numeric(as.character(df$Global_reactive_power)))

## Convert data in column 'Voltage' from 'factor' to 'numeric'.
df$Voltage<-suppressWarnings(as.numeric(as.character(df$Voltage)))

## Convert data in column 'Global_intensity' from 'factor' to 'numeric'.
df$Global_intensity<-suppressWarnings(as.numeric(as.character(df$Global_intensity)))

## Convert data in column 'Sub_metering_1' from 'factor' to 'numeric'.
df$Sub_metering_1<-suppressWarnings(as.numeric(as.character(df$Sub_metering_1)))

## Convert data in column 'Sub_metering_2' from 'factor' to 'numeric'.
df$Sub_metering_2<-suppressWarnings(as.numeric(as.character(df$Sub_metering_2)))

## Convert data in column 'Sub_metering_3' from 'factor' to 'numeric'.
df$Sub_metering_3<-suppressWarnings(as.numeric(as.character(df$Sub_metering_3)))

## Reduce the whole data frame to the dates of interest only.
df<-df[df$Date %in% as.Date(c('2007-02-01', '2007-02-02')),]

## Launch a graphics device 'png', including information on graphic size.
png(filename="plot4.png",width = 480, height = 480, units = "px")

## Defines the parameters for multiple base plots.
par(mfrow=c(2,2))

## Create multiple graphs, including needed annotations.
plot(df$DateTime,df$Global_active_power,type='l',xlab="",ylab="Global Active Power")
plot(df$DateTime,df$Voltage,type='l',xlab="datetime",ylab="Voltage")
plot(df$DateTime,df$Sub_metering_1,type='l',xlab="",ylab="Energy sub metering",col="black")
lines(df$DateTime,df$Sub_metering_2,type='l',xlab="",ylab="",col="red")
lines(df$DateTime,df$Sub_metering_3,type='l',xlab="",ylab="",col="blue")
legend("topright", col = c("black","red","blue"), bty="n",lty=c(1,1),lwd=c(2.5,2.5), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
plot(df$DateTime,df$Global_reactive_power,type='l',xlab="datetime",ylab="Global_reactive_power")

## Close graphics device.
dev.off()