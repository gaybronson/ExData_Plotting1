
##read data

my_data <-data.frame()
my_data <- read.table("/Users/gaybronson/Documents/household_power_consumption.txt", header = TRUE, sep =";", colClasses="character")

## create date variable
my_data$Date <- as.Date(my_data$Date, format = "%d/%m/%Y")

## subset by applicable date
my_data <- subset(my_data, Date <= "2007-02-02" & Date >="2007-02-01")

##  create character variable that contains date and time
date_and_time <- character(length = nrow(my_data))
for(i in 1:nrow(my_data)) {
        
        date_and_time[[i]]<- paste(as.character(my_data$Date[i]), my_data$Time[i], sep = " ")
}
new_data <- cbind(my_data, date_and_time)

## create POSIX variable for date/time
new_data$date_and_time <- strptime(new_data$date_and_time, format="%Y-%m-%d %H:%M:%S")

## convert remaining variables to numeric variables
new_data[,3:9]<- as.numeric(as.character(unlist(new_data[,3:9])))

## remove incomplete rows

plot4_data <- subset(new_data, "Sub_metering_1" != "?" & "Sub_metering_2" != "?" & "Sub-metering_3" != "?" & "Voltage" != "?" & "Global_reactive_power" != "?")

##create 2x2 plotting framework and set margins and label font size

par("mfcol" = c(2,2), "mar" = c(4,5,4,2), "cex" = .6)

## plot data(1)
plot(plot4_data$date_and_time, plot4_data[,3],type="l",xlab="", ylab="Global Active Power")


##plot data(2)

plot(plot4_data$date_and_time, plot4_data[,7],type="l",xlab="", ylab="Energy sub metering")
points(plot4_data$date_and_time, plot4_data[,8], type="l", col="red")
points(plot4_data$date_and_time, plot4_data[,9], type="l", col="blue")


##format legend
legend("topright", c("sub_metering_1","sub_metering_2","sub_metering_3"), col=c("black","red","blue"), lty=1, y.intersp=.2, cex=.8, pt.cex=1, xjust=1, yjust=1, text.width=strwidth("sub_metering_1"), bty = "n", inset= 0)

##plot data(3)
plot(plot4_data$date_and_time, plot4_data[,5],type="l",xlab="datetime", ylab="Voltage")

##plot data(4)
plot(plot4_data$date_and_time, plot4_data[,4],type="l",xlab="datetime", ylab="global_reactive_power")

##save plot
dev.copy(png,'plot4.png', height=480, width=480)
dev.off()
