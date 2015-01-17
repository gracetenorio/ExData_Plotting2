## ----------------------------------------------------------------------------
##
## plot4.R:  Creates a plot showing emissions from coal combustion-related 
##           sources from 1999–2008.
##
## ----------------------------------------------------------------------------

# Import emissions and source classification code data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Identify SCC codes related to coal combustion sources.
# Note: My definition of coal combustion-related sources are those whose
#       Short Name include both the strings "Comb" and "Coal".
#       Looking at the data, this rule appears to cover what I consider
##      sources related to coal combustion.
codes <- subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", Short.Name), 
             select=c(SCC, Data.Category,Short.Name))
codes2 <- unique(as.character(codes$SCC))


# Subset NEI dataset to include only coal combustion-related emissions data 
cc <- subset(NEI,SCC %in% codes2)
coal <- aggregate(Emissions~year, data=cc, sum, na.rm=TRUE)


# Create plot in order to answer the questions:
# How have emissions from coal combustion-related sources changed from 1999–2008?
png("plot4.png")
par(mar=c(6,8,4,4)) 
plot(coal$year, coal$Emissions, type="o", lwd=1.5, axes=FALSE, 
     xlab=NA, ylab=NA, col="blue", 
     main=expression('PM'[2.5]*' Emissions Related to Coal Combustion'), cex.main=1)
box()

axis(side=1, at=c(1999,2002,2005,2008), tck=-0.02, cex.axis=0.7)
axis(side=2, at=c(350000,450000,550000), las=1, tck=-0.02, srt=90, cex.axis=0.7,
     labels=c("350,000","450,000","550,000"))

mtext(side=1, "Year",line=3, cex=0.9)
mtext(side=2, "Emissions (in tons)",line=4, cex=0.9)

dev.off()


# Conclusion:  Emissions related to coal combustion in the United States have
#              decreased from 1999 to 2008, despite seeing a slight increase 
#              from 2002 (547,380 tons) and 2005 (553,549 tons).


