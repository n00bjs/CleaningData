# run_analysis.R work flow

##Step 1
* read X_train.txt, y_train.txt and subject_train.txt
```R
  xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
  yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
  subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
```
* read X_test.txt, y_test.txt and subject_test.txt
```R
  xTest <- read.table("UCI HAR Dataset/test/X_test.txt")
  yTest <- read.table("UCI HAR Dataset/test/y_test.txt")
  subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
```

* Merge train, test and subject dataset
```R
  xData <- rbind(xTrain, xTest)
  yData <- rbind(yTrain, yTest)
  subjectData <- rbind(subjectTrain, subjectTest)
```
##Step 2
* Read feature.txt and sample columns with mean and std 
```R
  features <- read.table("UCI HAR Dataset/features.txt")
  mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])
  xData <- xData[, mean_and_std_features]
  names(xData) <- features[mean_and_std_features,2]
```

##Step 3
* Read activities and apply it to columns names of y_data
```R
  activities <- read.table("UCI HAR Dataset/activity_labels.txt")
  yData[, 1] <- activities[yData[, 1], 2]
  names(yData) <- "activity"
```

##Step 4 
* Merge all data
```R
  names(subjectData) <- "subject"
  all_data <- cbind(xData, yData, subjectData)
```

##Step 5
* Create second data set with column means and write it to file
```R
  averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
  write.table(averages_data, "averagesData.txt", row.name=FALSE)
```

# Variables Used
| Name                 | Description                               |
| ---------------------| ------------------------------------------|
|xTrain                | Read Data from X_train.txt                |
|xTest                 | Read Data from X_test.txt                 |
|yTrain                | Read Data from y_train.txt                |
|yTest                 | Read Data from y_test.txt                 |
|subjectTrain          | Read Data from subject_train.txt          |
|subjectTest           | Read Data from subject_train.txt          |
|xData                 | Merged Data [ xTrain + xTest ]            |
|yData                 | Merged Data [ yTrain + yTest ]            |
|subjectData           | Merged Data [ subjectTrain+ subjectTest ] |
|mean_and_std_features | column indices with std|mean names        |
|all_data              | Tidy data without Column mean             |
|averages_data         | Tidy data with column mean                |
