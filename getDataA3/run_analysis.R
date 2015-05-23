
# load library
#install.packages("dplyr")
library(dplyr)
#install.packages("reshape")
library(reshape)

# save and set current wd
saveWd <- getwd()
setwd(dirname(parent.frame(2)$ofile))
message("Working directory is set to ", getwd())
    
readData <- function(){
    rowcount <- -1
    # read the data used 
    message("read activities and features ...")
    activityNames <<- read.table("./UCI HAR Dataset/activity_labels.txt")
    features <<- read.table("./UCI HAR Dataset/features.txt")

    message("read test data ...")
    testX <<- read.table("./UCI HAR Dataset/test/X_test.txt", nrows = rowcount)
    testY <<- read.table("./UCI HAR Dataset/test/y_test.txt", nrows = rowcount)
    testS <<- read.table("./UCI HAR Dataset/test/subject_test.txt", nrows = rowcount)

    message("read train data ...")
    trainX <<- read.table("./UCI HAR Dataset/train/X_train.txt", nrows = rowcount)
    trainY <<- read.table("./UCI HAR Dataset/train/y_train.txt", nrows = rowcount)
    trainS <<- read.table("./UCI HAR Dataset/train/subject_train.txt", nrows = rowcount)

    message("data read.")
}

mergeData <- function(){
    # prepare test data
    x  <- cbind(testX,testY,testS)
    rownames(x)  <- paste("test",rownames(x),sep = "")    
    # prepare train data
    y  <- cbind(trainX,trainY,trainS)
    rownames(y)  <- paste("train",rownames(y),sep = "")
    # merge rows
    z <- rbind(x,y)    
    # name columns
    names(z) <- c(as.character(features$V2), "Activity", "Subject")
    z    
 }

# 1. Merges the training and the test sets to create one data set.
readData()
X <- mergeData()

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
X <- X[,grep("std|mean|Activity|Subject", names(X))] 

# 3. Uses descriptive activity names to name the activities in the data set
activityFactor  <- as.factor(activityNames$V2)
X$Activity <- activityFactor[X$Activity]
    
# 4. Appropriately labels the data set with descriptive variable names.
# Already done in step 1
    
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
moltenX <- melt(X, id=c("Activity", "Subject"))
castedX  <- cast(moltenX, Activity + variable ~ Subject, mean)

# write the cast to file
write.table(castedX, "castedX.txt",row.names=FALSE)

# restore wd
setwd(saveWd)
message("Working directory is restored to ", getwd()) 
