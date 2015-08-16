# GettingAndCleaningData
Repository for Getting and cleaning data course project

The purpose of this project is to demonstrate your ability to collect, work with
, and clean a data set. The goal is to prepare tidy data that can be used for
later analysis

##Data for the project:	   
     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##Full description:
     http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##How it works:
      The script is written in run_analysis.R file. It's a function
run_analysis() which return tidy data frame after analysis process.
      
      Procedures:
      
      - Test and Train data are merged into one data set
      - Filter to get only standard deviation and mean data
      - Using feature names as column names for data
      - Merge activity number to current data set
      - Merge subject to current data set
      - Creating tidy data 
      - Mapping activy number to activity name (This is performed last because
it's easier to user aggregate with numeric data)
      
      


##Here is the brief code elaination to sastify assignment requirements: 

1. Merges the training and the test sets to create one data set:
   Training and test data are loaded into x_test, x_train variables, then merged
to x_merged using rbind() function (Line 6 to 9).
   
2. Extracts only the measurements on the mean and standard deviation for each 
measurement
   First, it is necessary to have infrormation about features, which is stored
in "UCI HAR Dataset/features.txt" (Line 13). Applying regular expressing with
grep() function, to features, it's able to extract only column with mean and
standard deviation calculation (Line 14)

3. Uses descriptive activity names to name the activities in the data set
   First, the activity number is linked to data set by data in y_test.txt and
y_train.txt with rbind() function (Line 24 to 30)

   The information about activities name is stored in
"UCI HAR Dataset/activity_labels.txt". After getting the data, we map the
activity number to activity name. (Line 57, 58)

4. Appropriately labels the data with descriptive variable names:
   The features name will be used to name the activities by assigning to 
colnames() of data set (Line 18)   

5. Extract tidy data with average of each variable for each activity and each
subject:
   aggregate() function is used to get average calculation for each activity and
subject. (Line 47)