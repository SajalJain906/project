train_data <- read.table("./data/train/x_train.txt")
train_label <- read.table("./data/train/y_train.txt")
train_subject <- read.table("./data/train/subject_train.txt")

test_label <- read.table("./data/test/y_test.txt")
test_subject <- read.table("./data/test/subject_test.txt")
test_data <- read.table("./data/test/x_test.txt")

x <- rbind(train_data,test_data)
y <- rbind(train_label,test_label)
subject <- rbind(train_subject,test_subject)

features <- read.table("./data/features.txt")
colnames(x) <- features[,2]

var <- grepl("-mean|-std",names(x))
x_new <- x[,var]

activities <- read.table("./data/activity_labels.txt")
y_named <- factor(y$V1,levels <- c(1,2,3,4,5,6),labels <- activities$V2)
subject <- factor(subject$V1)

new_dataset <- aggregate(x_new,list(subject,y_named),mean)
colnames(new_dataset)[1:2] <- c("subject","activity")