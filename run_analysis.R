# Installing and importing the readtext package
# install.packages("readtext")
# library(readtext)
# library(dplyr)

# import dataasets
X_train <- read.table('UCI HAR Dataset/train/X_train.txt')
y_train <- read.table('UCI HAR Dataset/train/y_train.txt')
subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt')

X_test <- read.table('UCI HAR Dataset/test/X_test.txt')
y_test <- read.table('UCI HAR Dataset/test/y_test.txt')
subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt')


#import feature names
features <- read.table('UCI HAR Dataset/features.txt',stringsAsFactors = FALSE)
activity <- read.table('UCI HAR Dataset/activity_labels.txt',stringsAsFactors = FALSE)

# 1. Merge datasets
X <- bind_rows(X_train, X_test)
y <- bind_rows(y_train, y_test)
subject <- bind_rows(subject_train, subject_test)
names(subject) <- 'subject'

# 2. Extracts only the measurements on the mean and standard deviation
names(X) <- features[['V2']]
# removing duplicated features and selecting features containing mean and std
X <- X[!duplicated(colnames(X))]
X2 <- X %>% select(matches('mean|std'))

# 3 Descriptive activity names in the taget vectors
y[[1]] <- activity[y[[1]],2]
names(y) <- 'activity'
# 4.Accomplished at step 2

# 5. finding mean of each measurement per activity and subject
df <- bind_cols(X2, subject, y)
grouped_mean <- df %>% group_by(subject, activity) %>% summarise_all(list(mean))
write.table(grouped_mean, 'grouped_mean.txt')
