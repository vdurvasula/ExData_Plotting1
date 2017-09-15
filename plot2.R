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
png(filename = "./ExData_Plotting1/plot_2.png",width = 480, height = 480)

# Plot graph
with(df, plot(df$dtimes,df$Global_active_power,type="s",ylab = "Global Active Power (kilowatts)",xlab=""))

#shutdown graphics device
dev.off()