---
title: "Codebook.md"
---
Only reshape2 package was used beyond base.

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

Merge xtest and xtrain
fdata <- rbind(xtest,xtrain)

Features contains column names for variables in second column
colnames(fulldata) <- features$V2

Extract mean and std columns into a new data frame(meanfreq columns included)
Found indices for mean and std columns in features
meanstdcolumns <- c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,228,229,240,241,253,254,266:271,294:296,345:350,373:375,424:429,452:454,503,504,513,516,517,526,529,530,539,542,543,552)
fdata <- fdata[,meanstdcolumns]

subjecttest and subjecttrain are participant numbers
Combine to make one larger data frame and give column a name
subject <- rbind(subjecttest,subjecttrain)
colnames(subject) <- "subject"

Then merge to extracted data frame
fdata <- cbind(subject, fulldata)

ytest and ytrain are activities
Combine into one and name the column
activity <- rbind(ytest,ytrain)
colnames(activity) <- "activity"

Then merge to data frame with subject numbers, fdata
fdata <- cbind(activity, fulldata)

Replace activity numbers with descriptive activity names in activity_labels.txt
fdata$activity[fdata$activity == 1] <- "Walking"
fdata$activity[fdata$activity == 2] <- "Walking Upstairs"
fdata$activity[fdata$activity == 3] <- "Walking Downstairs"
fdata$activity[fdata$activity == 4] <- "Sitting"
fdata$activity[fdata$activity == 5] <- "Standing"
fdata$activity[fdata$activity == 6] <- "Laying"

Clean variable names to make lower case, remove parentheseses underscores and dashes, and expand some abbreviations. Left t and f alone. They stand for time and frequency.
names(fdata) <- tolower(names(fdata))
names(fdata) <- gsub("[:()-_:]","", names(fdata))
names(fdata) <- gsub("acc","accelerometer", names(fdata))
names(fdata) <- gsub("gyro","gyroscope", names(fdata))
names(fdata) <- gsub("bodybody","body", names(fdata))

Remove previous data left over after making new data set, fdata
rm(activity,features,subject,subjecttest,subjecttrain,xtest,xtrain,ytest,ytrain,meanstdcolumns)

Make new tidy data set with average values by subject and activity
bylist <- list(activity=fdata$activity,subject=fdata$subject)
tidy <- aggregate(fdata[,3:81], by=bylist, mean)
rm(bylist)

Further tidy data by using melt to make a long, narrow data set
tidy1 <- melt(tidy, id.vars=c("activity","subject"))

Then take a tidy data set and make a file using write.table
write.table(tidy or tidy1, file="./tidydata.txt", row.names=FALSE)

The file can be read back in using
data <- read.table("./tidydata.txt", header=TRUE, sep=" ")