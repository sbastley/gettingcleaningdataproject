gettingcleaningdataproject
==========================

Getting and Cleaning Data Course Project

The run_analysis.R script loads, combines, label, extracts, and creates a large data set, an averaged tidy data set in wide format, and a more readable melted data set in a long narrow format from the UCI HAR Dataset. This data is from an experiment of 30 participants performing six activities and includes accelerometer and gyroscope measurements from a worn Samsung Galaxy S II phone.

Merges the training and the test sets to create one data set.

Extracts only the measurements on the mean and standard deviation for each measurement. Mean frequency variables are included.

Uses descriptive activity names to name the activities in the data set.

Expands some abbreviations for variables and removes special characters and repetitions. 

The previous data used is then removed and an organized, wide data set is left.

From the previous data set, another tidy data set is created with the average of each variable for each activity and each subject. This is done using the aggregate function by activity and then by subject.

Another more readable data set is made using the melt function in the reshape2 package. This reshapes the data into a long, narrow format.