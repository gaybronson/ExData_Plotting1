
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

plot3_data <- subset(new_data, "Sub_metering_1" != "?" & "Sub_metering_2" != "?" & "Sub-metering_3" != "?")

##plot data

plot(plot3_data$date_and_time, plot3_data[,7],type="l",xlab="", ylab="Energy sub metering")
points(plot3_data$date_and_time, plot3_data[,8], type="l", col="red")
points(plot3_data$date_and_time, plot3_data[,9], type="l", col="blue")
par(mar=c(2,5,2,2) + 0.5)

##format legend
legend("topright", c("sub_metering_1","sub_metering_2","sub_metering_3"), col=c("black","red","blue"), lty=1, pt.cex=.7, cex=.8, y.intersp=.4, xjust=1, text.width=strwidth("sub_metering_1"))

##save plot
dev.copy(png,'plot3.png', height=480, width=480)
dev.off()
