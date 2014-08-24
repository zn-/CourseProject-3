CourseProject-3
===============
(This Project is done as part of Getting and Cleaning data course of Coursera)

Describing the flow of procedures to follow in order use the function to get a tidy dataset.

-First, Get the data(by downloading and unzipping) from the link provided in project page and rename the folder as "data".

-Make sure the folder "data" and the run_analysis.R script are both in the current working directory.

-Then, use source("run_analysis.R") command to run function which performs the required 5 steps on the data.

-After running run_analysis.R,  two output files are generated in the current working directory:

        *merged_data.txt : containing a data frame called cleanedData with 10299X68 dimension.
        
        *final_Means_data.txt : containing a data frame called result with 180X68 dimension.
        
-Finally, one can use data_variable <- read.table("final_Means_data.txt") command to read the file and perform the downstream analyses. 