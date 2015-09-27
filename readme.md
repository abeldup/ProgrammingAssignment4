---
title: "README"
author: "Abel du Plessis"
date: "September 26, 2015"
output: html_document
---

# Approach
The training and test data sets were both read (from X_train.txt and X_test.txt), and enriched by  
* binding with the activity for each observation (from Y_train.txt and Y_test.txt)    
* binding with the subject for each observation (from subject_train.txt and subject_test.txt)  
* supplying the measurements with column names (from features.txt)  
The two data sets were combined into one.  
   
The combined data set were reduced to only the columns that contain "mean" or "std".  
   
This reduced data set were summarised by getting the arithmic mean (average) of each measurement for 
each activity and subject.   

The summarised data set were enhanced by giving friendly names to the activities (from activity_labels.txt).   
Lastly the final data set is saved to my_tidy_data_set.txt.   

# Scripts
read_combine_UCI_HAR_data.R  
get_mean_std_UCI_HAR_data.R  
run_analysis.R  

## read_combine_UCI_HAR_data.R
Function read_combine_UCI_data performs the following  
 - reads the UCI HAR training and test data  
 - binds these data sets with the activity and subject data for each observation  
 - adds a column marking the data set as train or test  
 - binds the two data sets into one  
The function returns the combined data set  
Parameters: p.directory = the root directory of the UCI HAR data  

## get_mean_std_UCI_HAR_data.R
Function get_mean_std_UCI_data performs the following   
 - subsets the data to only the columns that contain "mean" or "std" in the column name  
 - adds back the subject and activity columns (with friendly names)  
 - orders the data by subject then activity number  
The function returns the ordered and reduced data set  
Parameters: p.alldata = the combined UCI HAR data set  

## run_analysis.R
Function run_analysis is the main function. It calls functions  
 - read_combine_UCI_data to read the two data sets and combine same  
 - get_mean_std_UCI_data to reduce the data set to only the necessary columns  
The function then determines the average for each activity/subject combination  
Output is saved to my_tidy_data_set.txt  
Parameters: none   

