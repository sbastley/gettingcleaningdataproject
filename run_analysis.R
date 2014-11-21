##R script to load, combine, extract, label, and tidy data

##Load reshape2 package. This is the only package used beyond base
library(reshape2)

##Read data from UCI HAR Dataset
features <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
xtest <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
subjecttest <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
xtrain <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
subjecttrain <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")

##Combine data sets (xtest and xtrain)
fdata <- rbind(xtest,xtrain)

##Give column names according to features data
colnames(fdata) <- features$V2

##Extract only mean and std columns to new data frame(Included meanfreq columns)
meanstdcolumns <- c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,228,229,240,241,253,254,266:271,294:296,345:350,373:375,424:429,452:454,503,504,513,516,517,526,529,530,539,542,543,552)
fdata <- fdata[,meanstdcolumns]

##subjecttest and subjecttrain are participant numbers
##Combine to make one larger data frame
subject <- rbind(subjecttest,subjecttrain)
colnames(subject) <- "subject"

##Then combine with fdata
fdata <- cbind(subject,fdata)

##ytest and ytrain are activity numbers
##Combine into one larger data frame
activity <- rbind(ytest,ytrain)
colnames(activity) <- "activity"

##Then combine with data frame fdata
fdata <- cbind(activity,fdata)

##Replace activity numbers with descriptive activity names from activities
fdata$activity[fdata$activity == 1] <- "Walking"
fdata$activity[fdata$activity == 2] <- "Walking Upstairs"
fdata$activity[fdata$activity == 3] <- "Walking Downstairs"
fdata$activity[fdata$activity == 4] <- "Sitting"
fdata$activity[fdata$activity == 5] <- "Standing"
fdata$activity[fdata$activity == 6] <- "Laying"

##Make variable names clearer by making all lower case, removing parentheses and dashes, and expanding some abbreviations. t(time) and f(frequency) left as is

names(fdata) <- tolower(names(fdata))
names(fdata) <- gsub("[:()-_:]","", names(fdata))
names(fdata) <- gsub("acc","accelerometer", names(fdata))
names(fdata) <- gsub("gyro","gyroscope", names(fdata))
names(fdata) <- gsub("bodybody","body", names(fdata))

##Remove data no longer needed
rm(activity,features,subject,subjecttest,subjecttrain,xtest,xtrain,ytest,ytrain,meanstdcolumns)

##Make new tidy data set with average(mean) values by subject and activity
bylist <- list(activity=fdata$activity,subject=fdata$subject)
wide <- aggregate(fdata[,3:81], by=bylist, mean)
rm(bylist)

##Further tidy the data to make it easier to read in a long, narrow format using melt
narrow <- melt(wide, id.vars=c("activity","subject"))