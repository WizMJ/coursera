setwd("./coursera/exploratory_data_analysis/ExData_Plotting2")
# Library
library(ggplot2)

# Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? 

# Extract baltimore city data
baltimore <-subset(NEI,fips=="24510")

#plot by source type
png("plot3.png",width=480,height=480)
g<-ggplot(baltimore,aes(factor(year),Emissions,fill=type))
g+geom_bar(stat="identity")+facet_grid(.~as.factor(type))+theme_bw()+labs(fill="Type")+
        labs(x="Year", y=expression(paste("Total Emissions of PM",""[2.5]," (Tons)")))+
        labs(title=expression(paste("Emissions of PM",""[2.5], " by source type"," in the Baltimore city"," from 1999 to 2008")))
dev.off()
