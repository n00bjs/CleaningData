install.packages("plyr")
library("plyr")
##STEP 1
## Read x_train.txt and y_train.txt
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")

## Read x_test and y_test
xTest <- read.table("UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Merge x_train and x_test
xData <- rbind(xTrain, xTest)

# Merge y_train and y_test
yData <- rbind(yTrain, yTest)

#merge subject_train adn subject_test
subjectData <- rbind(subjectTrain, subjectTest)

##STEP 2
#Read feature.txt and sample columns with mean and std 
features <- read.table("UCI HAR Dataset/features.txt")
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])
xData <- xData[, mean_and_std_features]
names(xData) <- features[mean_and_std_features,2]

##STEP 3
#Read activities and apply it to columns names of y_data
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
yData[, 1] <- activities[yData[, 1], 2]
names(yData) <- "activity"

##STEP 4
names(subjectData) <- "subject"
all_data <- cbind(xData, yData, subjectData)

#STEP 5
#Create second data set with averages 
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

#Write it to file using write.table
write.table(averages_data, "averagesData.txt", row.name=FALSE)