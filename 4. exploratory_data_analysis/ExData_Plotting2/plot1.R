setwd("./coursera/exploratory_data_analysis/ExData_Plotting2")
# Library
library(dplyr)

# Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Sampling: size=10,000
set.seed(12345)
data <- NEI[sample(nrow(NEI),10000),]

#Emission Summation by year
Emission.year<- group_by(data,year) %>% summarise(sum=sum(Emissions))

#Barplot
png("plot1.png",width=480,height=480)
barplot(Emission.year$sum, names.arg=Emission.year$year,xlab="Year", 
        ylab=expression(paste("Total Emissions of PM",""[2.5]," (Tons)")), 
        main=expression(paste("Total Emissions of PM",""[2.5], " from 1999 to 2008")))
dev.off()

