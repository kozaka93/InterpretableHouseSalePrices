### one-hot encoding ###

## library 
library(caret)

## load train and test set
train <- read.csv("Data/TrainAndTest/train.csv")
test <- read.csv("Data/TrainAndTest/test.csv")
train$zipcode <- factor(train$zipcode)
test$zipcode <- factor(test$zipcode)


## one-hot encoding for zipcode variable
zipcode_onehot_train <- model.matrix(~zipcode, train)
zipcode_onehot_test <- model.matrix(~zipcode, test)

train <- train[, -8]
test <- test[, -8]
train <- data.frame(train, zipcode_onehot_train[, -1])
test <- data.frame(test, zipcode_onehot_test[, -1])

write.csv(train, file = "Data/TrainAndTest/train_onehot.csv")
write.csv(test, file = "Data/TrainAndTest/test_onehot.csv")