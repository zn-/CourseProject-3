CourseProject-3
===============
(This Project is done as part of Getting and Cleaning data course of Coursera)

Describing the flow of procedures to follow in order use the function to get a tidy dataset.

-First, Get the data(by downloading and unzipping) from the link provided in project page and rename the folder as "data".

-Make sure the folder "data" and the run_analysis.R script are both in the current working directory.

-Then, use source("run_analysis.R") command to run function which performs the required 5 steps on the data.

-The R script carry out the following transformations-
*1.Merging the training and the test sets to create one data set.

*2.Extracting only the measurements on the mean and standard deviation for each measurement.

*3.Using descriptive activity names to name the activities in the data set.

*4.Appropriately labelling the data set with descriptive activity names.

*5.Creating a second, independent tidy data set with the average of each variable for each activity and each subject.


-After running run_analysis.R,  two output files are generated in the current working directory:

        *merged_data.txt : containing a data frame called cleanedData with 10299X68 dimension.
        
        *final_Means_data.txt : containing a data frame called result with 180X68 dimension.
        
-Finally, one can use data_variable <- read.table("final_Means_data.txt") command to read the file and perform the downstream analyses. 