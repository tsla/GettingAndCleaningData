# Running analysis on data in "getwd()/UCI HAR Dataset/" directory
# Return tidy data: set with the average of each variable for each activity and each subject.

run_analysis <- function()
{
  # Set data: x_merged
  x_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
  x_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
  x_merged <- rbind(x_train, x_test)
  rm(x_train, x_test)
  
  # Labels data: y_merged
  y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
  y_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
  y_merged <- rbind(y_train, y_test)
  rm(y_train, y_test)
  
  
  # Filter std and mean
  features <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
  x_merged <- x_merged[,grep("mean\\(\\)|std\\(\\)", features$V2)]
  
  # Set columns name
  names <- features[grep("mean\\(\\)|std\\(\\)", features$V2), "V2"]
  colnames(x_merged) <- names
  rm(features, names)
  
  
  # Append Activities column
  x_merged[,"Activities"] <- y_merged
  rm(y_merged)
  
  # Get subject
  test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
  train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
  subject <- rbind(train_subject, test_subject)
  rm(test_subject, train_subject)
  
  # Append Subject column
  x_merged[,"Subject"] <- subject
  rm(subject)
  
  
  # Tidy data, average for each variable for Activity and Subject
  x_merged <- aggregate(x_merged, by = list("Subject" = x_merged$Subject, "Activities" = x_merged$Activities), mean, na.action = na.pass)
  
  # Remove duplicate two columns
  x_merged <- x_merged[,-c(ncol(x_merged), (ncol(x_merged) - 1))]
  
  
  # Map activity number to activity name
  labels <- read.table("UCI HAR Dataset/activity_labels.txt")
  
  for (i in labels$V1)
    x_merged[x_merged$Activities == i, "Activities"] <- as.character(labels$V2[i])
  rm(labels)
  
  return(x_merged)
}