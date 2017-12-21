setwd("./coursera/exploratory_data_analysis/ExData_Plotting2")
# Library
library(ggplot2)

# Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 4: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

#Find SCC that is related to Coal combustion
coal <-grepl("coal",SCC$Short.Name,ignore.case=TRUE)
comb <-grepl("comb",SCC$Short.Name,ignore.case=TRUE)
coal.comb <-coal&comb
SCC.coal.comb <-SCC$SCC[coal.comb]

#Find NEI data that is related to Coal combustion
NEI.coal.comb<- NEI[NEI$SCC %in% SCC.coal.comb,]


#plot by source type
png("plot4.png",width=480,height=480)
g<-ggplot(NEI.coal.comb,aes(factor(year),Emissions/1000))
g+geom_bar(stat="identity")+
        labs(x="Year", y=expression(paste("Total Emissions of PM",""[2.5]," (10^3 x Tons)")))+
        labs(title=expression(paste("Coal Combustion-related Emissions of PM",""[2.5], "from 1999 to 2008")))+theme_bw()
dev.off()
