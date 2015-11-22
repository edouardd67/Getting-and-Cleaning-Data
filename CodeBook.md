SCRIPT Description and VARIABLES:

A) The cript name is named: runAnalysis.r 

B) SCRIPT DESCRIPTION:
  0) Setup the enviroment:
  The script works in the Working directory you choose, directly without need to adapt the cript.
  Clean the workspace
  Download and unzip the datasets
  
  1) Merges the training and the test sets to create one data set:
  
  
  


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
