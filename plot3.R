## ----------------------------------------------------------------------------
##
## plot3.R:  Creates a plot showing the total PM2.5 emission by source type
##           for Baltimore for each of the years 1999, 2002, 2005 and 2008.
##
## ----------------------------------------------------------------------------

# Import emissions and source classification code data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Compute total emissions by year for Baltimore for each of the 4 source types: 
# point, nonpoint, onroad and nonroad.  
balt  <- subset(NEI,fips=="24510")
balt2 <- aggregate(balt$Emissions, by=list(balt$year,balt$type), sum, na.rm=TRUE)


# Create plot in order to answer the questions:
# "Which of the four sources have seen decreases in emissions from 1999–2008 for 
#  Baltimore City? Which have seen increases in emissions from 1999–2008? 
library(ggplot2)
library(grid)

png("plot3.png",width=600, height=600)
g <- ggplot(balt2, aes(Group.1,x)) 
g <- g + geom_point() + geom_line() + facet_grid (. ~ Group.2) 
g <- g + xlab("Year") + ylab(expression('PM'[2.5]*' Emissions (in tons)')) +
     ggtitle(expression('PM'[2.5]*' Emissions by Source Type')) 
g
dev.off()


# Conclusion:  NONPOINT and ON-ROAD have seen a decrease in emissions from 1999 to 2008.
#              NON-ROAD has seen an increase in emissions from 2002 (240.8 tons) to 
#              2005 (248.9 tons), while POINT has seen an increase from 1999 (296.8 tons)
#              to 2002 (569.3 tons), and then again from 2002 to 2005 (1202.5 tons).

