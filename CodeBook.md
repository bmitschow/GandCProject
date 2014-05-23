## Code Book

Variables
- features: list of 561 types of tests (many have X, Y, Z components) - read in from features.txt
- test_data: raw test data - read in from test\x_test.txt
- train_data: raw train data - read in from train\x_train.txt
- merged_data: combined test_data and train_data
- test_data_activities: numeric data frame with values 1-6 describing activity measured - read in from test\y_test.txt
- train_data_activities: numeric data frame with values 1-6 describing activity measured - read in from train\y_train.txt
- test_data_subjects: numeric data frame with values 1:30 identifying subject - read in from test\subject_test.txt
- train_data_subjects: numeric data frame with values 1:30 identifying subject - read in from train\subject_train.txt
- merged_activities: combined activities from test and train data
- merged_subjects: combined subjects from test and train data
- list_mean_stdev_labels: list of plain-text labels to extract (mean and standard deviation columns)
- list_mean_stdev: list of indices to extract (mean and standard deviation columns)

Transformations
- line 48:50 - looped through merged_data to extract columns with mean or standard deviation data
- line 53 - added all column names (mostly from list_mean_stdev_labels to new extracted_data data frame
- line 56:59 - convert numbered activities data into descriptive activity names and add to extracted_data
- line 63:64 - melt extracted_data then sort by subjects and activities columns - finally, calculate mean of each column