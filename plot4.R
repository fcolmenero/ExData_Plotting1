#Setting locale time to English value to display days of week correctly in the plots
Sys.setlocale("LC_TIME","English")

###
### Auxiliar custom plotting functions to simplify the main plot composition (see below)
###

# Creates a plot from Global active power measures of houseHolp_DF data frame
# This data frame should be previously cleaned up and format conditioned
createPlot1 <- function(houseHoldP_DF)
{
  with(houseHoldP_DF,plot(Time,Global_active_power,t="l",xlab="",ylab="Global Active Power"))
}

# Creates a plot from Voltage measures of houseHolp_DF data frame
# This data frame should be previously cleaned up and format conditioned
createPlot2 <- function(houseHoldP_DF)
{
  with(houseHoldP_DF,plot(Time,Voltage,t="l",xlab="datetime",ylab="Voltage"))
}

# Creates a plot from the different submetering measures of houseHolp_DF data frame
# This data frame should be previously cleaned up and format conditioned
createPlot3 <- function(houseHoldP_DF)
{
  with(houseHoldP_DF,
  {
    plot(Time,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
    lines(Time,Sub_metering_1)
    lines(Time,Sub_metering_2,col="red")
    lines(Time,Sub_metering_3,col="blue")
    legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1),bty = "n")
  });
  
}
# Creates a plot from Global reactive power measures of houseHolp_DF data frame
# This data frame should be previously cleaned up and format conditioned
createPlot4 <- function(houseHoldP_DF)
{
  with(houseHoldP_DF,plot(Time,Global_reactive_power,t="l",xlab="datetime"))
}

###
##################### END OF CUSTOM PLOT FUNCTIONS ###############################
###

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

#Plotting a composed plot created from different measures of the provided dataset
#To simplify the main plot creation various custom plotting functions has been 
#created above. In this way, it should be very to rearrange the order of the subplots
#suffling the order of the function invocations
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
createPlot1(filteredHHp);
createPlot2(filteredHHp);
createPlot3(filteredHHp);
createPlot4(filteredHHp);
dev.off()

