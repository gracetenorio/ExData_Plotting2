## ----------------------------------------------------------------------------
##
## plot1.R:  Creates a plot showing the total PM2.5 emission from all sources 
##           for each of the years 1999, 2002, 2005 and 2008 in the US.
##
## ----------------------------------------------------------------------------

# Import emissions and source classification code data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Compute total emissions by year. 
# Note: My interpretation of "total" emissions includes emissions from all sources.
#       I compute this using the values in the "Emissions" field of the NEI dataset.  
sub <- aggregate(Emissions ~ year, sum, data=NEI, na.rm=TRUE)


# Create plot showing total emissions by year in order to answer the question:
# "Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?"
png("plot1.png")

par(mar=c(6,8,4,4)) 
plot(sub$year, sub$Emissions, type="o", lwd=1.5, axes=FALSE, 
     xlab=NA, ylab=NA, col="blue", 
     main=expression('Total PM'[2.5]*' Emissions by Year'), cex.main=1)
box()

axis(side=1, at=c(1999,2002,2005,2008), tck=-0.02, cex.axis=0.7)
axis(side=2, at=c(4e+06,5e+06,6e+06,7e+06,8e+06), las=1, tck=-0.02, srt=90, cex.axis=0.7,
           labels=c("4,000,000","5,000,000","6,000,000","7,000,000","8,000,000"))

mtext(side=1, "Year",line=3, cex=0.9)
mtext(side=2, "Emissions (in tons)",line=5, cex=0.9)

dev.off()


# Conclusion:  Total emissions from PM2.5 have decreased in the United States from 1999 to 2008.


