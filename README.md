## README

- line 16 - combine activities from both test and train data sets
- line 18 - combine subjects from both test and train data sets
- line 45 - create new empty data frame for extracted data
- line 48:50 - looped through merged_data to extract columns with mean or standard deviation data
- line 53 - added all column names (mostly from list_mean_stdev_labels to new extracted_data data frame
- line 56:59 - convert numbered activities data into descriptive activity names and add to extracted_data
- line 63:64 - melt extracted_data then sort by subjects and activities columns - finally, calculate mean of each column
- line 67:68 - write final tidy data set of means and standard deviations out to tidy_data_means.xls
- line 69 - write final tidy data set of means and standard deviations out to tidy_data_means.txt - used for Coursera submission