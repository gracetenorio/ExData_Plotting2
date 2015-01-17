## ----------------------------------------------------------------------------
##
## plot2.R:  Creates a plot showing the total PM2.5 emission for Baltimore
##           from all sources for each of the years 1999, 2002, 2005 and 2008.
##
## ----------------------------------------------------------------------------

# Import emissions and source classification code data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Compute total emissions by year for the city of Baltimore.
# Note: My interpretation of "total" emissions includes emissions from all sources.
#       I compute this using the values in the "Emissions" field of the NEI dataset.  
bal1 <- subset(NEI,fips=="24510")
bal2 <- aggregate(Emissions ~ year, sum, data=bal1, na.rm=TRUE)


# Create plot showing total emissions by year for Baltimore in order to answer the question:
# Have total emissions from PM2.5 decreased in Baltimore City from 1999 to 2008? 
png("plot2.png")

par(mar=c(6,8,4,4)) 
plot(bal2$year, bal2$Emissions, type="o", lwd=1.5, axes=FALSE, 
     xlab=NA, ylab=NA, col="blue", 
     main=expression('PM'[2.5]*' Emissions in Baltimore by Year'), cex.main=1)
box()

axis(side=1, at=c(1999,2002,2005,2008), tck=-0.02, cex.axis=0.7)
axis(side=2, at=c(2000,2400,2800,3200), las=1, tck=-0.02, srt=90, cex.axis=0.7,
     labels=c("2,000","2,400","2,800","3,200"))

mtext(side=1, "Year",line=3, cex=0.9)
mtext(side=2, "Emissions (in tons)",line=3, cex=0.9)

dev.off()


# Conclusion: PM2.5 emissions decreased in Baltimore from 1999 (3274 tons) to 2008 (1862 tons).  
#             Despite seeing an increase from 2002 (2453 tons) to 2005 (3091 tons), Baltimore's
#             PM2.5 emissions has significantly decreased in this 10-year period.



