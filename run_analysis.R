## CREATE TIDY DATASET (ACCELEROMETERS DATA FROM SMARTPHONE)

## Libraries
if (!require("data.table")) {
        install.packages("data.table")
}

if (!require("reshape2")) {
        install.packages("reshape2")
}

if (!require("dplyr")) {
        install.packages("dplyr")
}

require("data.table")
require("reshape2")
require("dplyr")


## Test dataset 
## 2947 rows (observations)
## 563 Columns:
##      - n=1: subject ID ("./test/subject_test.txt")
##      - n=1: activity label ("./test/y_test.txt")
##      - n=561: accelerometer and gyroscope data ("./test/X_test.txt")

## Load subject ID & apply proper naming of column
subject_data <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
names(subject_data)<-"subjectid"

## Load activity label data & apply proper naming of column
activity_data <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
names(activity_data) <- "activity"

## Load acc & gyroscope data & apply proper naming of columns
acc_data <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
names_features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE)
names(acc_data) <- names_features$V2

## Create testing database
testing_data <- cbind(subject_data,activity_data,acc_data)
testing_data <- mutate(testing_data,typedataset="test") ## add column to differentiate between training and testing datasets

## Clean intermediate variables
rm(subject_data); rm(activity_data); rm(acc_data) 

## Training dataset 
## 7352 rows (observations)
## 563 Columns:
##      - n=1: subject ID ("./train/subject_train.txt")
##      - n=1: activity label ("./train/y_train.txt")
##      - n=561: accelerometer and gyroscope data ("./train/X_train.txt")

## Load subject ID & apply proper naming of column
subject_data <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)
names(subject_data)<-"subjectid"

## Load activity label data & apply proper naming of column
activity_data <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
names(activity_data) <- "activity"

## Load acc & gyroscope data & apply proper naming of columns
acc_data <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
names(acc_data) <- names_features$V2

## Create testing database
training_data <- cbind(subject_data,activity_data,acc_data)
training_data <- mutate(training_data,typedataset="train") ## add column to differentiate between training and testing datasets

## STEP 1: Merged data
merged_data <- rbind(training_data,testing_data)

## STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement.
extract_features <- grepl("mean|std", names(merged_data))
extract_data <- merged_data[,extract_features]

## STEP 3: Uses descriptive activity names to name the activities in the data set
activity_label <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE)
for (i in 1:6) 
        { 
                merged_data$activity <- replace(merged_data$activity,merged_data$activity==i,as.character(activity_label$V2[i])) 
        }
        
## STEP 4: Appropriately labels the data set with descriptive variable names
## Already done (see above).


## STEP 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
## Leverage "reshape" package
id_labels   = c("subjectid", "activity", "typedataset")
data_labels = setdiff(colnames(merged_data), id_labels)
melt_data = melt(merged_data, id = id_labels, measure.vars = data_labels)

tidy_data   = dcast(melt_data, subjectid + activity ~ variable, mean)
write.table(tidy_data, file = "./tidy_data.txt")

