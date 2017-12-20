Purpose:
The main purpose of this project is to extract data from the given URLs, merge data sets and finally clean the data.

Objective:
To create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

run_analysis.R
1. The zip file provided in the given URL is downloaded and unzipped
2. The different data sets are read and stored.
3. The train dataset and test dataset are merged using the rbind command.
4. Only the measurements on mean and standard deviation for each measurement is extracted.
5. The names provided in the activity labels file is used to label the columns of merged data.
6. The columns of the merged dataset is named with discriptive variable names. 
7. A tidy data set is created and the tidy data is written into a text file 'data_tidy.txt'.
