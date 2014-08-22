# 1. Merging the train and the test datasets.

train_Data <- read.table("./data/train/X_train.txt")
train_Label <- read.table("./data/train/y_train.txt")
table(train_Label)
train_Subject <- read.table("./data/train/subject_train.txt")
test_Data <- read.table("./data/test/X_test.txt")
test_Label <- read.table("./data/test/y_test.txt") 
table(test_Label) 
test_Subject <- read.table("./data/test/subject_test.txt")
joinData <- rbind(train_Data, test_Data)

joinLabel <- rbind(train_Label, test_Label)

joinSubject <- rbind(train_Subject, test_Subject)


# 2. Extracting only the measurements on the mean and standard 
# deviation for each measurement. 
features <- read.table("./data/features.txt")

meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])

joinData <- joinData[, meanStdIndices]

names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
names(joinData) <- gsub("mean", "Mean", names(joinData)) # capitalize M
names(joinData) <- gsub("std", "Std", names(joinData)) # capitalize S
names(joinData) <- gsub("-", "", names(joinData)) # remove "-" in column names 

# 3. Using  descriptive activity names to name the activities in 
# the data set
activity <- read.table("./data/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

# 4. Appropriately labels the data set with descriptive activity 
# names. 
names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData)

write.table(cleanedData, "merged_data.txt") # writing out the 1st dataset

# 5. Creating a second, independent tidy data set with the average of 
# each variable for each activity and each subject. 
subjectLen <- length(table(joinSubject)) 
activityLen <- dim(activity)[1] 
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
  for(j in 1:activityLen) {
    result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    bool1 <- i == cleanedData$subject
    bool2 <- activity[j, 2] == cleanedData$activity
    result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
    row <- row + 1
  }
}

write.table(result, "data_with_means.txt") # write out the 2nd dataset

