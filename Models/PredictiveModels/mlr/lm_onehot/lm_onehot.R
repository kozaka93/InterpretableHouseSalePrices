#### lm one-hot model ####

## library 
library(mlr)
library(rpart)
library(DALEX)
library(DALEXtra)
library(caret)
## load train and test set
train <- read.csv("Data/TrainAndTest/train_onehot.csv")
test <- read.csv("Data/TrainAndTest/test_onehot.csv")

## selection of parameters for the lm model based on the rmse metric
## on the training set
tsk <- makeRegrTask(data = train, target = "price_log")
lrn <- makeLearner("regr.lm")

mod_lm_onehot <- train(lrn, tsk)


## session info
# R version 3.6.3 (2020-02-29)
# 
# attached base packages:
# [1] stats     graphics  grDevices utils     datasets  methods   base     
# 
# other attached packages:
# [1] DALEXtra_0.2.1    DALEX_1.0.1  mlr_2.17.0  ParamHelpers_1.13
