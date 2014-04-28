Getting and Cleaning Data - Peer Assessment
===========================================

Usage
-----
Use the `run_analysis.R` script to create the tidy data output files. The Samsung dataset must be copied to the same working directory as the script without any change of the directory structure.

Requirements
------------
The R environment must have the `data.table` package installed. Many of the requirements are made simpler by using the features available on this package, specially the averagiing of each variable.

Transformations
---------------
This script performs transformations on the Samsung dataset consistent with the requests on the work requested on the course project. In summary, these are the steps it takes:

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names. (`tidy_data.txt`)
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. (`summary_data.txt`) 

Output
------
The scripts creates two files upon being run:
* `tidy_data.txt` - CSV file which has the tidy dataset as required by the project
* `summary_data.txt` - CSV file which has the second, independent tidy data set with the average of each variable for each activity and each subject
