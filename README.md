gettingcleaningdataproject
==========================

Getting and Cleaning Data Course Project

The run_analysis.R script loads, combines, labels, extracts, and creates a large data set. It also creates an averaged tidy data set in wide format and a more readable melted data set in a long narrow format from the UCI HAR Dataset. This data is from an experiment of 30 participants performing six activities and includes accelerometer and gyroscope measurements from a worn Samsung Galaxy S II phone.

Merges the training and the test sets to create one data set.

Labels variables in the columns.

Extracts only the variables of the mean and standard deviation for each measurement. Mean frequency variables are included.

Gives descriptive activity names to the activities in the data set.

Expands some abbreviations for variables and removes special characters and repetitions. 

The previous data loaded and no longer used is then removed and an organized, wide data set is left.

From the previous data set, another data set is created with the average of each variable for each activity and each subject. This is done using the aggregate function by activity and then by subject.

Then another more readable data set is made using the melt function in the reshape2 package. This reshapes the data into a long, narrow format.