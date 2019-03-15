# CodeBook

## Files and Methods used to process the dataframe

The code available in run_analysis.R is generating a tidy dataframe named 'grouped_mean.txt' from mean of available features grouped by subject and activity.

First all of the train and test files is imported into dataframes.
add to that there are two are text files that address the activities and subject people. We want to group the dataset according to them. The steps of cleaning data is as follow:

1. combining train and test sets using dplyr::bind_rows function for all the features and subjects

2. Changing the varible names from the features dataframe and then selecting columns with mean or std available in them. For this step I used matches function with regular expression argument 'mean|std'

3. Combining the activity dataframe with the target y in order to make the names descriptive instead of numbers.

4. using chained group_by and summarise on the final dataframe and make a new tidy dataframe including means of grouped features.
