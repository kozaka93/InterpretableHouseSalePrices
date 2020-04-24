#### xgboost model ####

## library 
library(mlr)
library(xgboost)

## load train and test set
train <- read.csv("Data/TrainAndTest/train_onehot.csv")
test <- read.csv("Data/TrainAndTest/test_onehot.csv")

## selection of parameters for the xgboost model based on the rmse metric
## on the training set
tsk <- makeRegrTask(data = train, target = "price_log")
ps <- makeParamSet(
  makeIntegerParam("nrounds", lower = 100, upper = 500),
  makeIntegerParam("max_depth", lower = 1, upper = 10),
  makeNumericParam("eta", lower = .1, upper = .5),
  makeNumericParam("lambda", lower = -1, upper = 0, trafo = function(x) 10^x)
)

ctrl <- makeTuneControlRandom(maxit = 100L)
rdesc <- makeResampleDesc("CV", iters = 3L)
res <- tuneParams("regr.xgboost", 
                  task = tsk, 
                  resampling = rdesc,
                  par.set = ps, 
                  control = ctrl, 
                  measures = rmse)
lrn <- setHyperPars(makeLearner("regr.xgboost"), 
                    par.vals = res$x)


## Trenowanie modelu
mod_xgboost_onehot <- train(lrn, tsk)


## session info
# R version 3.6.3 (2020-02-29)
# 
# attached base packages:
# [1] stats     graphics  grDevices utils     datasets  methods   base     
# 
# other attached packages:
# [1] DALEXtra_0.2.1    DALEX_1.0.1  xgboost_1.0.0.2    mlr_2.17.0  ParamHelpers_1.13
