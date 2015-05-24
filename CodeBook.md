# Getting and Cleaning Data Assignment CodeBook

## Data Source
The raw data as received from this analysis was downloaded from the [UC Irvine machine learning respository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The run_analysis script downloads the zip file and expands the appropriate directories and data.

## Data Description
This code book builds on the code book provided by the source data. The code book for the raw data is in features_info.txt. New or modified variables will be defined below 

### Measurement Data
For the assignment only the columns containing "mean" variable means or "std" for variable standard deviations in the variable (column) name will be used from the features raw data.

### Subject Data
Subject or participant data is found in the subject_test and subject_train text files. A new variable "Subject" will be part of the final tidyData dataset and it represents the id of the participant.

### Activity Data
The activity code book is found in activity_lables.txt. The values for the activities are found in y_test.txt and y_train.txt. A new variable "Activity" will be part of the final tidyData dataset and it represents the activity performed by a participant.

### Mesurement Type
A new variable "MeasurementType" will be part of the final tidydata dataset and its values will be the measurement names from Measurement Data above.

### Measurement Mean
The variable name representing the mean for a MeasurementType for a given subject and activity. 

## Data Transformations
This section outlines the steps taken in the code to prepare the data.
* Reading the raw data
+ First I read in the features as described in features_info.txt into a vector. This will be used to provide meaningful column names for the feature data that I read next
+ I then read in the raw measure data for training and test data from X_train.txt and X_test.txt, providing the column names from the step above. Each row (see features_info.txt) is a row vector of 561 measurements.
* Reading the Activity  and Subject Data
+ I next read the Activity  and Subject data into a vector that can be used to column bind with the measurement data
* Combining Subject, Activity and Measurement Data
+ Using the activity and subject data from the test directory I column bind the "Activity" vector from the prior step with the measurement data and then the "Subject" vector with the prior results. This results in a data table with Subject, Activity and the 561 measurement columns
*Reduction of the Measurements Columns
+ I know create a data table that contains Subject, Activity and any columns containing "mean" or "std" in the title
* Meaningful variable names and values
+ Activity variable ranged from values 1 - 6. Using the activity_lables.txt code book descrpriptive activities are assigned based on the activity Id in the "Activity" variable column

## Tidy Data
After the above transformations the resulting data table is not tidy becuase in the case of the measurement columns they are values not variables. The measurement column headers are unique and there for can be values for a new variable "MeasurementType" as described above.
* Making the data tidy
+ I used melt with IDs of Subject and Activity and the new variable MeasurementType to capture the measurement name and MeasurementMean value to capture the mean value of the measurement for a given subject and activity. This results in a tall data set but it is tidy since each observations is in a sigle row and there are no variables that are actually values as was the case with the measurement names.

## Variable List Summary
*The variables in the table are:
+ Subject - Id from 1-30 representing the actual participant
+ Activity - A level with a meaningful name for the activity
+ MeasurementType - A variable with values that are measurements (features) from features.txt containing eithe "mean" or "std" in the feature name. An explanation of the meaning the variables can be found in features_info.txt
+ MeasurementMean - the mean for a measure for a given subject and activity.