#######################################################################################################################
## Function run_analysis is the main function. It calls functions 
##  - read_combine_UCI_data to read the two data sets and combine same
##  - get_mean_std_UCI_data to reduce the data set to only the necessary columns
## The function then determines the average for each activity/subject combination
## Output is saved to my_tidy_data_set.txt
## Parameters: none
#######################################################################################################################
run_analysis <- function() {
	
	library(plyr)
	library(dplyr)
	
	l.directory <- "~/GitHub/datasciencecoursera/ProgrammingAssignment4/UCI HAR Dataset"
	
	##Create the combined data set
	uci_data <- read_combine_UCI_data(l.directory)
	
	##Reduce the data set to the mean and standard deviation columns
	uci_data <- get_mean_std_UCI_data(uci_data)
	
	##Summarise the data by getting the average for each activity/subject combination
	uci_avg <- aggregate(uci_data, 
						 list(act = uci_data$activity, sub = uci_data$subject),
						 mean, 
						 na.rm = TRUE)
	##Remove the extra columns
	uci_avg <- select(uci_avg, -(activity:subject))

	##Read the activity names from activity_labels.txt
	##Change to the correct work directory
	l.oldwd <- getwd()
	setwd(l.directory)
	##Read the labels
	activity_enumeration <- read.table("activity_labels.txt", nrows=6)
	##Give friendly names to the two columns
	colnames(activity_enumeration)[1] <- "act"
	colnames(activity_enumeration)[2] <- "activity"
	
	##Join the UCI averages data set with the activity labels
	uci_final <- merge(x=uci_avg, y=activity_enumeration, by="act", sort=TRUE, all.x=TRUE)
	cols = ncol(uci_final)
	##Reorder the columns, and rename the 1st two
	uci_final <- cbind(uci_final[ , cols],
					   uci_final[ , (3:cols-1)])
	colnames(uci_final)[1] <- "activity"
	colnames(uci_final)[2] <- "subject"

	##Finally write the output tidy data set
	write.csv(uci_final, "../my_tidy_data_set.csv", row.names=FALSE, col.names=TRUE)
	write.table(uci_final, "../my_tidy_data_set.txt", row.names=FALSE, col.names=TRUE)
	##Reset work directory
	setwd(l.oldwd)
}
