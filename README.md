# Tidy Data project

Download this dataset and save it in folder named "data" in the working directory.

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Loading the data

This dataset has two folders inside it: Test and train. We will load various tables in it using read.table function.

<code> train_data <- read.table("./data/train/x_train.txt")</code>

<code> train_label <- read.table("./data/train/y_train.txt")</code>

<code> train_subject <- read.table("./data/train/subject_train.txt")</code>

<code> test_label <- read.table("./data/test/y_test.txt")</code>

<code> test_subject <- read.table("./data/test/subject_test.txt")</code>

<code> test_data <- read.table("./data/test/x_test.txt") </code>

## Merging train and test data

rbind function adds data frames by adding extra rows

<code> x <- rbind(train_data,test_data)</code>

<code>y <- rbind(train_label,test_label)</code>

<code>subject <- rbind(train_subject,test_subject) </code>

## Using features name to subset merged data

The data frames have column names like V1, V2, .....
We will get feature names to make column names insightful.


<code> features <- read.table("./data/features.txt")</code>

<code>colnames(x) <- features[,2] </code>

## Subsetting means and standard deviation columns only

we will use the names of columns to subset only those columns with have "-mean" or "-std" in their names.

<code> var <- grepl("-mean|-std",names(x))</code>

<code>x_new <- x[,var] </code>

## Further operations

get the names of activities.

<code> activities <- read.table("./data/activity_labels.txt")  </code>

create activity and subject into factor variables

<code> y_named <- factor(y$V1,levels <- c(1,2,3,4,5,6),labels <- activities$V2</code>

<code>subject <- factor(subject$V1) </code>

take the mean by given factor variables by listing them together and using aggregate function

<code>new_dataset <- aggregate(x_new,list(subject,y_named),mean)</code>

setting group names instead of Group.1 and Group.2

<code> colnames(new_dataset)[1:2] <- c("subject","activity") </code>

## saving the new data frame as a text file

<code>write.table(new_dataset,file="new_dataset.txt",row.names = FALSE)</code>

