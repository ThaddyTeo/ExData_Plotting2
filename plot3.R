## the plotting of plot3 will be covered in plot3.R

## plot3.R
## Step 3.1: verification of the files' location for processing:
file1 = "Source_Classification_Code.rds"
file2 = "summarySCC_PM25.rds"
if (!file.exists (file1) || !file.exists (file2))  {
        print ("please kindly make sure that the file <<exdata_data_NEI_data.zip>> from <<https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip>>  has been downloaded, unzipped and placed in current working directory")
        print ("do kindly, use setwd( the_current_wd.../exdata_data_NEI_data/) to set the new working directory for access to the .rds files")
}

## Step3.2: This first line will likely take a few seconds. Be patient!
print ("Loading data of <<summarySCC_PM25.rds>>")
NEI = readRDS("summarySCC_PM25.rds")
## SCC data is NOT needed in plot2.png
print ("Loading data is Successful!")

## Step3.3: Loading the required libraries
library(ggplot2)

## Step 3.4: Sorting out the data to plot
## Step3.4.1: as the fips is the number for the b_more, we will assign a vector to collect all the subsets.
b_more = subset (NEI, fips == "24510")
## Step3.4.2: Split b_more data into subsets, computes summary statistics for each, and returns the result in a convenient form.
tPM25y <- aggregate(b_more[c("Emissions")], list(type = b_more$type, year = b_more$year), sum)

## Step3.5: plotting graph
print ("Proceeding to plot <<plot3.png>>")
png("plot3.png", height=480, width=480)
qplot(year, Emissions, data=tPM25y, geom ="line", color=type) + 
ggtitle(expression(PM[2.5] ~ "Emmission by type in Baltimore City")) + 
xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()
print ("plot3.png is now available")

#Answer:
#Non-road (red line): According to data from the plot, a gradual decline gradient can be seen from 1999 to 2002, followed by a plateu gradient till 2005. From 2005-2008, the data resumed the the gradual decline gradient.
#Nonpoint (green line): This data has a steep decline gradient from 1999 to 2002, followed by a followed by a plateu gradient till 2005. From 2005-2008, a farther gradual decline gradient of emissions is seen. 
#On-road (blue line): A gradual decline of data of the PM2.5 emission levels are seen from 1999 to 2002, after which it was followed by a lesser gradient decline from 2002-2005. There is a increase of decline gradient of 2005-2008.
#Point (purple line): The plot has shown that there is a increase in gradient of the data from 1999-2002, which was followed by a sharper gradient of increase from 2002-2004. From 2005-2008, a sharp decline was seen.
