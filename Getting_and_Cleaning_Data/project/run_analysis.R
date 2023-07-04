packages <- c("data.table", "reshape2")
sapply(packages, require, character.only=TRUE, quietly=TRUE)


activityLabels <- fread('activity_labels.txt',col.names = c("classLabels", "activityName"))
features <- fread('features.txt',col.names = c("index", "featureNames"))
selected_features <- grep("(mean|std)\\(\\)", features[, featureNames])
cols <- features[selected_features, featureNames]
cols <- gsub('[()]', '', cols)


train <- fread('X_train.txt')[, selected_features, with = FALSE]
data.table::setnames(train, colnames(train), cols)
train.Activities <- fread('y_train.txt', col.names = c('Activity'))
train.Subjects <- fread('subject_train.txt', col.names = c("Subject"))
train <- cbind(train.Subjects, train.Activities, train)


test <- fread('X_test.txt')[, selected_features, with = FALSE]
data.table::setnames(test, colnames(test), cols)
test.Activities <- fread('y_test.txt', col.names = c('Activity'))
test.Subjects <- fread('subject_test.txt', col.names = c("Subject"))
test <- cbind(test.Subjects, test.Activities, test)


combined.data <- rbind(train, test)


combined.data[["Activity"]] <- factor(combined.data[, Activity], levels = activityLabels[["classLabels"]], labels = activityLabels[["activityName"]])

combined.data[["Subject"]] <- as.factor(combined.data[, Subject])
combined.data <- reshape2::melt(data = combined.data, id = c("Subject", "Activity"))
combined.data <- reshape2::dcast(data = combined.data, Subject + Activity ~ variable, fun.aggregate = mean)

data.table::fwrite(x = combined.data, file = "finalData.txt", quote = FALSE)
