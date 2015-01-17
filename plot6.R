## ----------------------------------------------------------------------------
##
## plot6.R:  Creates a plot comparing emissions from motor vehicle sources
##           in Baltimore and Los Angeles County from 1999 to 2008.
##
## ----------------------------------------------------------------------------

# Import emissions and source classification code data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Identify SCC codes related to motor vehicle sources.
# Note: My definition of motor vehicle sources are those whose Short Name includes
#       the string "Highway Veh".  Looking at the data, this rule appears to cover 
##      what I consider sources related to motor vehicles.
veh <- subset(SCC, grepl("Highway Veh", Short.Name), select=c(SCC, Data.Category,Short.Name))
veh2 <- unique(as.character(veh$SCC))


# Subset NEI dataset to include only motor vehicle related emissions data in Baltimore
# and Los Angeles County
vbal <- subset(NEI,SCC %in% veh2 & fips %in% "24510")
vlac <- subset(NEI,SCC %in% veh2 & fips %in% "06037")

# Get total emissions by year 
vbal2 <- aggregate(Emissions~year, data=vbal, sum, na.rm=TRUE)
vlac2 <- aggregate(Emissions~year, data=vlac, sum, na.rm=TRUE)

# Look at rate of change in emissions, from year to year
b = vbal2$Emissions
l = vlac2$Emissions

bal_rate = c( (b[2]-b[1])/b[1], (b[3]-b[2])/b[2], (b[4]-b[3])/b[3] ) * 100
lac_rate = c( (l[2]-l[1])/l[1], (l[3]-l[2])/l[2], (l[4]-l[3])/l[3] ) * 100

# Intervals used to calculate rate of change: 1999-2002, 2002-2005, 2005-2008
# These intervals will be represented by a numeric vector with 3 elements
interval <- c(1, 2, 3)

# Combine rate vectors with interval vector
df <- as.data.frame(cbind(year, bal_rate,lac_rate))


# Create plot in order to answer the question:
# Which city has seen greater changes over time in motor vehicle emissions?
png("plot6.png")

par(mar=c(6,8,4,4)) 
plot(df$year, df$bal_rate, type="o", lwd=1.5, axes=FALSE, 
     xlab=NA, ylab=NA, col="blue", ylim=c(-100,100),
     main=expression('Rate of Change in PM'[2.5]*' Emissions'), cex.main=1)
lines(df$year,df$lac_rate, type="o", lwd=1.5, col="red")
box()

axis(side=1, at=c(1,2,3), labels=c("1999-2002", "2002-2005", "2005-2008"), tck=-0.02, cex.axis=0.7)
axis(side=2, at=c(-100,-50, 0, 50, 100), las=1, tck=-0.02, srt=90, cex.axis=0.7)

mtext(side=1, "Year",line=3, cex=0.9)
mtext(side=2, "Rate of Change in Emissions (%)",line=3, cex=0.9)
legend("topright", legend=c("Baltimore","Los Angeles"), lty=c(1,1), col=c("black","red"), cex=0.8, pt.cex=0.4)

dev.off()


# Conclusion:  Baltimore has seen greater changes over time in motor vehicle emissions compared to
#              Los Angeles County. In particular, Baltimore saw a 61% decrease in emissions between
#              1999 and 2002 and another major decrease at 32% between 2005 and 2008.  Los Angeles,
#              on the other hand, have sen some changes, but not quite at the same scale.  The 
#              biggest change was a 10% decrease in emissions which occurred between 2005 and 2008.





