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

baltimore <- NEI[NEI$fips=='24510',]
# Summarize the total emissions for each source and convert to a data frame
summary <-as.data.frame(as.table(tapply(baltimore$Emissions, list(baltimore$type, baltimore$year), sum)))

# Create the basic plot

png(filename = "plot3.png")
require(package = ggplot2)
g <- ggplot(
        data = summary,
        aes(Var2, Freq))
p <- g +
        geom_point() +
        facet_grid(. ~ Var1) +
        geom_smooth(aes(group=1), method='lm', se=FALSE) +
        ggtitle(
                label = expression(atop(PM[2.5] * " Emissions Trend 1999 to 2008", atop("Baltimore City, MD")))) +
        ylab(label = "Total Emissions") + xlab(label = "Years")
print(p)
dev.off()