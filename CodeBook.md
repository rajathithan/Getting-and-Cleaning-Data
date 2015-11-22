## Course Project Code Book
### Explanation

A script called "run_analysis.R" will tidy up the data set received from the UCI Machine learning repository (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
Below are the variables used in the script.

*Training data set tables are taken in the below variables
trainX <- read.table("./data/train/X_train.txt")
trainY <- read.table("./data/train/y_train.txt")
trainS <- read.table("./data/train/subject_train.txt")

*Test data set tables are taken in the below variables
testX <- read.table("./data/test/X_test.txt")
testY <- read.table("./data/test/y_test.txt") 
testS <- read.table("./data/test/subject_test.txt")

*Merged data sets are available in the below variables
xData <- rbind(trainX,testX)
yData <- rbind(trainY,testY)
sData <- rbind(trainS,testS)

*Features information is taken in the below variable
features <- read.table("./data/features.txt")

*Filtered mean and stdvalues are taken in the fmeanStd variable

*xData dataset is filtered using this fmeanstd and the columns names are tidied up

*Activity information is taken in the below table
activity <- read.table("./data/activity_labels.txt")

*yData dataset values are mapped with the values from the activity table

*Column Labeling is done for all the data sets

*Now all the data set are combined via columns to arrive at FinalData-1

*Now a seperate data table FinalData-2 with the estimated rows and columns (We need only 180 rows (i.e average of each activity and each subject (6 * 30)) & No of columsn from Final Data - 1)

* Get the average of activity and subjects using colMeans through for loop iteration, output the value to FinalData2.txt




