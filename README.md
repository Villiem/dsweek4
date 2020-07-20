## Getting and Cleaning Data Project

The goal is to create a tidyData set. The first part is fairly standard,
Creating a dir called data, downloading the file and finally unzip it.

the second part(for loop) was the harderst part so I will break it down
most people repeated read.table 6 times, 1 for each file.

1. I listed all the files in the train or test directory, wich gave undesired files like data/UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt.

2. I selected files not containning the word 'Inertial Signals'. This gave me the 6 files I needed, so my next challenge was grouping the files like 'subject_train.txt' & 'subject_test.txt'. So my first approach was to detect the word 'subject', 'x' and 'y' and create 3 df.

3. I made 2 lists, and the regex for every group. then I looped to create a list of lists containning the desired files. Then I applied read_table with map_df with return a df that I stored on the second list.

4. I had a list of df, wich I just cbind to make them 1 df.

5. Naming, joinning and grouping, it was also fairly straightforward.


## Variables
##Variable and descriptions
###Subject
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 

Variable name    | Description
-----------------|------------
subject          | ID of the 30 volunteers  who performed the activity. Its range is from 1 to 30.

###Activity
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.

Variable name    | Description
-----------------|------------
activity         |  Activity type that the 30 volunteers  who performed the activity. 
                 |  Its has 6 levels:
                 |   1. WALKING
                 |   2. WALKING_UPSTAIRS
                 |   3. WALKING_DOWNSTAIRS
                 |   4. SITTING
                 |   5. STANDING
                 |   6. LAYING
