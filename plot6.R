## the plotting of plot6 will be covered in plot6.R

## plot6.R

## Step 6.1: verification of the files' location for processing:
file1 = "Source_Classification_Code.rds"
file2 = "summarySCC_PM25.rds"
if (!file.exists (file1) || !file.exists (file2))  {
        print ("please kindly make sure that the file <<exdata_data_NEI_data.zip>> from <<https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip>>  has been downloaded, unzipped and placed in current working directory")
        print ("do kindly, use setwd( the_current_wd.../exdata_data_NEI_data/) to set the new working directory for access to the .rds files")
}

## Step6.2: This first line will likely take a few seconds. Be patient!
print ("Loading data of <<summarySCC_PM25.rds>>")
NEI = readRDS("summarySCC_PM25.rds")
print ("Loading data of <<Source_Classification_Code.rds>>")
SCC = readRDS("Source_Classification_Code.rds")
print ("Loading data is Successful!")

## Step6.3: Loading the required libraries
library(ggplot2)

## Step6.4: Sorting out the data to plot
## Step6.4.1: Segregate the vehicles in SCC.
wheels = grep ("vehicle", SCC$EI.Sector, value = T, ignore.case = T)
sccWheels = subset (SCC, EI.Sector %in% wheels, select = SCC)
## Step6.4.2: as the fips is the number for the b_more/la cali, we will assign a vector to collect all the subsets.
bm_cali = subset (NEI, fips == "06037" | fips == "24510")
## Step6.4.3: get the data of the cars in b_more/la cali.
tWheels = subset(bm_cali, bm_cali$SCC %in% sccWheels$SCC)
## Steps6.4.4: Split tWheels data into subsets, computes summary statistics for each, and returns the result in a convenient form.
wheelsData = aggregate(tWheels[c("Emissions")], list(fips = tWheels$fips, year = tWheels$year), sum)
## Steps6.4.5: Since there is only fips for town indentification, we will now add in a new col (city), to assign the town for plotting.
wheelsData$city <- rep(NA, nrow(wheelsData))
## Steps6.4.5.1: adding LA Country to city col of fips 06037
wheelsData[wheelsData$fips == "06037", ][, "city"] <- "Los Angles County"
## Steps6.4.5.2: adding LA Country to city col of fips 24510
wheelsData[wheelsData$fips == "24510", ][, "city"] <- "Baltimore City"

## Step 6.5: plotting graph
print ("Proceeding to plot <<plot6.png>>")
png("plot6.png", height=480, width=480)
qplot(year, Emissions, data=wheelsData, geom="line", color=city) + 
ggtitle(expression("Motor Vehicle PM[2.5] Emission Levels\nLos Angeles County, CA vs Baltimore, MD")) + 
xlab("Year") + ylab(expression("Levels of" ~ PM[2.5] ~ " Emissions"))
dev.off()
print ("plot6.png is now available")

#Question 6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
#in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?
# Answer: Los Angeles County, as its total gradient over time is larger than Baltimore City
