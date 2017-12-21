# 1.Merges the train and test datasets to create one data set.
# dataset are already downloaded and unzipped in the current directory

# library
library(reshape2)

# load activity label and feature data
act.label <- read.table("UCI HAR Dataset/activity_labels.txt")
feature <- read.table("UCI HAR Dataset/features.txt")
feature <- as.character(feature[,2])

# load train and test data
train <- read.table("UCI HAR Dataset/train/X_train.txt")
train.act <- read.table("UCI HAR Dataset/train/Y_train.txt")
train.sub <- read.table("UCI HAR Dataset/train/subject_train.txt")

# load test data
test <- read.table("UCI HAR Dataset/test/X_test.txt")
test.act <- read.table("UCI HAR Dataset/test/Y_test.txt")
test.sub <- read.table("UCI HAR Dataset/test/subject_test.txt")

# merges train and the test datasets and assign column names
train <- cbind(train.sub, train.act,train)
test <- cbind(test.sub,test.act, test)
data <- rbind(train, test)
colnames(data) <- c("subject", "activityID", feature)

# 2.Extracts the measurements on the mean and standard deviation for each measurement.
data_mean_std <-data[,grep("subject|activity|mean|std|subject|activity",colnames(data))]

# 3.Uses descriptive activity names to name the activities in the dataset
colnames(act.label)<-c("activityID","activity")
data_desc <-merge(act.label,data_mean_std,by="activityID",all=TRUE)

# 4.Appropriately labels the dataset with descriptive variable names
names(data_desc) <- gsub("^t", "Time", names(data_desc))
names(data_desc) <- gsub("^f", "Frequency", names(data_desc))
names(data_desc) <- gsub("BodyBody", "Body", names(data_desc))
names(data_desc) <- gsub("Freq", "Frequency", names(data_desc))

# 5. creates tidy dataset with the average of each variable for each activity and each subject
data.melt <- melt(data_desc, id = c("subject", "activity"))
data.mean <- dcast(data.melt, subject + activity ~ variable, mean)

write.table(data.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
