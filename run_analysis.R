
#####################################################################################
##  What this script does:
##
##     - Download and unzip data in the working directory;
##     - Merges the training and test data sets;
##     - Adds their respective label and activity;
##     - Select measurements on the mean and standard deviation for each measurement; 
##     - Appropriately labels the data set with descriptive variable names;
##     - Creates a independent tidy data set with the average of each variable for 
##       each activity and each subject.
##
#####################################################################################

##
## Downloading and extract the data
##

fileName <- 'UCI HAR Dataset.zip'

# Checking if the file already exists 
if (!file.exists(fileName)){
      fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
      download.file(fileUrl, fileName)
}

if (file.exists(fileName)) unzip(fileName)

##
## Assigning all data frames needed
##
activity_labels <- read.table('UCI HAR Dataset/activity_labels.txt', col.names = c('id','activity'))
features <- read.table('UCI HAR Dataset/features.txt', col.names = c('id','features'))
test_set <- read.table('UCI HAR Dataset/test/X_test.txt', col.names = features$features)
test_labels <- read.table('UCI HAR Dataset/test/y_test.txt', col.names = 'labels')
test_subject <- read.table('UCI HAR Dataset/test/subject_test.txt', col.names = 'subject')
train_set <- read.table('UCI HAR Dataset/train/X_train.txt', col.names = features$features)
train_labels <- read.table('UCI HAR Dataset/train/y_train.txt', col.names = 'labels')
train_subject <- read.table('UCI HAR Dataset/train/subject_train.txt', col.names = 'subject')

##
## Merges the training and the test sets to create one data set.
##
merged_set <- rbind(test_set, train_set)

# Merges the label and subject
merged_labels_set <- rbind(test_labels, train_labels)
merged_subject <- rbind(test_subject, train_subject)


merged_data <- cbind(merged_subject, merged_labels_set, merged_set)

##
## Extracts only the measurements on the mean and standard deviation for each 
## measurement. 
##
library(dplyr)
all_data <- select(merged_data, subject, labels, contains('mean'), contains('std'))

##
## Uses descriptive activity names to name the activities in the data set
##
all_data$labels <- activity_labels[all_data$labels,2]

##
## Appropriately labels the data set with descriptive variable names.
##

# creating a vector that contains the labels to be replaced
subs_label <- c('labels', 'Acc','BodyBody','Mag','tBody','Gyro', 'freq','fBody','-mean',
                '-std()', 'tGravity' , '\\.')
final_label <- c('activity', 'accelerometer', 'body', 'magnitude','timebody', 'gyroscope', 
                 'frequency', 'frequencybody', 'mean', 'std', 'timegravity', '')

# Using the gsub function to replace the labels
for (i in 1:length(final_label)){
      names(all_data) <- gsub(subs_label[i],final_label[i], names(all_data), ignore.case = T)
}

##
## creates a second, independent tidy data set with the average of each variable for 
## each activity and each subject.
##
final_data <- group_by(all_data, activity, subject) %>% summarise_all(funs(mean))
write.table(final_data, 'Final_Dataset.txt', row.names = F)
