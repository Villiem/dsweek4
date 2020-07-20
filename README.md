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