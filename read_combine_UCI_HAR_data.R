#######################################################################################################################
## Function read_combine_UCI_data performs the following 
##  - reads the UCI HAR training and test data
##  - binds these data sets with the activity and subject data for each observation
##  - adds a column marking the data set as train or test
##  - binds the two data sets into one
## The function returns the combined data set
## Parameters: p.directory = the root directory of the UCI HAR data
#######################################################################################################################
read_combine_UCI_data <- function(p.directory) {
	
	##Change to the correct work directory
	l.oldwd <- getwd()
	setwd(p.directory)
	
	##Read the observation column names
	features <- read.table("features.txt", nrows = 561)
	
	##Read the activity for each training observation
	activity_train <- read.table("train/Y_train.txt", nrows=-1)
	colnames(activity_train)[1] <- "activity_number"
	
	##Read the subject (person) who performed the activity for each training observation
	subject_train <- read.table("train/subject_train.txt", nrows=-1)
	colnames(subject_train)[1] <- "subject_number"
	
	##Read the training observation data
	data_train <- read.table("train/X_train.txt", nrows=-1)
	colnames(data_train) <- features$V2
	
	##Combine activity, subject and observation training data
	data_train <- cbind(subject_train, activity_train, data_train)
	data_train$set <- "train"
	
	##Read the activity for each test observation
	activity_test <- read.table("test/Y_test.txt", nrows=-1)
	colnames(activity_test)[1] <- "activity_number"
	
	##Read the subject (person) who performed the activity for each test observation
	subject_test <- read.table("test/subject_test.txt", nrows=-1)
	colnames(subject_test)[1] <- "subject_number"
	
	##Read the test observation data
	data_test <- read.table("test/X_test.txt", nrows=-1)
	colnames(data_test) <- features$V2
	
	##Combine activity, subject and observation test data
	data_test <- cbind(subject_test, activity_test, data_test)
	data_test$set <- "test"
	
	setwd(l.oldwd)
	
	##Combine the training and test sets of data
	return(rbind(data_train, data_test))
}