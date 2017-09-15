library("sqldf")
library("data.table")

#Source File path
hpc_file <- "./household_power_consumption.txt"

#open connection to source file
hpc_db <- file(hpc_file) 

#query source file for limited period  
df <- sqldf("select * from hpc_db where Date in('1/2/2007', '2/2/2007')", file.format=list(header=TRUE, sep = ";"))

#close connection
close(hpc_db)

#prepare formatted date time
dtimes <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S", tz="UTC")

#merge date time column with consumption data  
df <- cbind(df, dtimes)

# register Graphic device for PNG file format
png(filename = "./ExData_Plotting1/plot_4.png",width = 480, height = 480)

# set graphical parameters
par(mfrow=c(2,2),mar=c(4,4,2,1))

# Plot graphs
plot(df$dtimes,df$Global_active_power,type="s",xlab="", ylab = "Global Active Power" )
plot(df$dtimes,df$Voltage,type="s", xlab="datetime", ylab="Voltage")
with(df, { plot(dtimes, Sub_metering_1,type="s",xlab="",ylab = "Energy sub metering")
     points(dtimes,Sub_metering_2,type = "s",col="red")
     points(dtimes,Sub_metering_3,type = "s",col="blue") 
     legend("topright",lty=1,lwd=2,col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")
     })
plot(df$dtimes,df$Global_reactive_power,type="s",xlab="datetime",ylab="Global Reactive Power")


#shutdown graphics device
dev.off()