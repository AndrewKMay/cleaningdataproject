# Preparatory code
library(tidyverse)

# Reading in the raw data

## Features vector
features <- read.delim("UCI HAR Dataset/features.txt", sep = "", header = FALSE)
features <- features %>%
  select(-c(V1)) %>%
  rename(feature = V2)

## Training data
train.data <-  read.delim("UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)
train.labels <- read.delim("UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE)
train.subjects <- read.delim("UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE)

### Clearly naming the training data (objective 4)
train.subjects <- train.subjects %>%
  rename(subjects = V1)
train.labels <- train.labels %>%
  rename(activity = V1) %>%
  mutate(activity = recode(activity, "1" = "walking", "2" = "walking_upstairs", "3" = "walking_downstairs", "4" = "sitting", "5" = "standing", "6" = "laying"))

### Renaming variables using the 561-feature vector (objective 4)
oldnames <- colnames(train.data)
newnames <- features[,1]
#### some variable names are duplicated, which prevents renaming of columns 
newnames <- make.unique(newnames)

train.data <- train.data %>%
  rename_with(~ newnames[which(oldnames == .x)], .cols = oldnames)

### Merging all training data together
train.full <- cbind(train.subjects, train.labels)
train.full <- cbind(train.full, train.data)

### Adding a 'training' variable to distinguish from the test data

train.full <- train.full %>%
  add_column("set" = "training", .after =  "subjects")


## Test data
test.data <-  read.delim("UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)
test.labels <- read.delim("UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE)
test.subjects <- read.delim("UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE)

### Clearly naming test data (objective 4)
test.subjects <- test.subjects %>%
  rename(subjects = V1)
test.labels <- test.labels %>%
  rename(activity = V1) %>%
  mutate(activity = recode(activity, "1" = "walking", "2" = "walking_upstairs", "3" = "walking_downstairs", "4" = "sitting", "5" = "standing", "6" = "laying"))

### Renaming variables using the 561-feature vector (objective 4)
test.data <- test.data %>%
  rename_with(~ newnames[which(oldnames == .x)], .cols = oldnames)

### Merging all test data together
test.full <- cbind(test.subjects, test.labels)
test.full <- cbind(test.full, test.data)

### Adding a 'test' variable to distinguish from the training data

test.full <- test.full %>%
  add_column("set" = "test", .after =  "subjects")

# Merging the test and training data together (objective 1)

rawdata.all <- rbind(train.full, test.full)

# Extracting only the mean and standard deviation measurements (objective 2)
summarised.data <- rawdata.all %>%
  select(subjects, set, activity, matches(c("mean", "std")))

# Creating an independent, tidy data set (objective 5)

tidy.data <- summarised.data %>% 
  group_by(subjects, set, activity) %>%
  summarise(across(`tBodyAcc-mean()-X`:`fBodyBodyGyroJerkMag-std()`, ~mean(.x, na.rm = TRUE)))

# Exporting tidy data set to .csv

write.csv(tidy.data, "tidydata.csv")