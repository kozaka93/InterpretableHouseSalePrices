#### random forest model ####

## library 
library(mlr)
library(ranger)
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

## selection of parameters for the random forest model based on the rmse metric
## on the training set
tsk <- makeRegrTask(data = train, target = "price_log")
ps <- makeParamSet(
  makeIntegerParam("num.trees", lower = 50, upper = 1000),
  makeIntegerParam("mtry", lower = 1, upper = 4),
  makeIntegerLearnerParam("min.node.size", lower = 1, upper = 100))

ctrl <- makeTuneControlRandom(maxit = 100L)
rdesc <- makeResampleDesc("CV", iters = 3L)
res <- tuneParams("regr.ranger", 
                  task = tsk, 
                  resampling = rdesc,
                  par.set = ps, 
                  control = ctrl, 
                  measures = rmse)
lrn <- setHyperPars(makeLearner("regr.ranger"), 
                    num.trees = res$x$num.trees, 
                    mtry = res$x$mtry,
                    min.node.size = res$x$min.node.size)


## model
mod_randomforest <- train(lrn, tsk)

## session info
# R version 3.6.3 (2020-02-29)
# 
# attached base packages:
# [1] stats     graphics  grDevices utils     datasets  methods   base     
# 
# other attached packages:
# [1] DALEXtra_0.2.1    DALEX_1.0.1 ranger_0.12.1     mlr_2.17.0  ParamHelpers_1.13
