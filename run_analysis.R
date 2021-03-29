# load necessary packages for data processing
library(dplyr)

# set paths to the data
data_path <- 'UCI HAR Dataset/'
test_data_path <- paste(data_path, 'test', sep = '/')
train_data_path <- paste(data_path, 'train', sep = '/')

# load whitespace delimited data for train and test sets
x_train <- read.table(paste(train_data_path, 'x_train.txt', sep = '/'))
x_test <- read.table(paste(test_data_path, 'x_test.txt', sep = '/'))
y_train <- read.table(paste(train_data_path, 'y_train.txt', sep = '/'), col.names = 'activity')
y_test <- read.table(paste(test_data_path, 'y_test.txt', sep = '/'), col.names = 'activity')
subj_train <- read.table(paste(train_data_path, 'subject_train.txt', sep = '/'), col.names = 'subject')
subj_test <- read.table(paste(test_data_path, 'subject_test.txt', sep = '/'), col.names = 'subject')

# bind activity, subject, and sensor data
sensor_data <- rbind(x_train, x_test)
activity_data <- rbind(y_train, y_test)
subj_data <- rbind(subj_train, subj_test)

# read in the list of column names for sensor_data
features <- read.table(paste(data_path,'features.txt', sep = '/'), col.names = c('col_nr,', 'colname'))
# extract the columns that contain means and stds
mean_and_std_cols <- grep('mean\\(\\)|std\\(\\)',features$colname)
# map these columns to the column names in sensor_data
select_cols <- paste('V', mean_and_std_cols, sep='')

# convert sensor data to tibbles and extract mean & std columns
sensor_data <- tbl_df(sensor_data)
sensor_data <- select(sensor_data, select_cols)
# set column names for sensor_data
names(sensor_data) <- as.character(features$colname[mean_and_std_cols])

# merge all data together
data_set <- cbind(subj_data, activity_data, sensor_data)
data_set <- tbl_df(data_set)

# calculate average across all varibles by subject and activity
data_set <- group_by(data_set, subject, activity)
data_avs <- summarize_all(data_set, mean)

# send results to tidy data file
write.table(data_avs, 'activity_data_tidy.txt')
