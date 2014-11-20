## the plotting of plot2 will be covered in plot2.R

## plot2.R
## Step 2.1: verification of the files' location for processing:
file1 = "Source_Classification_Code.rds"
file2 = "summarySCC_PM25.rds"
if (!file.exists (file1) || !file.exists (file2))  {
        print ("please kindly make sure that the file <<exdata_data_NEI_data.zip>> from <<https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip>>  has been downloaded, unzipped and placed in current working directory")
        print ("do kindly, use setwd( the_current_wd.../exdata_data_NEI_data/) to set the new working directory for access to the .rds files")
}

## Step2.2: This first line will likely take a few seconds. Be patient!
print ("Loading data of <<summarySCC_PM25.rds>>")
NEI = readRDS("summarySCC_PM25.rds")
## SCC data is NOT needed in plot2.png
print ("Loading data is Successful!")

## Step 2.3: sorting out the data
## Step2.3.1: as the fips is the number for the b_more, we will assign a vector to collect all the subsets.
b_more = subset (NEI, fips == "24510")
## Step2.3.2: tapply is used as it helps to form a gradual gradient of PM2.5 through out the plot.
tPM25y <- tapply(b_more$Emissions, b_more$year, sum)

## Step2.4: plotting graphs
print ("Proceeding to plot <<plot2.png>>")
png("plot2.png", height=480, width=480)
plot(names(tPM25y), tPM25y, type = "l",
     main = "Total Emissions of PM2.5, Baltimore City, MD",
     xlab = "Year", ylab = "Emissions", col ="Purple")

dev.off()
print ("plot2.png is now available")

#Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.
# Answer: Accordingly to the data reflected in plot2.png, there is an indication of a sharp decline between 1999 and 2002.
# This is folowed by a sharp increase which was seen in the data from 2002 to 2005. After which a sharp gradient decline was
# noticed from 2005 to 2008.