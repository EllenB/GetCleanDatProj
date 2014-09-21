##########################################################################
## Step 1: 1.Merges the training and the test sets to create one data set. 
##########################################################################
## Setting the working directory first
#setwd("E:/Ellen/coursera/GettingData/Project")

## Reading in the training data:
Train_X <- read.table("X_train.txt")
dim(Train_X) #7352  561
Train_Y <- read.table("Y_train.txt",col.names = "Labels")
dim(Train_Y) #7352 1
Train_Subject <- read.table("subject_train.txt",col.names = "Id")
  
## Reading in the test data:
Test_X <- read.table("X_test.txt")
Test_Y <- read.table("Y_test.txt", col.names="Labels")
Test_Subject <- read.table("subject_test.txt",col.names="Id")

## Reading in the features:
features <- read.table ("features.txt", stringsAsFactors=FALSE)
dim(features) #561 2
## Only will use the second column
features <- features [,2]
# stringAsFactors is used in order to not read this into 
# Keep only the second column:
# Use this as the names for the X-variables of the training and test dataset:
names(Train_X) <- features
names(Test_X) <-features

## Append the different sets of the training and test data (column merge):
Train <- cbind(Train_Subject, Train_Y,Train_X)
Test <- cbind(Test_Subject,Test_Y,Test_X)
## 

## Merge the train and the test dataset into one dataset:
Merged <- rbind(Train,Test)
dim(Merged) #10299 563

#############################################################################
## 2. Extracts only the measurements on the mean and standard deviation for 
##    each measurement.
#############################################################################
names(Merged)
## Filter out which names of this file either contain "mean()" or "std()":
# Also, this should not contain "meanFreq"
MeanStdVar <- grep("mean\\(\\)|std\\(\\)",names(Merged))
MeanStdVar
Merged_Small <- Merged[,c(1,2,MeanStdVar)]
names(Merged_Small) # Looks OK.
############################################################################
## 3.Uses descriptive activity names to name the activities in the data set
############################################################################
## Remove the ()
names(Merged_Small) <- gsub("\\(\\)", "", names(Merged_Small)) 
## t stands for "time":
names(Merged_Small) <-gsub( "^t", "Time_",names(Merged_Small))
## f stands for "frequency":
names(Merged_Small) <-gsub( "^f", "Frequency_",names(Merged_Small))
names(Merged_Small)
## In some variable names we have "BodyBody" which I replace with "Body"
names(Merged_Small) <-gsub( "BodyBody", "Body",names(Merged_Small))
## Replace "-" with "_":
names(Merged_Small) <-gsub( "-", "_",names(Merged_Small))
## Write "mean" with capital letter:
names(Merged_Small) <-gsub( "mean", "Mean",names(Merged_Small))
## Write "std" with capital letter:
names(Merged_Small) <-gsub( "std", "Std",names(Merged_Small))
###############################################################################
## 4. Appropriately labels the data set with descriptive variable names. 
###############################################################################
labels <- read.table("activity_labels.txt")
## The "Label" column in the Merged_Small dataset you need to replace with
## descriptive names of the activities (6 in total):
labels[,2] <-gsub( "_", " ",labels[,2])
##install.packages("stringi")
require(stringi)
labels[,2] <- stri_trans_tolower(labels[,2])
labels[,2] <- stri_trans_totitle(labels[,2])
labels[,2] <-gsub( " ", "_",labels[,2])
## Merge this with the Merged_Small dataset:
Merged_Small$Labels <- labels[,2][match(Merged_Small$Labels,labels[,1])] 
## Save the first dataset:
write.table(Merged_Small, "Merged.txt")
###############################################################################
## 5. From the data set in step 4, creates a second, independent tidy data 
##    set with the average of each variable for each activity and each subject.
###############################################################################
library(plyr) 
##Column means for all but the subject and activity columns 
## See: http://stackoverflow.com/questions/10787640/ddply-summarize-for-repeating-same-statistical-function-across-large-number-of
Tidy <- ddply(Merged_Small, .(Id,Labels), numcolwise(mean))  
dim(Tidy)    #180 68                 
names(Tidy)[-c(1,2)] <- paste0("MEAN_", names(Tidy)[-c(1,2)]) 
## Write this dataset in a text file:
write.table(Tidy,"Tidy.txt",row.name=FALSE)