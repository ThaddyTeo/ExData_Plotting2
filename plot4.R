## the plotting of plot4 will be covered in plot4.R

## plot4.R
## Step 4.1: verification of the files' location for processing:
file1 = "Source_Classification_Code.rds"
file2 = "summarySCC_PM25.rds"
if (!file.exists (file1) || !file.exists (file2))  {
        print ("please kindly make sure that the file <<exdata_data_NEI_data.zip>> from <<https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip>>  has been downloaded, unzipped and placed in current working directory")
        print ("do kindly, use setwd( the_current_wd.../exdata_data_NEI_data/) to set the new working directory for access to the .rds files")
}

## Step4.2: This first line will likely take a few seconds. Be patient!
print ("Loading data of <<summarySCC_PM25.rds>>")
NEI = readRDS("summarySCC_PM25.rds")
print ("Loading data of <<Source_Classification_Code.rds>>")
SCC <- readRDS("Source_Classification_Code.rds")
print ("Loading data is Successful!")

## Step4.3: Loading the required libraries
library(ggplot2)

## Step 4.4: Sorting out the data to plot the graph
## Step 4.4.1: acquiring the coal data
sCCoal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]
## Step 4.4.2: merging the data, via SCC into a full data set to facilitate printing of plot
dataMerge = merge(x = NEI, y = sCCoal, by = 'SCC')
## Step 4.4.3: Split dataMerge data into subsets, computes summary statistics for each, and returns the result in a convenient form.
sumDataM = aggregate(dataMerge[c('Emissions')], by = list (dataMerge$year), sum)
## Step 4.4.4: Adding Col names to facilitate the plotting of the graph.
colnames(sumDataM) <- c('Year', 'Emissions')

## Step 4.5: plotting graph:
print ("Proceeding to plot <<plot4.png>>")
png("plot4.png", height=480, width=480)
ggplot(data=sumDataM, aes(x=Year, y=Emissions/1000)) +
geom_line(aes(group=1, col=Emissions)) + geom_point(aes(size=2, col=Emissions)) +
ggtitle(expression(paste('Total Coal Emissions of PM'[2.5],'Across US'))) +
ylab(expression(paste('PM'[2.5], '(kilotons)'))) +
geom_text(aes(label=round(Emissions/1000,digits=2), size=2, hjust=1.5, vjust=1.5)) +
theme(legend.position='none') + scale_colour_gradient(low='red', high='black')

dev.off()
print ("plot4.png is now available")

#Answer:
#According to the data as seen on Plot4.png, we ca see that there is a decline of Total coal emissions of PM2.5 from 199-2002.
#After which it was followed by a slight gradient increase from 2002-2005. From 2005-2008 we can see a sharp from of the PM2.5 Coal emissions.