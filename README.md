README (05/21/2016)

Explain scripts used for "Getting and Cleaning Data Course" project

Following files related to computation of tidy data are included:
- "Readme.txt"
- "CodeBook.md" : describe variables, data, and transformations performed to clean up the data
- "run_analysis.R": compute tidy dataset with mean values of aceloremeter anf gyroscope data

The following files are needed as inputs prior to running "run_analysis.R". They are located in the "UCI HAR Dataset" directory, also provided in the Github repository.

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

Transformation done to compute the tidy dataset:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.