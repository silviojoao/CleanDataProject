Code Book
=========================================

This document describes the data and transformations used by run_analysis.R.

Data set
=========================================
This data is obtained from "Human Activity Recognition Using Smartphones Data Set".
A full description is available at the site
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

Raw Dataset
=========================================

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt' and 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

Transformations
=========================================
All inputs were transformed into data frame:

      - 'features.txt' leads to 'features'
      - 'activity_labels.txt' leads to 'activity_labels'
      - 'X_train.txt' leads to 'train_set'
      - 'y_train.txt' leads to 'train_labels'
      - 'X_test.txt' leads to 'test_set'
      - 'y_test.txt' leads to 'test_labels'
      - 'subject_train' leads to 'train_subject'
      - 'subject_test' leads to 'test_subject'

The training ('train_set') and the test ('test_set') sets merges to create one data set named:

      - 'merged_set'
      
The 'train_subject' and the 'test_subject' merges to one data frame named:
      
      -'merged_subject'
      
The 'train_labels' and the 'test_labels' merges to one data frame named:

      -'merged_labels_set'

The 'merged_set', the 'merged_subject' and the 'merged_labels_set' merges to one data set named:

      -'merged_data'
      
Extracts only the measurements on the mean and standard deviation for each measurement to a data frame named:

      -'all_data'
      
The descriptive activity names are add to 'all_data' data set in 'labels' variable:

Acronyms in variable names in 'all_data' are add to a vector named:

      -'subs_label'
      
descriptive labels are add to a vector named:

      -'final_label'
      
And using a loop function to replace the name variable in 'all_data'
Final_Dataset.txt is created as a set with average for each activity and subject of 'all_data'.