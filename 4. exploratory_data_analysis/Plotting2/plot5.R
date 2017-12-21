setwd("./coursera/exploratory_data_analysis/ExData_Plotting2")
# Library
library(ggplot2)

# Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

#Find SCC that is related to motor vehicle
vehicle <-grepl("vehicle",SCC$SCC.Level.Two,ignore.case=TRUE)
SCC.vehicle <-SCC$SCC[vehicle]

#Find NEI of baltimore data that is related to motor vehicle
baltimore <-subset(NEI,fips=="24510")
baltimore.vehicle<- baltimore[baltimore$SCC %in% SCC.vehicle,]

#plot by source type
png("plot5.png",width=480,height=480)
g<-ggplot(baltimore.vehicle,aes(factor(year),Emissions))
g+geom_bar(stat="identity")+
        labs(x="Year", y=expression(paste("Total Emissions of PM",""[2.5]," (Tons)")))+
        labs(title=expression(paste("Motor Vehicle Emissions of PM",""[2.5], " in the Baltimore city"," from 1999 to 2008")))+theme_bw()
dev.off()
