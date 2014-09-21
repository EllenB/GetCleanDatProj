#Code book for the Coursera project Getting and cleaning data

### Background

For this project, we were given data collected from the accelerometers from the Samsung Galaxy S smartphone. A description of the dataset can be found here:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 

The data experiments are obtained from 30 volunteers and each person performed six activities: walking, walking upstairs, walking downstairs, sitting, standing and laying and while a smartphone (Samsung Galaxy S II) is strapped on the waist. An embedded accelerometer (denoted as Acc) and gyroscope (denoted as Gyro) is captured to measure 3-axial linear acceleration and 3-axial angular velocity (at a constant rate of 50Hz). The obtained dataset has been randomly partitioned into a training (70%) and test dataset (30%). 

The data can be downloaded from here:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )

The following more detailed explanation is obtained from the file "features_info.txt" which can be found from the above link. More spefically, accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ are given with X, Y and Z denoting the axis. In the dataset, accelerometer is denoted as (Acc) and gyroscope is denoted as (gyro). The "t" stands for "time". respectively. In the R program explained below, I will transform the variable names containing "t" into variable names containing "time". 

Then some filters were used to removed some noise and then split into "body" and "gravity" acceleration filters denoted as "tBodyAcc-XYZ" and "tGravityAcc-XYZ".

Acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ) and also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). Also, Fast Fourier Transform (FFT) was applied to some of these signals :fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. The "f" denotes "frequency" and the R program explained below, I will transform the variables names containing "f" into "frequency". 

More specifically, the raw dataset contains the following variables (see features_info.txt file):

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

On top of this, for each of these variables, the following was given:

- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between to vectors. 

### Explanation of the R program and how the variables were transformed. 
For this project, we were asked to execute five steps. In the R program in this repository, I also document which R commands are associated with each of these five steps and how I transformed the original variables. For this code book, it is mainly important to look at step 3 below as this described in detail how I transform the variables. All step 5 does in terms of data transformation is adding the prefix "MEAN" to it. For the purpose of this project, I only needed to retain the variables containing the "mean" and standard deviation "std".

1. *Merges the training and the test sets to create one data set.* In this step, I download the 3 files from the training dataset and the 3 files from the test dataset (see description above). First, I do a "column" merge and create a test and training data set respectively. The first column gives the identifier for the subject (called ID), the second column gives the activity (denoted by Label) and the rest of the columns (many!) give the features. Using the file "features.txt" mentioned above, I use this file to create the variable names of all the measurements/features. I do the same steps for the test dataset. The training set that is created using the R program is called "Train" and the test dataset is called "Test". Finally, I perform a "row" merge and "append" the test dataset to the training dataset. This results in a dataset called "Merged" (which is stored in R).
2. *Extracts only the measurements on the mean and standard deviation for each measurement.* In this step, I use regular expression commands in R. More specifically, I use the "grep" command. This results in the dataset "Merged_Small" (which is stored in R locally).
3. *Uses descriptive activity names to name the activities in the data set* In this step, I clean the variable names a bit. For a more detailed explanation of the final variables, I refer to the CodeBook in this repository. I have done the following cleaning steps: a) removed the brackets "()", b) from the letter "t" I explicitly called it "Time" as "t" refers to time, c) from the letter "f" I explicitly called it "Frequency" as "f" refers to frequency, d) "BodyBody" is replaced with "Body", e) hyphens "-" I replaced with underscores "_" and f) I wrote some of the parts of the variable names with capital letters. 
4. *Appropriately labels the data set with descriptive variable names.* In this step, I link the file "activity_labels" with the "Merged_Small" file. In other words, in the second file the activity labels, denoted as "Labels" are denoted as 1-6. The file "activity_labels" connects what the numbers 1-6 mean in terms of what number is what activity such as walking, laying, etc. In this step, I replace the numbers 1-6 with the actual name of the activity. In this step, we were asked to write the R dataset into a text file. This text file is called **Merged** and is also posted in this repository. Next to the ID and label variables, this dataset contains 66 features and its length is 10 299 observations. 
5. *From the data set in step 4, creates a second, independent tidy data 
set with the average of each variable for each activity and each subject.* In this step, I use the R package "plyr" with the command "ddply". I get a dataset with 66 features and 180 observations. We were asked to write this dataset into a text file and in my case this file is called **Tidy**. This text file is also posted in this repository. I transform the variables names by adding the prefix "MEAN" to each feature (except the first two features "ID" and "Label"). 

### Final list of variables
After cleaning up the data and running the 5 steps of the R program, I obtained 68 features in the "Tidy" dataset (one feature refers to the subject identifier (ID) and another feature to the "Activity" such as walking, laying, etc and this is denoted as "Label" in the "Tidy" dataset). The 66 other features are:

- MEAN\_Time\_BodyAcc\_Mean\_XYZ           
- MEAN\_Time\_BodyAcc\_Std\_XYZ                      
- MEAN\_Time\_GravityAcc\_Mean\_XYZ               
- MEAN\_Time\_GravityAcc\_Std\_XYZ               
- MEAN\_Time\_BodyAccJerk\_Mean\_XYZ              
- MEAN\_Time\_BodyAccJerk\_Std\_XYZ        
- MEAN\_Time\_BodyGyro\_Mean\_XYZ          
- MEAN\_Time\_BodyGyro\_Std\_XYZ          
- MEAN\_Time\_BodyGyroJerk\_Mean\_XYZ             
- MEAN\_Time\_BodyGyroJerk\_Std\_XYZ             
- MEAN\_Time\_BodyAccMag\_Mean           
- MEAN\_Time\_BodyAccMag\_Std           
- MEAN\_Time\_GravityAccMag\_Mean        
- MEAN\_Time\_GravityAccMag\_Std        
- MEAN\_Time\_BodyAccJerkMag\_Mean       
- MEAN\_Time\_BodyAccJerkMag\_Std       
- MEAN\_Time\_BodyGyroMag\_Mean          
- MEAN\_Time\_BodyGyroMag\_Std         
- MEAN\_Time\_BodyGyroJerkMag\_Mean      
- MEAN\_Time\_BodyGyroJerkMag\_Std      
- MEAN\_Frequency\_BodyAcc\_Mean\_XYZ      
- MEAN\_Frequency\_BodyAcc\_Std\_XYZ              
- MEAN\_Frequency\_BodyAccJerk\_Mean\_XYZ 
- MEAN\_Frequency\_BodyAccJerk\_Std\_XYZ   
- MEAN\_Frequency\_BodyGyro\_Mean\_XYZ     
- MEAN\_Frequency\_BodyGyro\_Std\_XYZ           
- MEAN\_Frequency\_BodyAccMag\_Mean      
- MEAN\_Frequency\_BodyAccMag\_Std      
- MEAN\_Frequency\_BodyAccJerkMag\_Mean
- MEAN\_Frequency\_BodyAccJerkMag\_Std  
- MEAN\_Frequency\_BodyGyroMag\_Mean     
- MEAN\_Frequency\_BodyGyroMag\_Std     
- MEAN\_Frequency\_BodyGyroJerkMag\_Mean 
- MEAN\_Frequency\_BodyGyroJerkMag\_Std

"MEAN" means that averages are taken (see step 5 above). "Time" refers to a time domain signal and frequency to a frequency domain signal. "Acc" to an accelerometer measurement and "gyro" to a gyroscope. "Mean" to the mean and "Std" to the standard deviation. XYZ refers to the 3-axial signals in the X, Y and Z directions. Other parts of the variable names such as "Body", "Jerk" and "JerkMag", "GyroMag", etc are explained higher in the part of the raw data.
 
### References

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
 

