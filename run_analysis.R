##Downloading and unzipping files
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,'data.zip')
unzip("data.zip")

##Reading the data
features <- read.csv("UCI HAR Dataset/features.txt", header = FALSE, sep = ' ')
features <- as.character(features[,2])

data.train.x <- read.table("UCI HAR Dataset/train/X_train.txt")
data.train.activity <- read.csv("UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = ' ')
data.train.subject <- read.csv("UCI HAR Dataset/train/subject_train.txt",header = FALSE, sep = ' ')

data.train <-  data.frame(data.train.subject, data.train.activity, data.train.x)
names(data.train) <- c(c("subject", "activity"), features)

data.test.x <- read.table("UCI HAR Dataset/test/X_test.txt")
data.test.activity <- read.csv("UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = ' ')
data.test.subject <- read.csv("UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = ' ')

data.test <-  data.frame(data.test.subject, data.test.activity, data.test.x)
names(data.test) <- c(c("subject", "activity"), features)

#Task1: Merging the training and the test sets to create one data set.
data.merged <- rbind(data.train, data.test)

#Task2: Extracting only the measurements on the mean and standard deviation for each measurement.
mean_std <- grep('mean|std', features)
data.sub <- data.merged[,c(1,2,mean_std + 2)]

#Task3: Use the descriptive activity names to name the activities in the data set
activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
activity.labels <- as.character(activity.labels[,2])
data.sub$activity <- activity.labels[data.sub$activity]

#Task4: Appropriately label the data set with descriptive variable names.
colnames(data.sub) <- gsub("[(][)]", "", colnames(data.sub))
colnames(data.sub) <- gsub("^t", "TimeDomain_", colnames(data.sub))
colnames(data.sub) <- gsub("^f", "FrequencyDomain_", colnames(data.sub))
colnames(data.sub) <- gsub("Acc", "Accelerometer", colnames(data.sub))
colnames(data.sub) <- gsub("Gyro", "Gyroscope", colnames(data.sub))
colnames(data.sub) <- gsub("Mag", "Magnitude", colnames(data.sub))
colnames(data.sub) <- gsub("-mean-", "_Mean_",colnames(data.sub))
colnames(data.sub) <- gsub("-std-", "_StandardDeviation_",colnames(data.sub))
colnames(data.sub) <- gsub("-", "_", colnames(data.sub))

#Task5: Creating a Tidy data set
data.tidy <- aggregate(data.sub[,3:81], by = list(activity = data.sub$activity, subject = data.sub$subject),FUN = mean)
write.table(x = data.tidy, file = "data_tidy.txt", row.names = FALSE)