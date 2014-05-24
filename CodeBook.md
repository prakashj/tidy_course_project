Tidy Data Course Project
===================

[Original Source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Data Transformation Steps
------------------------
1. For training and test data set, peform the following:
- read data files (features, y data, subject data, x data)
- Identify the measures that are of interest i.e. measure name containing mean(), std()
- subset the X data file recordset for those columns only
- combine x data file with activityID and SubjectID

2. Combine test and training Data set to create one data frame
3. Read Activity file to get description for ActivityNames
4. Combine ActivityName to data frame from step 2 above
5. clean up column names for the dataset i.e remove dots (.) and make variable as proper case Mean, Std
6. Melt the dataset with ActivityId, subject id and activity name as id variables
7. Recast the melted dataset with Activity Name, subject ID and mean function
8. Write the final output file to desired file name by user. For e.g. tidy.txt
