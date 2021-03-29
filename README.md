# MotionSensorTidyDataProject
R script to create a tidy data set for Final Project of Getting and Cleaning Data Course

The directory contains the following files and folder:

- activity_data_tidy.txt : the tidy data set produced by the analysis
- codebook.txt : description of tidy data set produced by the analysis
- run_analysis.R : the R script that transforms the raw data to tidy data
- UCI HAR Dataset/ : folder containing all of the original raw data provided for the project

The run_analysis.R script performs the following processing of the raw data:

1. Merge the 561 training and test variables and extract only the variables pertaining to mean() and std() calculations.
2. Combine the variable data with the test subject number (1-30) and activity code number (1-6).
3. Find the average for each mean and std variable for every unique combination of subject-activity pairings.
