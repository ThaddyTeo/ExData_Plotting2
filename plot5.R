## the plotting of plot5 will be covered in plot5.R

## plot5.R

## Step 5.1: verification of the files' location for processing:
file1 = "Source_Classification_Code.rds"
file2 = "summarySCC_PM25.rds"
if (!file.exists (file1) || !file.exists (file2))  {
        print ("please kindly make sure that the file <<exdata_data_NEI_data.zip>> from <<https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip>>  has been downloaded, unzipped and placed in current working directory")
        print ("do kindly, use setwd( the_current_wd.../exdata_data_NEI_data/) to set the new working directory for access to the .rds files")
}

## Step5.2: This first line will likely take a few seconds. Be patient!
print ("Loading data of <<summarySCC_PM25.rds>>")
NEI = readRDS("summarySCC_PM25.rds")
print ("Loading data of <<Source_Classification_Code.rds>>")
SCC = readRDS("Source_Classification_Code.rds")
print ("Loading data is Successful!")

## Step5.3: Loading the required libraries
library(ggplot2)

## Step5.4: Sorting out the data to plot
## Step5.4.1: as the fips is the number for the b_more, we will assign a vector to collect all the subsets.
b_more = subset (NEI, fips == "24510")
## Step5.4.2: Segregate the vehicles in SCC.
wheels = grep ("vehicle", SCC$EI.Sector, value = T, ignore.case = T)
sccWheels = subset (SCC, EI.Sector %in% wheels, select = SCC)
## Step5.4.3: Segregate the vehicles of NEI in baltimore (b_more)
bWheels = subset(b_more, b_more$SCC %in% sccWheels$SCC)
## Steps5.4.4: Split bWheels data into subsets, computes summary statistics for each, and returns the result in a convenient form.
wheelsD = aggregate(bWheels[c("Emissions")], list(year = bWheels$year), sum)

## Step 5.5: plotting graph:
print ("Proceeding to plot <<plot5.png>>")
png("plot5.png", height=480, width=480)
qplot(year, Emissions, data=wheelsD, geom="line") + 
ggtitle(expression("Motor Vehicle" ~ PM[2.5] ~ "Emissions in Baltimore City by Year")) + xlab("Year") + 
ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()
print ("plot5.png is now available")

#Question 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City? 
#Answer: Based on the graph shown on plot5.png, there is a sharp decline of PM2.5 emissions from 1999-2002.
# Which is followed by a gradual gradient decrease from 2002 to 2005 and a steeper decrease in gradient
# 2005 - 2008