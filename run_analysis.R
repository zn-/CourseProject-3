# 1. Merging the train and the test datasets.

  # Reading the train datasets into separate variables
train_Data <- read.table("./data/train/X_train.txt")
train_Label <- read.table("./data/train/y_train.txt")
table(train_Label)
train_Subject <- read.table("./data/train/subject_train.txt")
  # Reading the test datasets into separate variables
test_Data <- read.table("./data/test/X_test.txt")
test_Label <- read.table("./data/test/y_test.txt") 
table(test_Label) 
test_Subject <- read.table("./data/test/subject_test.txt")
if ( length(test_Label) != length(test_Subject) || length(test_Label) != dim(test_Data)[1] ) {
  stop('dimensions of test data set does not match')
}
if ( length(train_Label) != length(train_Subject) || length(train_Label) != dim(train_Data)[1] ) {
  stop('dimensions of training data set does not match')
}
  # Merging the train and test datasets using rbind.
joinedData <- rbind(train_Data, test_Data)
joinedLabel <- rbind(train_Label, test_Label)
joinedSubject <- rbind(train_Subject, test_Subject)


# 2. Extracting only the measurements on the mean and standard deviation for each measurement. 

features <- read.table("./data/features.txt")
mean_StdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
  # Extracting only mean and standard deviation for each measurement
joinedData <- joinedData[, mean_StdIndices] 
  # Modifying the variables names
names(joinedData) <- gsub("\\(\\)", "", features[mean_StdIndices, 2]) # removing "()"
names(joinedData) <- gsub("mean", "Mean", names(joinedData)) # capitalizing M
names(joinedData) <- gsub("std", "Std", names(joinedData)) # capitalizing S
names(joinedData) <- gsub("-", "", names(joinedData)) # removing "-" in column names 

# 3. Using  descriptive activity names to name the activities in the data set
  # Reading the activity labels
activity <- read.table("./data/activity_labels.txt")
  # Making all the characters in activity to lower case
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
  # for joined words walkingupstairs and walkingdownstairs, making the first letter of second work upper case 
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activity_Label <- activity[joinedLabel[, 1], 2]
joinedLabel[, 1] <- activity_Label
names(joinedLabel) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(joinedSubject) <- "subject"
cleanedData <- cbind(joinedSubject, joinedLabel, joinedData)

write.table(cleanedData, "merged_data.txt") # writing out the 1st dataset- merged dataset with activity labels

# 5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject. 

subjectLen <- length(table(joinedSubject)) 
activityLen <- dim(activity)[1] 
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
  for(j in 1:activityLen) {
    result[row, 1] <- sort(unique(joinedSubject)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    b1 <- i == cleanedData$subject
    b2 <- activity[j, 2] == cleanedData$activity
    result[row, 3:columnLen] <- colMeans(cleanedData[b1&b2, 3:columnLen])
    row <- row + 1
  }
}

write.table(result, "final_Means_data.txt") # writing out the 2nd dataset
