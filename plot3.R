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
png(filename = "./ExData_Plotting1/plot_3.png",width = 480, height = 480)

# Plot graph
with(df, { plot(dtimes, Sub_metering_1,type="s", ylab = "Energy sub metering")
     points(dtimes,Sub_metering_2,type = "s",col="red")
     points(dtimes,Sub_metering_3,type = "s",col="blue") 
     legend("topright",lty=1,lwd=1,col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
     })

#shutdown graphics device
dev.off()