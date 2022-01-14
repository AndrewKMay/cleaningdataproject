# Getting and Cleaning Data Course Project - codebook

## Data description

This codebook pertains to a tidied data set derived from the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Experiments were carried out on 30 individuals, aged 19-48 years. Each participant engaged in six different activities (walking, walking upstairs, walking downstairs, sitting, and standing) whilst wearing a Samsung Galaxy S II smartphone attached at the waist. Data from the embedded accelerometer and gyroscope were captured, including 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50 Hz. Participants were randomly partitioned into a training set (70% of participants) and a test set (30% of participants). 

The raw data includes 561 variables, ranging from raw recorded values from the accelerometer and gyroscope, to various summary measures (mean, standard deviation, minimum, maximum, etc.) per experiment. The purpose of the tidy data set is to provide a simplified data set focused only on mean and standard deviation measurements, averaged for each variable, for each activity, and for each subject. The process for tidying the raw data is outlined below:

## Procedure for tidying

- The raw data were imported into R (version 4.1.0 (2021-05-18))
- For both the test and training raw data, subject identifiers (1-30) and activity labels (walking, walking_upstairs, walking_downstairs, sitting, and standing) were appended together.
- The 561-feature list was used to label the variable columns in each of the training and test sets
- The training and test sets were merged into a single data set
- From the merged data set, only variables pertaining to mean and standard deviation measurements were extracted
- Averages per participant, per activity, per mean and standard deviation measurement were calculated and stored in an independent tidy data set, available in this repo (as a .csv or .txt file).

The code for conducting the aforementioned tidying procedure is provided in the run_analysis.R script within this repo. 

## Tidy data codebook

The tidy data set includes 180 rows with 89 columns. The columns are described below:

- subjects: the numeric nominal variable for each participant (1-30)
- set: indicates whether the subject was part of the test or training data set
- activity: a categorical variable describing the activity of the experiment (walking, walking_upstairs, walking_downstairs, sitting, and standing)
- columns 4-89: mean and standard deviation measurements obtained from the accelerometer and gyroscope, including 3-axial linear acceleration and 3-axial linear angular velocity. 
