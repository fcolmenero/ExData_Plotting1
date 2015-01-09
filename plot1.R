#Setting locale time to English value to display days of week correctly in the plots
Sys.setlocale("LC_TIME","English")

#Loading data from data source file using ; as separator
householdp<-read.csv(file="household_power_consumption.txt",header = TRUE,sep=";")

#Subsetting only the required dates from original data frame
filteredHHp<-householdp[householdp$Date=="1/2/2007" | householdp$Date=="2/2/2007",]

#Cleaning and converting data frame columns to the correct format
# Converting Time column in a legal timestamp using original Time and Date fields
filteredHHp$Date=as.character(filteredHHp$Date)
filteredHHp$Time=as.character(filteredHHp$Time)
filteredHHp$Time=strptime(paste(filteredHHp$Date,filteredHHp$Time),"%d/%m/%Y %H:%M:%S")

#Converting numerical columns to the correct format (double or integer)
#before plotting
filteredHHp$Global_active_power=as.double(as.character(filteredHHp$Global_active_power))

filteredHHp$Sub_metering_1=as.double(as.character(filteredHHp$Sub_metering_1))
filteredHHp$Sub_metering_2=as.double(as.character(filteredHHp$Sub_metering_2))
filteredHHp$Sub_metering_3=as.integer(as.character(filteredHHp$Sub_metering_3))

filteredHHp$Voltage=as.double(as.character(filteredHHp$Voltage))

filteredHHp$Global_reactive_power=as.double(as.character(filteredHHp$Global_reactive_power))

#Plotting Global_active_power histogram in PNG file
png("plot1.png", width = 480, height = 480)
hist(filteredHHp$Global_active_power,main="Global Active Power",col="red",xlab="Global Active Power (kilowatts)")
dev.off()