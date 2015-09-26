#######################################################################################################################
## Function get_mean_std_UCI_data performs the following 
##  - subsets the data to only the columns that contain "mean" or "std" in the column name
##  - adds back the subject and activity columns (with friendly names)
##  - orders the data by subject then activity number
## The function returns the ordered and reduced data set
## Parameters: p.alldata = the combined UCI HAR data set
#######################################################################################################################
get_mean_std_UCI_data <- function(p.alldata) {
	
	##Create new data set by subsetting the columns where the name contains "mean" or "std"
	uci_mean_std <- cbind(p.alldata$activity_number, 
						  p.alldata$subject_number, 
						  p.alldata[ , grepl( "mean|std", names(p.alldata))])
	
	##Give friendly names to 1st two columns
	colnames(uci_mean_std)[1] <- "activity"
	colnames(uci_mean_std)[2] <- "subject"
	
	return(uci_mean_std)
}
