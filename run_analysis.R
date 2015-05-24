## First check to see if the raw data has been downloaded and is available
## The url is hardcoded as the lecture recommends locking down all parameters/variables so that the script produces reproducible results

## Instructions
## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement. 
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Set the url to the raw data
rawDataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## Downlaod the raw data as a zip file if it does not exists
if( !file.exists("./data/rawdata.zip"))
{
    download.file(rawDataUrl,destfile = "./data/rawdata.zip",method = "curl", mode= "wb")
    
    ## now extract the files from the zip file
    unzip("./data/rawdata.zip")
}

availPackages<- .packages(all.available = TRUE)
isAvail <- availPackages[] == "dplyr"  ## Check to see of dplyr is loaded
if(!(sum(isAvail) >0))
{
    install.packages("dplyr")
    
}
library(dplyr) ## Load dplyr
isAvail <- availPackages[] == "reshape2"  ## Check to see of dplyr is loaded
if(!(sum(isAvail) >0))
{
    install.packages("reshape2")
    
}
library(reshape2)

## Get the feature names which will be the column names for the X_train.txt used to satisfy step 4 
featureNames <- read.table("./UCI HAR Dataset/features.txt")

## Read in the X_train data and add the column names (which satisfies step 4 meaningful variable names)
xTrain <- read.table(file="./UCI HAR Dataset/train/X_train.txt", col.names = featureNames$V2)

## Read in the X_test data and add the column names (which satisfies step 4 meaningful variable names)
xTest <- read.table(file="./UCI HAR Dataset/test/X_test.txt", col.names = featureNames$V2)

## Read and add the columns for subject and activity to the xTrain data frame
yTrain <- read.table(file="./UCI HAR Dataset/train/y_train.txt", col.names = c("Activity"))
subjectTrain <- read.table(file="./UCI HAR Dataset/train/subject_train.txt", col.names = c("Subject"))

## Using column bind add the activity vector
allTrain <- cbind(yTrain,xTrain)

## Using column bind add the subject ids vector
allTrain <- cbind(subjectTrain,allTrain)

## Read and add the columns for subject and activity to the xTest data frame
yTest <- read.table(file="./UCI HAR Dataset/test/y_test.txt", col.names = c("Activity"))
subjectTest <- read.table(file="./UCI HAR Dataset/test/subject_test.txt", col.names = c("Subject"))

## Using column bind add the activity vector
allTest <-cbind(yTest,xTest)

## Using column bind add the subject ids vector
allTest <-cbind(subjectTest,allTest)

## Combine all of the data into a single data set
allData <- rbind(allTrain,allTest)

## Step 2 Extract the columns that contain means and standard deviations
meansAndStd <- select(allData,contains("Subject"),contains("Activity"),contains("mean"), contains("std"))

## Step 3 Label the activities
activityId <- c(1,2,3,4,5,6)
activityName <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
meansAndStd$Activity <- factor(meansAndStd$Activity,levels= activityId, labels = activityName)

## Step 5 make the tidy data

valuesAsColumns <- names(select(meansAndStd, -(Subject:Activity))) ## This will get all of the measurement column names
 
result <- melt (meansAndStd, id=c("Subject","Activity"), measure.vars = valuesAsColumns)

result <- rename(result, MeasurementType = variable)
tidyDataResult <- summarize( group_by(result,Subject,Activity, MeasurementType), MeasurementMean = mean(value) )
##print(tidyDataResult)
write.table(tidyDataResult, file = "smartphoneTidyData.txt", row.names=FALSE)
