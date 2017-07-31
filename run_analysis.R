#This script loads data files from the UCI HAR Dataset into R, then performs a sequence of manipulations
#on the data to produce a tidy dataset that is the combination of the sources test and training data.

#Lines 5-12 read the required files. 
featuresTest <- read.table("./data/UCI HAR Dataset/test/X_test.txt", stringsAsFactors = FALSE)
featuresTrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt", stringsAsFactors = FALSE)
subjectTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = FALSE)
subjectTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = FALSE)
positionTest <- read.table("./data/UCI HAR Dataset/test/y_test.txt", stringsAsFactors = FALSE)
positionTrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt", stringsAsFactors = FALSE)
featuresList <- read.table("./data/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)

#Lines 16-18 extract the desired subset of the original measurements: only the mean and standard deviation
#of each measurement period for each measurement system is kept. 
desiredFeatures <- grep("mean|std", featuresList$V2)
desiredTestData <- featuresTest[,desiredFeatures]
desiredTrainData <- featuresTrain[,desiredFeatures]

#Lines 21-25 assign descriptive names to each column in the datasets. 
colNames <- c("participant", "position", featuresList$V2[desiredFeatures])
testData <- cbind(subjectTest, positionTest, desiredTestData)
trainData <- cbind(subjectTrain, positionTrain, desiredTrainData)
names(testData) <- colNames
names(trainData) <- colNames

#Lines 28-33 convert from the numerical coding of each activity to simple labels, per the "activity_labels document in the UCI HAR Dataset folder.  
for(i in 1:6){
  testData$position <- gsub(i, activityLabels$V2[i], testData$position)
}
for(i in 1:6){
  trainData$position <- gsub(i, activityLabels$V2[i], trainData$position)
}

#Line 36 combines the test and training data into a single dataset. 
completeData <- rbind(trainData, testData) 

#Lines 39-53 create a data frame, and store the mean values of each measurement, sorted by participant number and body position in that data frame. 
condensedData <- data.frame()

library(dplyr)
for(i in 1:30){
   for(j in 1:6){
    currentParticipantAndPosition <- filter(completeData, participant == i, position == activityLabels$V2[j]) #creates a subset of the data, containing measurements for one body position of one subject. 
    condensedData[(i-1)*6 + j, 1] <- currentParticipantAndPosition$participant[1] 
    condensedData[(i-1)*6 + j, 2] <- currentParticipantAndPosition$position[1]
     for(k in 3:81){
      condensedData[(i-1)*6 + j, k] <- mean(currentParticipantAndPosition[,k])
    }
  }
}

names(condensedData) <- colNames


