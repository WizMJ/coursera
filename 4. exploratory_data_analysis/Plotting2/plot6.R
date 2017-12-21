setwd("./coursera/exploratory_data_analysis/ExData_Plotting2")
# Library
library(ggplot2)

# Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037")

#Find SCC that is related to motor vehicle
vehicle <-grepl("vehicle",SCC$SCC.Level.Two,ignore.case=TRUE)
SCC.vehicle <-SCC$SCC[vehicle]

#Find NEI of baltimore or LA data that is related to motor vehicle
baltimore.la <-subset(NEI,fips=="24510"|fips=="06037")
baltimore.la.vehicle<- baltimore.la[baltimore.la$SCC %in% SCC.vehicle,]

#Assign city name
baltimore.la.vehicle$fips[baltimore.la.vehicle$fips=="24510"]<-"Baltimore City"
baltimore.la.vehicle$fips[baltimore.la.vehicle$fips=="06037"]<-"Los Angeles County"


#plot by source type
png("plot6.png",width=480,height=480)
g<-ggplot(baltimore.la.vehicle,aes(factor(year),Emissions))
g+geom_bar(stat="identity")+facet_grid(.~fips)+
        labs(x="Year", y=expression(paste("Total Emissions of PM",""[2.5]," (Tons)")))+
        labs(title=expression(paste("Motor Vehicle Emissions of PM",""[2.5], " in the Baltimore city and LA County"," from 1999 to 2008")))+theme_bw()
dev.off()
