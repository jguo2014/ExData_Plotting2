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

# Get the total emissions for each of these years
totalEmissions <- tapply(NEI$Emissions, NEI$year, sum)

# Plot the totalEmissions data (barplot)
png("plot1.png", width=480, height=480, bg="lightgrey")

barplot(totalEmissions, main=expression('Total emissions of PM'[2.5]*' from 1999 to 2008'),
        xlab='Years', ylab=expression('PM'[2.5]), ylim=c(0, 8000000), col=c("red", "yellow", "darkgreen","green"))
abline(lm(totalEmissions~c(1:4)), lty=1, pch=3 ,col='black')
text(3.1, 6000000, labels='Overall trend', col='black')
dev.off()