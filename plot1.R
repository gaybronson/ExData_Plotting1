
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

plot1_data <- subset(new_data, "Global_reactive_power" != "?")

##create histogram
par("mar" = c(5,5,4,2))
hist(plot1_data[,3], col="red", breaks = 12, freq = TRUE, main = "Global Active Power", xlab = "Global Active Power (Kilowatts)")

##save histogram
dev.copy(png,'plot1.png', height=480, width=480)
dev.off()