SCRIPT Description and VARIABLES:

A) The cript name is named: runAnalysis.r 

B) SCRIPT DESCRIPTION:
  0) Setup the enviroment:
  The script works in the Working directory you choose, directly without need to adapt the cript.
  Clean the workspace
  Download and unzip the datasets
  
  1) Merges the training and the test sets to create one data set:
  From files we create the DF for each file, X, Y and Subject from Train and Test
  We bind the Train and Test data. We get a new set of files.
  
  2) Extracts only the measurements on the mean and standard deviation for each measurement:
  We read and create the DF from the file that have the relationship beweeen the feature # and feature name.
  We use GREEP and Regular Expression to keep only the MEAN and STD DEV columns.
  We generate a Vector thatr identify those columns. Then we generate the subset.
  We add the Feature name to the data subset
  
  3) Uses descriptive activity names to name the activities in the data set:
  We read and create a DF with the Activity names
  
  4) Appropriately label the data set with descriptive variable names:
  We column bind all three files, already with the respective column names: subject, y_data, x_data
  We use GSUB and Regular Expression to clean the Colum names
  
  "final_data" is the Data we expect to have on this step.
  
  
  
  
  
  
  


C) VARIABLES:
x_train       -> Data from X_train.txt        Each row represents data taken from the Samsung for each subject and for each activity
y_train       -> Data from y_train.txt        Identify the activity
subject_train -> Data from subject_train.txt  Identify the subject
x_test        -> Data from X_test.txt         Each row represents data taken from the Samsung for each subject and for each activity
y_test        -> Data from y_test.txt         Identify the activity
subject_test  -> Data from subject_test.txt   Identify the subject

x_data        -> test and train data binded for data taken from the Samsung for each subject and for each activity
y_data        -> test and train data binded for activity identification
subject       -> test and train data binded for subject identification

features      -> Give real names to the activity identification
wanted_features -> Vector that identify the columns we want ( mean and sdt dev)
activity_labels -> Labels for the activities
final_data    -> Final DF
