---
title: "Code Book"
---

This code book explains the data, steps performed to clean up the data.

### Sources

- Data: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
- Data description <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

### About data 

Dataset includes the following files:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

For more details, see **README.txt**

### Steps performed on data 

- download zip file from <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
- unzip the file in the current directory and then folder named UCI HAR Dataset is created.
- if you want to know path of the current directory, type `getwd()` in R
- load activity and feature name data in `./UCI HAR Dataset`
- load train and test data. each data is in train and test folder respectively in `./UCI HAR Dataset`
- since each train and test data is separated into subject, activity(Y), and datasets(X), each variable is combined resulting in completed train and test data
- merge train and test data resulting in completed datasets of 10299 observations and 563 variables - Assign names of columns by features names from above steps and adding subject, activityID (**No.1 mission completed**)
- extract the dataset that is only related to the mean and standard deviation
- from the above step, variables of datasets are decreased in 81 from 563 (**No.2 mission completed**)
- match activity ID(Numbers from 1 to 6) with description by using activity label
- Since activity description is added to datasets, variables are 82 from 81 (**No.3 mission completed**)
- Some names of variables are not descriptive and overlapped, label names of columns appropriately (**No.4 mission completed**)
- Create a tidy dataset with the average of each variable for each activity and each subject
`melt` and `dcast` functions are used in `reshaped2` packages (**No.5 mission completed**)
