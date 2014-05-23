setwd("UCI HAR Dataset")

# Import test & train data
features <- read.table("features.txt", allowEscapes=FALSE, header=FALSE)
test_data <- read.table("test\\X_test.txt", allowEscapes=FALSE, header=FALSE, col.names=features[,2]) # Features list becomes col header
train_data <- read.table("train\\X_train.txt", allowEscapes=FALSE, header=FALSE, col.names=features[,2]) # Features list becomes col header
merged_data <- rbind(test_data, train_data) # Merge test_data & train_data

# Import activities & subjects
test_data_activities <- read.table("test\\y_test.txt", allowEscapes=FALSE, header=FALSE)
train_data_activities <- read.table("train\\y_train.txt", allowEscapes=FALSE, header=FALSE)
test_data_subjects <- read.table("test\\subject_test.txt", allowEscapes=FALSE, header=FALSE)
train_data_subjects <- read.table("train\\subject_train.txt", allowEscapes=FALSE, header=FALSE)

# Combine activities & subjects
merged_activities <- rbind(test_data_activities, train_data_activities)
colnames(merged_activities) <- "Activities"
merged_subjects <- rbind(test_data_subjects, train_data_subjects)
colnames(merged_subjects) <- "Subjects"

# Colnames to extract (mean & standard deviation)
list_mean_stdev_labels <- c("Body-Acceleration-Mean-X","Body-Acceleration-Mean-Y","Body-Acceleration-Mean-Z","Body-Acceleration-stdev-X","Body-Acceleration-stdev-Y","Body-Acceleration-stdev-Z",
                            "Gravity-Acceleration-Mean-X","Gravity-Acceleration-Mean-Y","Gravity-Acceleration-Mean-Z","Gravity-Acceleration-stdev-X","Gravity-Acceleration-stdev-Y","Gravity-Acceleration-stdev-Z",
                            "Body-Linear-Acceleration-Mean-X","Body-Linear-Acceleration-Mean-Y","Body-Linear-Acceleration-Mean-Z","Body-Linear-Acceleration-stdev-X","Body-Linear-Acceleration-stdev-Y","Body-Linear-Acceleration-stdev-Z",
                            "Gyroscope-Mean-X","Gyroscope-Mean-Y","Gyroscope-Mean-Z","Gyroscope-stdev-X","Gyroscope-stdev-Y","Gyroscope-stdev-Z",
                            "Body-Angular-Velocity-Mean-X","Body-Angular-Velocity-Mean-Y","Body-Angular-Velocity-Mean-Z","Body-Angular-Velocity-stdev-X","Body-Angular-Velocity-stdev-Y","Body-Angular-Velocity-stdev-Z",
                            "Body-Acceleration-Magnitude-Mean","Body-Acceleration-Magnitude-stdev",
                            "Gravity-Acceleration-Magnitude-Mean","Gravity-Acceleration-Magnitude-stdev",
                            "Body-Linear-Acceleration-Magnitude-Mean","Body-Linear-Acceleration-Magnitude-stdev",
                            "Gyroscope-Magnitude-Mean","Gyroscope-Magnitude-stdev",
                            "Body-Angular-Velocity-Magnitude-Mean","Body-Angular-Velocity-Magnitude-stdev",
                            "Body-Acceleration-Frequency-Mean-X","Body-Acceleration-Frequency-Mean-Y","Body-Acceleration-Frequency-Mean-Z","Body-Acceleration-Frequency-stdev-X","Body-Acceleration-Frequency-stdev-Y","Body-Acceleration-Frequency-stdev-Z",
                            "Gravity-Acceleration-Frequency-Mean-X","Gravity-Acceleration-Frequency-Mean-Y","Gravity-Acceleration-Frequency-Mean-Z","Gravity-Acceleration-Frequency-stdev-X","Gravity-Acceleration-Frequency-stdev-Y","Gravity-Acceleration-Frequency-stdev-Z",
                            "Gyroscope-Frequency-Mean-X","Gyroscope-Frequency-Mean-Y","Gyroscope-Frequency-Mean-Z","Gyroscope-Frequency-stdev-X","Gyroscope-Frequency-stdev-Y","Gyroscope-Frequency-stdev-Z",
                            "Body-Acceleration-Magnitude-Frequency-Mean","Body-Acceleration-Magnitude-Frequency-stdev",
                            "Body-Linear-Acceleration-Magnitude-Frequency-Mean","Body-Linear-Acceleration-Magnitude-Frequency-stdev",
                            "Gyroscope-Magnitude-Frequency-Mean","Gyroscope-Magnitude-Frequency-stdev",
                            "Body-Angular-Velocity-Magnitude-Frequency-Mean","Body-Angular-Velocity-Magnitude-Frequency-stdev")

# Column numbers to extract (mean & standard deviation)
list_mean_stdev <- c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,
                     201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,424,425,
                     426,427,428,429,503,504,516,517,529,530,542,543)

extracted_data <- data.frame(Activities=merged_activities, Subjects=merged_subjects)

# Extract mean & standard deviation
for (i in 1:length(list_mean_stdev)) {
     extracted_data[, i+2] <- merged_data[, list_mean_stdev[i]]
}

# Add updated colnames to new data frame
colnames(extracted_data) <- c("Activities", "Subjects", list_mean_stdev_labels)

# Convert numbered activities (1-6) into descriptive activity names
activity_labels <- read.table("activity_labels.txt")
for (j in 1:length(extracted_data[, 1])) {
     extracted_data[j, 1] <- as.character(activity_labels[extracted_data[j, 1], 2])
}

# Loop through extracted_data and calculate average of each variable for each subject performing each activity
library(reshape2)
extracted_data_melt <- melt(extracted_data, id=c("Activities", "Subjects"))
means <- dcast(extracted_data_melt, formula = Subjects + Activities ~ variable, mean)

# Export data
library(xlsx)
write.xlsx(means, file="tidy_data_means.xls")