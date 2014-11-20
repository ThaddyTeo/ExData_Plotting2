## the plotting of plot1 will be covered in plot1.R

## plot1.R
## Step 1.1: verification of the files' location for processing:
file1 = "Source_Classification_Code.rds"
file2 = "summarySCC_PM25.rds"
if (!file.exists (file1) || !file.exists (file2))  {
        print ("please kindly make sure that the file <<exdata_data_NEI_data.zip>> from <<https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip>>  has been downloaded, unzipped and placed in current working directory")
        print ("do kindly, use setwd( the_current_wd.../exdata_data_NEI_data/) to set the new working directory for access to the .rds files")
}

## Step1.2: This first line will likely take a few seconds. Be patient!
print ("Loading data of <<summarySCC_PM25.rds>>")
NEI <- readRDS("summarySCC_PM25.rds")
## SCC data is NOT needed in plot1.png
print ("Loading data is Successful!")

## Step1.3: sorting out data
## Step1.3.1: Run a check for data values of NEI to verify if the Emissions value and year are of the same data length
## and the presence of N.A. values 
identical( length(NEI$Emissions), length(NEI$year)) 
which(is.na(NEI$Emissions + NEI$year))
## Step 1.3.2, as the Emissions value are large, they will be converted to Kilotons
pmKilo = (NEI$Emissions/1000)
## Step 1.3.3tapply is used as it helps to form a gradual gradient through out the plot.
tPM25y = tapply(pmKilo, NEI$year, sum)

## Step1.4: plotting graphs
print ("Proceeding to plot <<plot1.png>>")
png("plot1.png", height=480, width=480)
plot(names(tPM25y), tPM25y, type = "l",
     main = "Total Emissions from PM2.5 in the US",
     xlab = "Year", ylab = "Emissions (Kilotons)", col ="Red")
dev.off()
print ("plot1.png is now available")

# Answer to question 1:
#Yes, from plot1.png, we can observed that there is a declined from 1999 to 2002. 
#However between 2002 and 2005, the gradient of the decline mellowed, 
#which was followed by a sharper gradient of decline from 2005 to 2008.