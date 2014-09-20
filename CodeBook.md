CourseProject-3
===============
#  CodeBook 

####Study Design-

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.
 Using its embedded accelerometer and gyroscope, researchers captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. 
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

### Original Data(Raw data)-

The original data comes from the smartphone accelerometer and gyroscope 3-axial raw signals, which have been processed using various signal processing techniques to measure vector consisting of 561 features. For detailed description of the original dataset, please see features_info.txt in the unzipped dataset file.

####Associated files-
The dataset includes the following files:

*'README.txt'

*'features_info.txt': Shows information about the variables used on the feature vector.

*'features.txt': List of all features.

*'activity_labels.txt': Links the class labels with their activity name.

*'train/X_train.txt': Training set.

*'train/y_train.txt': Training labels.

*'test/X_test.txt': Test set.

*'test/y_test.txt': Test labels.

### The following files are available for the train and test data. Their descriptions are-

*'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

*'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

*'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.

*'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

### Transformation details

There are 5 parts:

*1.Merging the training and the test sets to create one data set.

*2.Extracting only the measurements on the mean and standard deviation for each measurement.

*3.Using descriptive activity names to name the activities in the data set.

*4.Appropriately labelling the data set with descriptive activity names.

*5.Creating a second, independent tidy data set with the average of each variable for each activity and each subject.

#####After passing this raw dataset into run_analysis.R(to carry out the above listed transformation), we get two tidy dataset- "merged_data" and "final_Means_data"

###Tidy Datasets-

####merged_data-
This dataset is obtained after performing the transformation steps 1 to 4 on the raw datasets.

1. Merging the training and the test sets- First of all, the different datasets(test and train datasets) were read into R and stored into separate objects.Then the test and train datasets were merged.

2.Extracting only the measurements on the mean and standard deviation- "features.txt" file was read into R, then the indices where measurements of mean or std (standard deviation) appear were noted, and with the help of these indices only the required measurements (columuns) were subsetted.
  Also the variable names were modified, to remove "()" , "-" and also to capitalize the inital letter of Mean, Std.
  
3.Using descriptive activity names to name the activities-"activity_labels.txt" file was loaded into R, and all activity names brought to lower case and for joined names like "walkinguptairs" the first letter of second word (i.e. upstairs-U) is capitalized for better readability.

4.Appropriately labelling the data set with descriptive activity names- the subject, label(tranformed) and data (test and train joined in step1) are now joined together and the resultant dataset printed out as merged_data.txt


####final_Means_data-
After performing the step 1 to 4 and getting the merged_data, the step 5 is specifically performed to get the final_Means_data as

5.Creating a second, independent tidy data set with the average of each variable for each activity and each subject- Using two nested for loops, one looping over subjects and over activity, the resultant tidy dataset was obtained.
After this transformation, the resultant tidy dataset was written out in final_Means_data.txt file.

PS- I know there are better ways of doing this in R, but because of my C programming background, "for" loops sort of comes naturally to me.


Original description of the dataset:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones