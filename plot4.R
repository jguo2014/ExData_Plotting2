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

coal <- grepl('([cC]omb.*[cC]oal)', SCC$EI.Sector) 
sccCodes <- SCC[coal, 'SCC']

combustionCoal <- NEI[NEI$SCC %in% sccCodes, ]
coalEmissions <- tapply(combustionCoal$Emissions, combustionCoal$year, sum)

# Plot the coalEmissions data (barplot)
png("plot4.png", width=480, height=480, bg="lightgrey")

barplot(coalEmissions, main=expression('Total coal-combustion emissions of PM'[2.5]*''),
        xlab='Years', ylab=expression('PM'[2.5]), ylim=c(0, 700000), col=c("red", "yellow", "darkgreen","green"))
abline(lm(coalEmissions~c(1:4)), lty=1, pch=3 ,col='black')
text(4.1, 600000, labels='Overall trend', col='black')
dev.off()