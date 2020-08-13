# read the data from the files

train_data <- read.table("./data/train/x_train.txt")
train_label <- read.table("./data/train/y_train.txt")
train_subject <- read.table("./data/train/subject_train.txt")

test_label <- read.table("./data/test/y_test.txt")
test_subject <- read.table("./data/test/subject_test.txt")
test_data <- read.table("./data/test/x_test.txt")

#merge train and test dataframes by adding extra rows

x <- rbind(train_data,test_data)
y <- rbind(train_label,test_label)
subject <- rbind(train_subject,test_subject)

# get the names of features and make it the column name in the new data frame

features <- read.table("./data/features.txt")
colnames(x) <- features[,2]

# choose only those columns which are either mean or std

var <- grepl("-mean|-std",names(x))
x_new <- x[,var]

#get the names of activities.

activities <- read.table("./data/activity_labels.txt")

# create activity and subject into factor variables

y_named <- factor(y$V1,levels <- c(1,2,3,4,5,6),labels <- activities$V2)
subject <- factor(subject$V1)

# take the mean by given factor variables by listing them together and using aggregate function

new_dataset <- aggregate(x_new,list(subject,y_named),mean)

# setting group names instead of Group.1 and Group.2

colnames(new_dataset)[1:2] <- c("subject","activity")

#saving the new data frame as a text file

write.table(new_dataset,file="new_dataset.txt",row.names = FALSE)