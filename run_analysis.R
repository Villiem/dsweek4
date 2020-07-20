# You should create one R script called run_analysis.R that does the following.
# 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# 
# Good luck!
library(tidyverse) ## I always prefer this over base. In this case read_table over read.table
if(!file.exists("./data")){
  dir.create("./data")
  }
# the data for the project:
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip dataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")
 
# A lot of people mannually loaded all the files, prob you did the same
# but I am way to lazy. So divide and conquer.
path <- 'data/UCI HAR Dataset/'

files <- list.files(path = path, pattern = "(train|test)", recursive=TRUE, full.names = T)
#filesToMerge <- files[!str_detect(files, 'Inertial Signals')] This also works
filesToMerge <- str_subset(string = files, 'Inertial Signals', negate = T)

# subjects <- str_subset(filesToMerge, 'subject') ## Subject
# activity <- str_subset(filesToMerge, 'y') ## y
# features <- str_subset(filesToMerge, 'X') ## X
# map_dfr(subject, read_table, col_names = F) ## For every object created above

# This was my first approach and it worked but as I said I´m lazy
# and I am repeating subset a lot so
## This will be explained in the README.md, it´s complicated, yet elegant
sub_string <- c('subject', 'y', 'X') 
myls <- vector("list", length = 3)
list_df <- vector("list", length = 3)
for (i in seq_along(sub_string)) {
  myls[[i]] <- str_subset(filesToMerge, sub_string[i])
  list_df[[i]] <- map_df(myls[[i]], read_table, col_names = F)
}

# So now I have a list with the 3 df I need, finally I just join columns
df <- do.call("cbind", list_df) ## This will give me the result desired :D
dim(df) # 10299 563
## a little naming
names <- read_table(file.path(path, 'features.txt'), col_names = F)[[1]]
names <- c('subject', 'activity', names)
colnames(df) <- names

# Extracting the measurements on the mean and sd
df_mean.std <- df %>% select(subject, activity, matches('mean|std'))

act_labels <- read_table('data/UCI HAR Dataset/activity_labels.txt', col_names = c('activity', 'activity_label'))
data <- df_mean.std %>% 
  left_join(act_labels, by = 'activity') %>%
  select(subject, activity, activity_label, everything()) %>% 
  mutate(activity = as_factor(activity),
         activity_label = as_factor(activity_label))
## Renaming
bad_names <- c("^t", "^f", "Acc", "Gyro", "Mag", "BodyBody")
better_names <- c("time", "frequency", "Accelerometer", "Gyroscope", "Magnitude", "Body")
for (i in seq_along(bad_names)) {
  names(data) <- gsub(bad_names[i], better_names[i], names(data))
}

## The new tidy set
tidyData <-data %>% select(-activity) %>%
  group_by(subject, activity_label) %>%
  summarise_all(funs(mean))

write.table(tidyData, "tidyData.txt", row.name=FALSE)
