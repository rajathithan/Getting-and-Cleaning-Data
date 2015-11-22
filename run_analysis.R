#==========================================================================================
#1. Merges the training and the test sets to create one data set.
#==========================================================================================

#Get training data sets
trainX <- read.table("./data/train/X_train.txt")
trainY <- read.table("./data/train/y_train.txt")
trainS <- read.table("./data/train/subject_train.txt")

#Get test data sets
testX <- read.table("./data/test/X_test.txt")
testY <- read.table("./data/test/y_test.txt") 
testS <- read.table("./data/test/subject_test.txt")

#Join training and test Data sets
xData <- rbind(trainX,testX)
yData <- rbind(trainY,testY)
sData <- rbind(trainS,testS)

View(xData)
View(yData)
View(sData)

#==========================================================================================
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#==========================================================================================

#Get Features table
features <- read.table("./data/features.txt")
View(features)

#use grep command to get only the mean and std parameters
fmeanStd <- grep("mean\\(\\)|std\\(\\)", features[, 2])
View(fmeanStd)

#Filtering only the mean and std columns from XData
xData <- xData[ ,fmeanStd]

#Giving Column names to the X Data Set, also removing "()" & "-" Characters and coverting
#all the names to lowercase as part of tidying the data set
names(xData) <- features[fmeanStd,2]
names(xData) <- gsub("\\(|\\)","",names(xData))
names(xData) <- gsub("-","",names(xData))
names(xData) <- tolower(names(xData))
View(xData)

#==========================================================================================
#3. Uses descriptive activity names to name the activities in the data set 
#==========================================================================================

#Get Activity Table
activity <- read.table("./data/activity_labels.txt")
View(activity)

#Tidying the data - Removing "-" Characters and Lowering the case
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
View(activity)

#Mapping the numbers to the activity type in Y data set
mappingnumbers <- activity[yData[, 1], 2]
yData[, 1] <- mappingnumbers
View(yData)

#==========================================================================================
#4. Appropriately labels the data set with descriptive variable names.
#==========================================================================================

#Giving a name for the single column in Y Data set
names(yData) <- "activity"
View(yData)

#Giving a name for the single column in S Data set
names(sData) <- "subject"
View(sData)

#Now combins data sets X, Y & S by columns
FinalData1 <- cbind(sData, yData, xData)
View(FinalData1)

#Output the table to a text file, with row.name=False
write.table(FinalData1, "data/FinalData1.txt", row.name = FALSE)

#==========================================================================================
#5. From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.
#==========================================================================================

# No. of Subjects
subjectNo = length(table(sData))

# No. of Activities
activityNo = length(activity[,1])

#No of Columns in the Final Data - 1
finalcolNo = dim(FinalData1)[2]

# Creating a dataframe for the Final Data - 2,
# We need only 180 rows (i.e average of each activity and each subject (6 * 30))
FinalData2 <- matrix(NA, nrow=subjectNo*activityNo, ncol=finalcolNo) 
FinalData2 <- as.data.frame(FinalData2)

#Use the function colnames to give the column names to FinalData2
colnames(FinalData2) <- colnames(FinalData1)
View(FinalData2)

#Initialize row as 1
row<-1

for(i in 1:subjectNo) {
        for(j in 1:activityNo) {
                #setting 1st & 2nd col for each row in FinalData2
                FinalData2[row, 1] <- sort(unique(sData)[, 1])[i] 
                FinalData2[row, 2] <- activity[j, 2]
                #Filtering subject and activity to calculate the mean in Final Data-1
                col1 <- i == FinalData1$subject
                col2 <- activity[j, 2] == FinalData1$activity
                FinalData2[row, 3:finalcolNo] <- colMeans(FinalData1[col1&col2, 3:finalcolNo])
                row <- row + 1
        }
}

View(FinalData2)

#Output the table to a text file, with row.name=False
write.table(FinalData2, "data/FinalData2.txt", row.name = FALSE)
