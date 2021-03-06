# Loading the data
if (!any(grepl("data.table", installed.packages()))) install.packages("data.table")
library(data.table)
g <- fread("household_power_consumption.txt",sep=";",na.strings='?')
g[, Global_active_power:=as.numeric(Global_active_power)]
g[, Global_reactive_power:=as.numeric(Global_reactive_power)]
g[, Voltage:=as.numeric(Voltage)]
g[, Global_intensity:=as.numeric(Global_intensity)]
g[, Sub_metering_1:=as.numeric(Sub_metering_1)]
g[, Sub_metering_2:=as.numeric(Sub_metering_2)]
g[, Sub_metering_3:=as.numeric(Sub_metering_3)]

if (!any(grepl("lubridate", installed.packages()))) install.packages("lubridate")
library(lubridate)
g[, DateTime:=fast_strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S")] # fast
g[, Date:=as.Date(Date,"%d/%m/%Y")]
g[, Time:=fast_strptime(Time,"%H:%M:%S")] # fast
#g[, Time:=strptime(Time,"%H:%M:%S")] # very slow

h <- g[Date>="2007-02-01" & Date<="2007-02-02"]

# Making Plots
png(filename="plot1.png",width=480,height=480)
hist(h$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()