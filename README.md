# Introduction
This assignment uses data from the [UC Irvine machine learning respository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) for assignment one in the Getting and Cleaning Data course.

The dataset for the assignment is composed of acceloremeter and gyroscope measurements from a Samsung Galaxy S smartphone. The data set can be found here:
* Dataset: [Smartphone Data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* Description: This data set contains the subject (person), activity(e.g. walking, sitting) and measurements collected from the smartphone sensors

# Script Execution
The run_analysis script can be run from any directory. The script will check for the presence of the required directory structure and data. If the data is not found it will download the appropriate data. It will also check for and if necessary installl the appropriate packages needed for script execution.

To run the script type run_analysis.R

# Script Output
The script will output a tidy data set into the file smartphoneTidyData.txt

# Code Book
Use the code book, CodeBook.md, to understand how the data was assembled and the variables and their values. 

