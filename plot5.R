##Exract Data 
if (!file.exists("data")) {
        dir.create(path = "data")
}
if (file.exists("exdata_data_NEI_data.zip")) {
        if (!is.element('summarySCC_PM25.rds', dir()) | !is.element('summarySCC_PM25.rds', dir())) {
                unzip(zipfile = "exdata_data_NEI_data.zip", exdir = "data")
        }
        
}

# Load the data into the R
NEI <- readRDS(file = "data/summarySCC_PM25.rds")
SCC <- readRDS(file ="data/Source_Classification_Code.rds")

mobile <- grepl('Mobile Sources', SCC$SCC.Level.One)
sccCodes <- SCC[mobile, 'SCC']

mobileSourse <- NEI[NEI$SCC %in% sccCodes & NEI$fips=='24510', ]
mobileEmissions <- tapply(mobileSourse$Emissions, mobileSourse$year, sum)

# Plot the mobileEmissions data (barplot)
png("plot5.png", width=480, height=480, bg="lightgrey")

barplot(mobileEmissions, main=expression('Total mobile emissions of PM'[2.5]*' in Baltimore City'),
        xlab='Years', ylab=expression('PM'[2.5]), ylim=c(0, 2000), col=c("red", "yellow", "darkgreen","green"))
abline(lm(mobileEmissions~c(1:4)), lwd=2,col='black')
text(3.1, 1000, labels='Overall trend', col='black')
dev.off()
