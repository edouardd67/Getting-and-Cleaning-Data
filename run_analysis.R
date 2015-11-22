##########################################################################################################

## Coursera Getting and Cleaning Data Course Project
## Edouard Darbellay
## 2015-11 -22

# runAnalysis.r 
# SCRIPT Description:
# 1.	Merges the training and the test sets to create one data set.
# 2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.	Uses descriptive activity names to name the activities in the data set
# 4.	Appropriately labels the data set with descriptive variable names. 
# 5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



######################################################
# 0.1 - Load Libraries
library(plyr)


######################################################
### 0.2 - Clean up workspace
rm(list=ls())


######################################################
### 0.3 - GET DATA

filename <- "getdata_dataset.zip"


######################################################
###0.4 -Download and unzip the dataset:

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    # download.file(fileURL, filename, method="curl")
  download.file(fileURL, filename) 
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}




############################################################################
# 1. Merges the training and the test sets to create one data set.            #
############################################################################

######################################################
### 1.1 -  MERGE DATA SETS ( TEST and TRAIN )

x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

### 1.2 -  MERGE DATA with ROW BIND ( rbind() ):

x_data    <-    rbind(x_train,x_test )
y_data    <-    rbind(y_train,y_test )
subject   <-    rbind(subject_train,subject_test )






####################################################################################################
#	2. Extracts only the measurements on the mean and standard deviation for each measurement           #
####################################################################################################



######################################################
### 2.1 -  GET ONLY THE DATA WANTED ( MEAN and DEVIATION):

features <- read.table("UCI HAR Dataset/features.txt")

features[, 2]  # Only second column

### 2.11 - Use GREE and Regular expression to extract features wanted

wanted_features <- grep("-(mean|std)\\(\\)", features[, 2])


### 2.12 - GET X_DATA sUBSET:

x_data <- x_data[ , wanted_features ]


### 2.13 - GET X_DATA FEATURE NAMES SUBSET:

features <- features[wanted_features, 2]



######################################################
### 2.2 -  ADD COLUMN NAMES ON X_DATA:

### 2.21 - GET X_DATA FEATURE NAMES SUBSET:

features <- features[wanted_features, 2]


### 2.22 - ADD COLUMN NAMES ON X_DATA:

names(x_data) <- features





####################################################################################################3.
#3. Uses descriptive activity names to name the activities in the data set                         #
####################################################################################################


######################################################
### 3.0 -  ADD COLUMN NAMES ON Y_DATA:

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

y_data[, 1]     <- activity_labels[y_data[, 1], 2]

## 3.1 - Add LAbel on Y DATA:
names(y_data) <- "activity"



####################################################################################################
#4. Appropriately label the data set with descriptive variable names                               #
####################################################################################################

### 4.1 - Add Column name on subject table:
names(subject) <- "subject"

### 4.2 - Merge all data by BINDING COLUMNS ( cbind):
# head( subject )
# head( y_data  )
# head( x_data  )

final_data <- cbind ( subject, y_data, x_data  )
# head (final_data)

### 4.3 - Clean Column names:
colnames(final_data)
names(final_data)

clean_names <- colnames(final_data)

for (i in 1:length(clean_names)) 
{
  clean_names[i] = gsub("\\()","",clean_names[i])
  clean_names[i] = gsub("-std$","StdDev ",clean_names[i])
  clean_names[i] = gsub("-mean","Mean ",clean_names[i])
  clean_names[i] = gsub("^(t)","time ",clean_names[i])
  clean_names[i] = gsub("^(f)","freq ",clean_names[i])
  clean_names[i] = gsub("([Gg]ravity)","Gravity ",clean_names[i])
  clean_names[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body ",clean_names[i])
  clean_names[i] = gsub("[Gg]yro","Gyro ",clean_names[i])
  clean_names[i] = gsub("AccMag","Acc Magnitude ",clean_names[i])
  clean_names[i] = gsub("([Bb]odyaccjerkmag)","Body Acc Jerk Magnitude ",clean_names[i])
  clean_names[i] = gsub("JerkMag","Jerk Magnitude ",clean_names[i])
  clean_names[i] = gsub("GyroMag","Gyro Magnitude ",clean_names[i])
}
clean_names


# 4.4 Reassigning the new descriptive column names to the finalData set
colnames(final_data) = clean_names



##################################################################################################
#5. Create a second, independent tidy data set with the average of each variable                 #
#   for each activity and each subject                                                              #
##################################################################################################

length(final_data)  # get the length of the dataset row

head(final_data)

Average_Tidy_data <- ddply(final_data, .(subject, activity), function(x) colMeans(x[, 3:68]))


### 5.1 - Generating the Tidy Data Set:
write.table(Average_Tidy_data, "Average_Tidy_data.txt", row.name=FALSE)

