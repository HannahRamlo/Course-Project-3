
## read data sets into R

xtrain <- read.table("X_train.txt")
ytrain <- read.table("Y_train.txt")
subjecttrain <- read.table("subject_train.txt")

xtest <- read.table("X_test.txt")
ytest <- read.table("Y_test.txt")
subjecttest <- read.table("subject_test.txt")

features <- read.table("features.txt")

## merge train x, y, and subject data sets

mergedtrain <- cbind(subjecttrain, ytrain, xtrain)

##merge test x, y, and subject data sets

mergedtest <- cbind(subjecttest, ytest, xtest)

## remove first numbered column of features list

features <- as.character(features[,2])

##rename first two columns of merged train & test data

names(mergedtrain)[1] <- "subject"
nnames(mergedtrain)[2] <- "activity"

names(mergedtest)[1] <- "subject"
nnames(mergedtest)[2] <- "activity"

## Appropriately labels the data sets?Add with descriptive variable names.

names(mergedtrain)[3:563] <- features
names(mergedtest)[3:563] <- features

## Merge the training and the test sets to create one data set

merged <- rbind(mergedtest, mergedtrain)

## separate subject and activity data

df1 <- merged[, 1:2]

## create a data frame with means and standard deviations

meanstd <- merged[grepl("mean\\(\\)|std\\(\\)",names(merged))]

## merge subject & activity data with means and standard deviations

meanstd <- cbind(df1, meanstd)

## Uses descriptive activity names to name the activities in the data set

meanstd$activity <- gsub("1", "walking", meanstd$activity)
meanstd$activity <- gsub("2", "walkingupstairs", meanstd$activity)
meanstd$activity <- gsub("3", "walkingdownstairs", meanstd$activity)
meanstd$activity <- gsub("4", "sitting", meanstd$activity)
meanstd$activity <- gsub("5", "standing", meanstd$activity)
meanstd$activity <- gsub("6", "laying", meanstd$activity)


## Fset subject as factor variable
meanstd$subject <- as.factor(meanstd$subject)
meanstd <- data.table(meanstd)

## creates a second, independent tidy data set with the average of each variable for each activity and each subject.

newdata <- aggregate(. ~subject + activity, meanstd, mean)
newdata <- newdata[order(newdata$subject, newdata$activity),]
write.table(newdata, file = "newdata.txt", row.names = FALSE)


