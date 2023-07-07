# Getting and Cleaning Data Final Project

Author: Joanna Wang

### Description
Information about the variables, the data, and any transformations or work that performed to clean up the data for the project of this course.

### Data
Refer to http://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones 

### Variable
For each record: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

### Data pre-processing
1. read in activity label data file, features data file with column name c("classLabels", "activityName")
2. selected from features data file only the wanted features and change the naming format
3. read in x train data file, keep only the wanted features, change the name
4. read in y train data file, give name c('Activity')
5. read in subject data file
6. combine x, y, and subject together horizontally
7. repeat the steps on test data files
8. combine train and test vertically
9. create label on activity name, class label and aggregate using mean function
