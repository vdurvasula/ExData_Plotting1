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

# Estimated memory size to load complete data
Estimated_total_mem <- 2075259 * (object.size(df)/dim(df)[1]) 

print(c("Estimated memory usage for Complete power consumption data: ", Estimated_total_mem), quote=FALSE)

#register Graphic device for PNG file format
png(filename = "./ExData_Plotting1/plot_1.png",width = 480, height = 480)

# plot graph
with(df1, 
     hist(Global_active_power, col="red",main="Global Active Power",xlab = "Global Active Power (kilowatts)",ylab = "Frequency"))
#shutdown graphics device
dev.off()