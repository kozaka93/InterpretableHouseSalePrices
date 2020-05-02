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

linear_data <- function(data){
  data$m2_above_log <- log(data$m2_above)
  data$m2_basement_log <- log(data$m2_basement)
  data$m2_lot_log <- log(data$m2_lot)
  data$m2_living15_log <- log(data$m2_living15)
  data$m2_lot15_log <- log(data$m2_lot15)
  data$m2_basement_log[data$m2_basement == 0] <- 0
  data$dist_stop_km <- data$dist_stop/1000
  data
}
train <- read.csv("Data/TrainAndTest/train.csv")
test <- read.csv("Data/TrainAndTest/test.csv")
train_onehot <- read.csv("Data/TrainAndTest/train_onehot.csv")
test_onehot <- read.csv("Data/TrainAndTest/test_onehot.csv")
train_linear <- linear_data(train)
test_linear <- linear_data(test)
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


#### xgboost onehot ####

## load model
load("Models/PredictiveModels/mlr/xgboost_onehot/mod_xgboost_onehot.rda")



xgb_onehot_explain_train <- DALEXtra::explain_mlr(model = mod_xgboost_onehot, 
                                                  data = train_onehot, 
                                                  y = train_onehot$price_log, 
                                                  label = "xgboost one-hot")

xgb_onehot_explain_test <- DALEXtra::explain_mlr(model = mod_xgboost_onehot, 
                                                 data = test_onehot, 
                                                 y = test_onehot$price_log,
                                                 label = "xgboost one-hot")

## rmse score
model_performance(xgb_onehot_explain_train, score = "rmse")
model_performance(xgb_onehot_explain_test, score = "rmse")



#### gbm onehot ####

## load model
load("Models/PredictiveModels/mlr/gbm_onehot/mod_gbm_onehot.rda")


gbm_onehot_explain_train <- DALEXtra::explain_mlr(model = mod_gbm_onehot, 
                                                  data = train_onehot, 
                                                  y = train_onehot$price_log, 
                                                  label = "gbm one-hot")

gbm_onehot_explain_test <- DALEXtra::explain_mlr(model = mod_gbm_onehot, 
                                                 data = test_onehot, 
                                                 y = test_onehot$price_log,
                                                 label = "gbm one-hot")

## rmse score
model_performance(gbm_onehot_explain_train, score = "rmse")

model_performance(gbm_onehot_explain_test, score = "rmse")

#### randomforest_onehot ###

load("Models/PredictiveModels/mlr/randomforest_onehot/mod_randomforest_onehot.rda")
rf_onehot_explain_train <- DALEXtra::explain_mlr(model = mod_randomforest_onehot, 
                                                 data = train_onehot, 
                                                 y = train_onehot$price_log, 
                                                 label = "randomforest one-hot")

rf_onehot_explain_test <- DALEXtra::explain_mlr(model = mod_randomforest_onehot, 
                                                data = test_onehot, 
                                                y = test_onehot$price_log,
                                                label = "randomforest one-hot")

## rmse score
model_performance(rf_onehot_explain_train, score = "rmse")
model_performance(rf_onehot_explain_test, score = "rmse")


#### decision tree one hot ####
load("Models/PredictiveModels/mlr/decisionTree_onehot/mod_decisiontree_onehot.rda")

dt_onehot_explain_train <- DALEXtra::explain_mlr(model = mod_rpart_onehot, 
                                                 data = train_onehot, 
                                                 y = train_onehot$price_log, 
                                                 label = "decision tree one-hot")

dt_onehot_explain_test <- DALEXtra::explain_mlr(model = mod_rpart_onehot, 
                                                data = test_onehot, 
                                                y = test_onehot$price_log,
                                                label = "decision tree one-hot")

## rmse score
model_performance(dt_onehot_explain_train, score = "rmse")
model_performance(dt_onehot_explain_test, score = "rmse")


#### lm log-log ####
load("Models/PredictiveModels/LinearModels/Model1.rda")

lm_log_explain_train <- DALEX::explain(model = Model1, 
                                       data = train_linear,
                                       y = train_linear$price_log,
                                       label = "lm log-log")

lm_log_explain_test <- DALEX::explain(model = Model1, 
                                       data = test_linear,
                                       y = test_linear$price_log,
                                       label = "lm log-log")
## rmse score
model_performance(lm_log_explain_train, score = "rmse")
model_performance(lm_log_explain_test, score = "rmse")

#### lm log-log ####
load("Models/PredictiveModels/LinearModels/Model2.rda")

lm_zipcode_explain_train <- DALEX::explain(model = Model2, 
                                       data = train_linear,
                                       y = train_linear$price_log,
                                       label = "lm zipcode")

lm_zipcode_explain_test <- DALEX::explain(model = Model2, 
                                      data = test_linear,
                                      y = test_linear$price_log,
                                      label = "lm zipcode")
## rmse score
model_performance(lm_zipcode_explain_train, score = "rmse")
model_performance(lm_zipcode_explain_test, score = "rmse") 

#### lm log-log ####
load("Models/PredictiveModels/LinearModels/Model3.rda")

lm_random_explain_train <- DALEX::explain(model = Model3, 
                                           data = train_linear,
                                           y = train_linear$price_log,
                                           label = "lm random")

lm_random_explain_test <- DALEX::explain(model = Model3, 
                                          data = test_linear,
                                          y = test_linear$price_log,
                                          label = "lm random")
## rmse score
model_performance(lm_random_explain_train, score = "rmse")
model_performance(lm_random_explain_test, score = "rmse")

## plots

plot(model_residual(rf_explain_test), model_residual(gbm_explain_test), model_residual(xgboost_explain_test), model_residual(dt_explain_test), type = "residual_density")

plot(model_residual(rf_explain_test), model_residual(gbm_explain_test), model_residual(xgboost_explain_test), model_residual(dt_explain_test), type = "residual_boxplot")

