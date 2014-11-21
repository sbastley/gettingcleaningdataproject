---
title: "Codebook.md"
---
Only reshape2 package was used beyond base.

This script uses data from a database containing accelerometer and gyroscope data from a Samsung Galaxy S II phone with 30 participants performing six activities each. It uses variables such as tBodyAcc-XYZ which stands for time body accelerometer in the x, y, and z axes. The script extracts variables that are the mean and std(standard deviation) of such variables. It also removes characters like parentheses and dashes and expands some abbreviations such as accelerometer for acc.

This process assumes the data is contained inside an unzipped folder "getdata-projectfiles-UCI HAR Dataset" in the working directory which contains another folder "UCI HAR Dataset" which contains the files and folders containing the data.

Load each text file from test and train folders as well as features within UCI HAR Dataset folder. Inertial data was excluded. Activity_labels.txt lists descriptive names corresponding to activity numbers in ytest/ytrain. The activity numbers are manually changed.

Use read.table function with defaults to give data named:

features - data frame of variable names
xtest - data frame of the test group, variables without names
ytest - data frame of activity numbers for test group
subjecttest - data frame of participant numbers for test group
xtrain - data frame of training group, variables without names
ytrain - data frame of the activity numbers for training group
subjecttrain - data frame of participant numbers for training group

Merge xtest and xtrain using rbind

Features contains column names for variables in second column using colnames

Extract mean and std columns into a new data frame(meanfreq columns included) by subsetting
Manually found indices for mean and std columns in features
meanstdcolumns <- c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,228,229,240,241,253,254,266:271,294:296,345:350,373:375,424:429,452:454,503,504,513,516,517,526,529,530,539,542,543,552)


Subjecttest and subjecttrain are participant numbers
Combine to make one larger data frame using rbind and give column a name using colnames

Then merge to extracted data frame using cbind

Ytest and ytrain are activities
Combine into one using rbind and name the column using colnames

Then merge activity data frame to main data frame using cbind

Replace activity numbers with descriptive activity names in activity_labels.txt using subsetting 
e.g.fdata$activity[fdata$activity == 1] <- "Walking"

Clean variable names to make lower case, remove parentheses and dashes, and expand some abbreviations. Left t and f alone. They stand for time and frequency. 
e.g. names(fdata) <- gsub("[:()-_:]","", names(fdata))

Remove previous data left over after making new main data set using rm

Make new tidy data set with average values by subject and activity using the aggregate function with a list of the activity and subject columns. This makes a tidy, wide format data set. The data set used in the aggregate function is subset for the mean function to work on. The list is removed after the tidy data set is made
e.g. bylist <- list(activity=fdata$activity,subject=fdata$subject)
wide <- aggregate(fdata[,3:81], by=bylist, mean)

Made another tidy data set by using melt to make a long, narrow data set which I believe to be more readable.
e.g. narrow <- melt(wide, id.vars=c("activity","subject"))

The data can be then written to a file using write.table
write.table(wide or narrow, file="./tidydata.txt", row.names=FALSE)

The file can be read back in using
data <- read.table("./tidydata.txt", header=TRUE, sep=" ")