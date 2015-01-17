## ----------------------------------------------------------------------------
##
## plot5.R:  Creates a plot showing emissions from motor vehicle sources
##           from 1999–2008 in Baltimore.
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
mv <- subset(NEI,SCC %in% veh2 & fips=="24510")
mv2 <- aggregate(Emissions~year, data=mv, sum, na.rm=TRUE)


# Create plot in order to answer the question:
# Have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
png("plot5.png")
par(mar=c(6,8,4,4)) 
plot(mv2$year, mv2$Emissions, type="o", lwd=1.5, axes=FALSE, 
     xlab=NA, ylab=NA, col="blue", 
     main=expression('PM'[2.5]*' Emissions Related to Motor Vehicles (Baltimore)'), cex.main=1)
box()

axis(side=1, at=c(1999,2002,2005,2008), tck=-0.02, cex.axis=0.7)
axis(side=2, at=c(100,200,300,400), las=1, tck=-0.02, srt=90, cex.axis=0.7,
     labels=c("100","200","300","400"))

mtext(side=1, "Year",line=3, cex=0.9)
mtext(side=2, "Emissions (in tons)",line=3, cex=0.9)

dev.off()


# Conclusion:  Emissions related to motor vehicles in Baltimore have decreased
#              from 1999 to 2008, with the most dramatic decline occuring between
#              1999 and 2002.