###Features
Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz are captured. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals 
timeAccelerometer a-XYZ and timeGyroscope-XYZ. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (timeBodyacceleration-XYZ and timeGravityAcceleration-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (timeBodyAccelerationJerk-XYZ and timeBodyGyroscopeJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (timeBodyAccelerationMagnitude, timeGravityAccelerationMagnitude, timeBodyAccelerationJerkMagnitude, timeBodyGyroscopeMagnitude, timeBodyGyroscopeJerkMagnitude). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcceleration-XYZ, frequencyBodyAccelerationJerk-XYZ, frequencyBodyGyro-XYZ, frequencyBodyAccelerationJerkMagnitude, frequencyBodyGyroMagnitude, frequencyBodyGyroJerkMagnitude. 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* ` timeBodyAccelerometer-XYZ `
* ` timeGravityAccelerometer-XYZ `
* ` timeBodyAccelerometerJerk-XYZ `
* ` timeBodyGyroscope-XYZ `
* ` timeBodyGyroscopeJerk-XYZ `
* ` timeBodyAccelerometerMagnitude `
* ` timeGravityAccelerometerMagnitude `
* ` timeBodyAccelerometerJerkMagnitude `
* ` timeBodyGyroscopeMagnitude `
* ` timeBodyGyroscopeJerkMagnitude `
* ` frequencyBodyAccelerometer-XYZ `
* ` frequencyBodyAccelerometerJerk-XYZ `
* ` frequencyBodyGyroscope-XYZ `
* ` frequencyBodyAccelerometerMagnitude `
* ` frequencyBodyAccelerometerJerkMagnitude `
* ` frequencyBodyGyroscopeMagnitude `
* ` frequencyBodyGyroscopeJerkMagnitude `

The set of variables that were estimated from these signals are: 
* ` mean(): Mean value `
* ` std(): Standard deviation `

## Identifiers

* `subject` - The ID of the test subject
* `activity` - The type of activity performed when the corresponding measurements were taken

--------------------------------
## Tidy Data Structure
###Column Heading (Unit wise)
* ` timeBodyAccelerometer-mean()-X (radians per sec) `
* ` timeBodyAccelerometer-mean()-Y (radians per sec) `
* ` timeBodyAccelerometer-mean()-Z (radians per sec) `
* ` timeBodyAccelerometer-std()-X (radians per sec) `
* ` timeBodyAccelerometer-std()-Y (radians per sec) `
* ` timeBodyAccelerometer-std()-Z (radians per sec) `
* ` timeGravityAccelerometer-mean()-X (radians per sec) `
* ` timeGravityAccelerometer-mean()-Y  (radians per sec) `
* ` timeGravityAccelerometer-mean()-Z  (radians per sec) `
* ` timeGravityAccelerometer-std()-X  (radians per sec) `
* ` timeGravityAccelerometer-std()-Y  (radians per sec) `
* ` timeGravityAccelerometer-std()-Z (radians per sec) `
* ` timeBodyAccelerometerJerk-mean()-X  (radians per sec) `
* ` timeBodyAccelerometerJerk-mean()-Y (radians per sec) `
* ` timeBodyAccelerometerJerk-mean()-Z (radians per sec) `
* ` timeBodyAccelerometerJerk-std()-X  (radians per sec) `
* ` timeBodyAccelerometerJerk-std()-Y  (radians per sec) `
* ` timeBodyAccelerometerJerk-std()-Z  (radians per sec) `
* ` timeBodyGyroscope-mean()-X (radians per sec) `
* `  timeBodyGyroscope-mean()-Y (radians per sec) `
* ` timeBodyGyroscope-mean()-Z (radians per sec) `
* ` timeBodyGyroscope-std()-X (radians per sec) `
* ` timeBodyGyroscope-std()-Y (radians per sec) `
* ` timeBodyGyroscope-std()-Z (radians per sec) `
* ` timeBodyGyroscopeJerk-mean()-X (radians per sec) `
* ` timeBodyGyroscopeJerk-mean()-Y (radians per sec) `
* ` timeBodyGyroscopeJerk-mean()-Z (radians per sec) `
* ` timeBodyGyroscopeJerk-std()-X (radians per sec) `
* ` timeBodyGyroscopeJerk-std()-Y (radians per sec) `
* ` timeBodyGyroscopeJerk-std()-Z (radians per sec) `
* ` timeBodyAccelerometerMagnitude-mean() (radians per sec) `
* ` timeBodyAccelerometerMagnitude-std() (radians per sec) `
* ` timeGravityAccelerometerMagnitude-mean() (radians per sec) `
* ` timeGravityAccelerometerMagnitude-std() (radians per sec) `
* ` timeBodyAccelerometerJerkMagnitude-mean() (radians per sec) `
* ` timeBodyAccelerometerJerkMagnitude-std() (radians per sec) `
* ` timeBodyGyroscopeMagnitude-mean() (radians per sec) `
* ` timeBodyGyroscopeMagnitude-std() (radians per sec) `
* ` timeBodyGyroscopeJerkMagnitude-mean() (radians per sec) `
* ` timeBodyGyroscopeJerkMagnitude-std() (radians per sec) `
* ` frequencyBodyAccelerometer-mean()-X (hertz) `
* ` frequencyBodyAccelerometer-mean()-Y  (hertz) `
* ` frequencyBodyAccelerometer-mean()-Z (hertz) `
* ` frequencyBodyAccelerometer-std()-X  (hertz) `
* ` frequencyBodyAccelerometer-std()-Y  (hertz) `
* ` frequencyBodyAccelerometer-std()-Z  (hertz) `
* ` frequencyBodyAccelerometerJerk-mean()-X (hertz) `
* ` frequencyBodyAccelerometerJerk-mean()-Y (hertz) `
* ` frequencyBodyAccelerometerJerk-mean()-Z (hertz) `
* ` frequencyBodyAccelerometerJerk-std()-X (hertz) `
* ` frequencyBodyAccelerometerJerk-std()-Y (hertz) `
* ` frequencyBodyAccelerometerJerk-std()-Z (hertz) `
* ` frequencyBodyGyroscope-mean()-X  (hertz) `
* ` frequencyBodyGyroscope-mean()-Y (hertz) `
* ` frequencyBodyGyroscope-mean()-Z  (hertz) `
* ` frequencyBodyGyroscope-std()-X  (hertz) `
* ` frequencyBodyGyroscope-std()-Y  (hertz) `
* ` frequencyBodyGyroscope-std()-Z (hertz) `
* ` frequencyBodyAccelerometerMagnitude-mean() (hertz) `
* ` frequencyBodyAccelerometerMagnitude-std() (hertz) `
* ` frequencyBodyAccelerometerJerkMagnitude-mean() (hertz) `
* ` frequencyBodyAccelerometerJerkMagnitude-std() (hertz) `
* ` frequencyBodyGyroscopeMagnitude-mean() (hertz) `
* ` frequencyBodyGyroscopeMagnitude-std() (hertz) `
* ` frequencyBodyGyroscopeJerkMagnitude-mean() (hertz) `
* ` frequencyBodyGyroscopeJerkMagnitude-std() (hertz) `
