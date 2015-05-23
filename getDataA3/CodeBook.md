# Getting and Cleaning Data
## Code Book
This code book describes my course porject submission
### Files and Data
The data is available from the given URL in zip fromat. Data has to be extracted and stored in the working directory.
Used fiels are:
- activity_labels.txt Lables for the activity codes.
- features.txt names of all features/variables.
- X_test.txt test data.
- y_test.txt activities of test data.
- subject_test.txt subjects of test data.
- X_train.txt train data.
- y_train.txt activities of train data.
- subject_train.txt subjects of test data.

### Source Code Description
The script is divided into:
#### Read the data from the working directory.
Content of each described file is read into a dataframe.
#### Merges the training and the test sets to create one data set.
- X, y and subject fiels were merged with cbind
- Rownames are renamed
- test and train data are merged with rbind
- features were named

#### Extracts only the measurements on the mean and standard deviation for each measurement. 
- based on columnames the reuired features are selected

#### Uses descriptive activity names to name the activities in the data set
- rename the activities with the lables

#### Appropriately labels the data set with descriptive variable names. 
- done in merge step

#### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- melt the data frame with id subject and activity
- cast the molten 

#### Write the casted data to castedX.txt file.
- write the table to file

For any details I encourage you to have a look into the script.

Thanks and good luck 
ironsugus
