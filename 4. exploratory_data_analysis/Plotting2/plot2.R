setwd("./coursera/exploratory_data_analysis/ExData_Plotting2")
# Library
library(dplyr)

# Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Extract baltimore city data
baltimore <-subset(NEI,fips=="24510")

# Emission summation of Baltimore by year
baltimore.year<- group_by(baltimore,year) %>% summarise(sum=sum(Emissions))

#Barplot
png("plot2.png",width=480,height=480)
barplot(baltimore.year$sum, names.arg=baltimore.year$year,xlab="Year", 
        ylab=expression(paste("Total Emissions of PM",""[2.5]," (Tons)")), 
        main=expression(paste("Total Emissions of PM",""[2.5], " in the Baltimore City"," from 1999 to 2008")))
dev.off()

