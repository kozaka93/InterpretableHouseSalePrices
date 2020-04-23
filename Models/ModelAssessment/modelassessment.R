#### Model assessment ####

## library 
library(mlr)
library(ranger)
library(gbm)
library(xgboost)
library(auditor)
library(DALEX)
library(DALEXtra)

## load data
train <- read.csv("Data/TrainAndTest/train.csv")
test <- read.csv("Data/TrainAndTest/test.csv")

#### randomforest model ####

## load model
load("Models/PredictiveModels/mlr/randomforest/mod_randomforest.rda")



## create explain object  
rf_explain_train <- DALEXtra::explain_mlr(model = mod_randomforest, 
                                                      data = train, 
                                                      y = train$price_log, 
                                                      label = "randomforest")

rf_explain_test <- DALEXtra::explain_mlr(model = mod_randomforest, 
                                                     data = test, 
                                                     y = test$price_log,
                                                     label = "randomforest")

## rmse score
model_performance(rf_explain_train, score = "rmse")
model_performance(rf_explain_test, score = "rmse")

## residual
rf_residual_train <- plot(model_residual(rf_explain_train), type = "prediction")
rf_residual_test <- plot(model_residual(rf_explain_test), type = "prediction")


#### gbm model ####

## load model
load("Models/PredictiveModels/mlr/gbm/mod_gbm.rda")

## create explain object  
gbm_explain_train <- DALEXtra::explain_mlr(model = mod_gbm, 
                                                      data = train, 
                                                      y = train$price_log, 
                                                      label = "gbm")

gbm_explain_test <- DALEXtra::explain_mlr(model = mod_gbm, 
                                                     data = test, 
                                                     y = test$price_log,
                                                     label = "gbm")

## rmse score
model_performance(gbm_explain_train, score = "rmse")
model_performance(gbm_explain_test, score = "rmse")

## residual
gbm_residual_train <- plot(model_residual(gbm_explain_train), type = "prediction")
gbm_residual_test <- plot(model_residual(gbm_explain_test), type = "prediction")


#### xgboost model ####

## load model
load("Models/PredictiveModels/mlr/xgboost/mod_xgboost.rda")

## create explain object  
xgboost_explain_train <- DALEXtra::explain_mlr(model = mod_xgboost, 
                                           data = train, 
                                           y = train$price_log, 
                                           label = "xgboost")

xgboost_explain_test <- DALEXtra::explain_mlr(model = mod_xgboost, 
                                          data = test, 
                                          y = test$price_log,
                                          label = "xgboost")

## rmse score
model_performance(xgboost_explain_train, score = "rmse")
model_performance(xgboost_explain_test, score = "rmse")

## residual
xgboost_residual_train <- plot(model_residual(xgboost_explain_train), type = "prediction")
xgboost_residual_test <- plot(model_residual(xgboost_explain_test), type = "prediction")


#### decision tree model ####

## load model
load("Models/PredictiveModels/mlr/decisionTree/mod_rpart.rda")



## create explain object  
train$waterfront <- factor(train$waterfront)
test$waterfront <- factor(test$waterfront)
train$zipcode <- factor(train$zipcode)
test$zipcode <- factor(test$zipcode)
dt_explain_train <- DALEXtra::explain_mlr(model = mod_rpart, 
                                          data = train, 
                                          y = train$price_log, 
                                          label = "decision tree")

dt_explain_test <- DALEXtra::explain_mlr(model = mod_rpart, 
                                         data = test, 
                                         y = test$price_log,
                                         label = "decision tree")

## rmse score
model_performance(dt_explain_train, score = "rmse")
model_performance(dt_explain_test, score = "rmse")

## residual
dt_residual_train <- plot(model_residual(dt_explain_train), type = "prediction")
dt_residual_test <- plot(model_residual(dt_explain_test), type = "prediction")



## plots
plot(model_residual(rf_explain_test), model_residual(gbm_explain_test), model_residual(xgboost_explain_test), model_residual(dt_explain_test), type = "residual_density")

plot(model_residual(rf_explain_test), model_residual(gbm_explain_test), model_residual(xgboost_explain_test), model_residual(dt_explain_test), type = "residual_boxplot")
