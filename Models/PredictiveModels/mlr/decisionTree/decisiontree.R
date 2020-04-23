#### decision tree model ####

## library 
library(mlr)
library(rpart)
library(DALEX)
library(DALEXtra)

## load train and test set
train <- read.csv("Data/TrainAndTest/train.csv")
test <- read.csv("Data/TrainAndTest/test.csv")

## change numeric to factor for waterfront and zipcode
train$waterfront <- factor(train$waterfront)
test$waterfront <- factor(test$waterfront)
train$zipcode <- factor(train$zipcode)
test$zipcode <- factor(test$zipcode)

## selection of parameters for the decision tree model based on the rmse metric
## on the training set
tsk <- makeRegrTask(data = train, target = "price_log")
ps <- makeParamSet(
  makeIntegerLearnerParam(id = "minsplit", upper = 40L, lower = 1L),
  makeIntegerLearnerParam(id = "minbucket", upper = 25, lower = 1L),
  makeNumericLearnerParam(id = "cp", lower = 0, upper = 0.5))

ctrl <- makeTuneControlRandom(maxit = 100L)
rdesc <- makeResampleDesc("CV", iters = 3L)
res <- tuneParams("regr.rpart", 
                  task = tsk, 
                  resampling = rdesc,
                  par.set = ps, 
                  control = ctrl, 
                  measures = rmse)
lrn <- setHyperPars(makeLearner("regr.rpart"), 
                    par.vals = res$x)


## model
mod_rpart <- train(lrn, tsk)

## session info
# R version 3.6.3 (2020-02-29)
# 
# attached base packages:
# [1] stats     graphics  grDevices utils     datasets  methods   base     
# 
# other attached packages:
# [1] DALEXtra_0.2.1    DALEX_1.0.1  rpart_4.1-15     mlr_2.17.0  ParamHelpers_1.13
