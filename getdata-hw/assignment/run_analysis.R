## Getting and Cleaning Data - Peer Assessment
## Data should be downloaded from:
##   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## and unzipped to the working directory 

library(data.table)

data.dir = file.path(getwd(), "UCI HAR Dataset")
if (!file.exists(data.dir)) {
  stop("run_analysis.R: The Samsung Dataset dir is not available in 'UCI HAR Dataset'")
}

## 1. Reading and merging the data
trainingX = read.table(paste0(data.dir, "/train/X_train.txt"))
trainingY = read.table(paste0(data.dir, "/train/Y_train.txt"))
trainingSubject = read.table(paste0(data.dir, "/train/subject_train.txt"))

testX = read.table(paste0(data.dir, "/test/X_test.txt"))
testY = read.table(paste0(data.dir, "/test/Y_test.txt"))
testSubject = read.table(paste0(data.dir, "/test/subject_test.txt"))

training.data = as.data.table(cbind(trainingX, trainingY, trainingSubject))
test.data = as.data.table(cbind(testX, testY, testSubject))
rm(trainingX, trainingY, trainingSubject, testX, testY, testSubject)

all.data = rbind(training.data, test.data)
rm(test.data, training.data)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement
features.df =  read.table(paste0(data.dir,"/features.txt"))
features.X = as.character(features.df$V2)
features.all = c(features.X, "ActivityId", "SubjectId")
setnames(all.data, features.all)

# Figuring out what are the mean and standard deviation features
is.mean = grepl("-mean(", features.all, fixed=T)
is.std = grepl("-std(", features.all, fixed=T)
selected.features = c(features.X[is.mean | is.std], "ActivityId", "SubjectId")

selected.data = subset(all.data, T, selected.features)

## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
activities.df = as.data.table(read.table(paste0(data.dir,"/activity_labels.txt")))
setnames(activities.df, c("ActivityId", "ActivityName"))
activity.data = merge(selected.data, activities.df, by="ActivityId") 
activity.data[, ActivityId := NULL] # Removing the old ActivityId

write.csv(activity.data, file="tidy_data.txt", row.names=F)

## 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.
activity.data[, ActivityName := factor(ActivityName)]
activity.data[, SubjectId := factor(SubjectId)]

# for (column in colnames(activity.data)) {
#   if (column %in% c("SubjectId", "ActivityName")) next
#   summary.col = tapply(activity.data[[column]], list(activity.data$SubjectId, activity.data$ActivityName), mean)
# }
# 
# summary.data = tapply(activity.data, list(activity.data$SubjectId, activity.data$ActivityName), mean)

