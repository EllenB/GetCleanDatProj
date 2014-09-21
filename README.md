#Getting and cleaning data: Coursera course project

### Background

For this project, we were given data collected from the accelerometers from the Samsung Galaxy S smartphone. A description of the dataset can be found here:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 

In short (more information regarding the dataset is also given in the CodeBook.md in this repository), the data experiments are obtained from 30 volunteers and each person performed six activities: walking, walking upstairs, walking downstairs, sitting, standing and laying and while a smartphone (Samsung Galaxy S II) is strapped on the waist. An embedded accelerometer and gyroscope is captured captured to measure 3-axial linear acceleration and 3-axial angular velocity (at a constant rate of 50Hz). The obtained dataset has been randomly partitioned into a training (70%) and test dataset (30%).


The data can be downloaded from here:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )

After you unzip this directory, you will discover several files/directories in the UCI Har Dataset. Here, I will not give an exhaustive list but solely focus on the ones I need for the R program for this project:

**test:** This is a directory that contains the following files: 

- *subject_test:* This gives an identifier of the subject in the study. In total there are 30 subjects in this study. Some subjects are in the test dataset and others are in the training dataset. 
- *X-test*: These are features (measurements) in the dataset. More details I will give in the CodeBook.md posted in this Github directory and a brief description and references for the same is already given above.
- *Y-test*: For each observation, this refers to the six activities explained above such as walking, laying, etc. 

**train:**: This directory contains similar files as the test directory:

- *subject_train*
- *X-train*
- *Y-train* 

Then there are other files in the UCI Har Dataset:
 
- *activity_labels*: This file gives a link between the labels (being labeled as 1- 6) and what this label means such as walking, laying, etc.  
- *features*: This file gives the names of all the features in the dataset. In total, there are 561 features. 
- *features_info*: This file explains what each of the raw variables/features mean. This file will be used for making the CodeBook.md that is also posted in this repository.  

### Files in this github repository:
- *README:* This is the current file.
- *run_analysis:* This is the R program you need to run where you put all the data in the same directory as this R program. 
- *CodeBook:* This file explains the variables that are created after running the R program (run_analysis). 
- *Merged:* This project requires to create two output/data files. This is the first text files and will be explained a bit in greater detail below.
- *Tidy*: This is the second output/data text file and is obtained and is the "end" file after running the R program.

### Explanation of the R program and the data files created
For this project, we were asked to execute five steps. In the R program in this repository, I also document which R commands are associated with each of these five steps. 

1. *Merges the training and the test sets to create one data set.* In this step, I download the 3 files from the training dataset and the 3 files from the test dataset (see description above). First, I do a "column" merge and create a test and training data set respectively. The first column gives the identifier for the subject (called ID), the second column gives the activity (denoted by Label) and the rest of the columns (many!) give the features. Using the file "features.txt" mentioned above, I use this file to create the variable names of all the measurements/features. I do the same steps for the test dataset. The training set that is created using the R program is called "Train" and the test dataset is called "Test". Finally, I perform a "row" merge and "append" the test dataset to the training dataset. This results in a dataset called "Merged" (which is stored in R).
2. *Extracts only the measurements on the mean and standard deviation for each measurement.* In this step, I use regular expression commands in R. More specifically, I use the "grep" command. This results in the dataset "Merged_Small" (which is stored in R locally).
3. *Uses descriptive activity names to name the activities in the data set* In this step, I clean the variable names a bit. For a more detailed explanation of the final variables, I refer to the CodeBook in this repository. I have done the following cleaning steps: a) removed the brackets "()", b) from the letter "t" I explicitly called it "Time" as "t" refers to time, c) from the letter "f" I explicitly called it "Frequency" as "f" refers to frequency, d) "BodyBody" is replaced with "Body", e) hyphens "-" I replaced with underscores "_" and f) I wrote some of the parts of the variable names with capital letters. 
4. *Appropriately labels the data set with descriptive variable names.* In this step, I link the file "activity_labels" with the "Merged_Small" file. In other words, in the second file the activity labels, denoted as "Labels" are denoted as 1-6. The file "activity_labels" connects what the numbers 1-6 mean in terms of what number is what activity such as walking, laying, etc. In this step, I replace the numbers 1-6 with the actual name of the activity. In this step, we were asked to write the R dataset into a text file. This text file is called **Merged** and is also posted in this repository. Next to the ID and label variables, this dataset contains 66 features and its length is 10 299 observations. 
5. *From the data set in step 4, creates a second, independent tidy data 
set with the average of each variable for each activity and each subject.* In this step, I use the R package "plyr" with the command "ddply". I get a dataset with 66 features and 180 observations. We were asked to write this dataset into a text file and in my case this file is called **Tidy**. This text file is also posted in this repository.

### References

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
 

