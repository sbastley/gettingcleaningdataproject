gettingcleaningdataproject
==========================

Getting and Cleaning Data Course Project

The run_analysis.R script loads, combines, extracts, labels, and makes an averaged, tidy data set as well as a more readable melted data set in a long, narrow format from the UCI HAR Dataset. Inertial data was excluded.

Merges the training and the test sets to create one data set.

Extracts only the measurements on the mean and standard deviation for each measurement. Mean frequenciy variables are included.

Uses descriptive activity names to name the activities in the data set.

Expands some abbreviations for variables and removes special characters and repetitions. 

The previous data used is then removed and an organized data set is left.

From the previous data set, another tidy data set is created with the average of each variable for each activity and each subject. This was done using the aggregate function by activity and then by subject.

Another more readable data set is made using the melt function in the reshape2 package. This reshapes the data into a long, narrow format.