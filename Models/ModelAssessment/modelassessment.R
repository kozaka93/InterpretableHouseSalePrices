#### Model assessment ####

## library 
library(mlr)
library(ranger)
library(auditor)
library(DALEX)
library(DALEXtra)

## randomforest model

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

# plot(rf_mr, lm_mr, type = "prediction", abline = TRUE)
# plot(rf_mr, lm_mr, type = "residual_density")
# plot(lm_mr, rf_mr, type = "residual_boxplot")

## gbm model

## load model
load("Models/PredictiveModels/mlr/gbm/mod_gbm.rda")

## create explain object  
gbm_explain_train <- DALEXtra::explain_mlr(model = mod_gbm, 
                                                      data = train, 
                                                      y = train$price_log, 
                                                      label = "randomforest")

gbm_explain_test <- DALEXtra::explain_mlr(model = gbm, 
                                                     data = test, 
                                                     y = test$price_log,
                                                     label = "randomforest")

## rmse score
model_performance(gbm_explain_train, score = "rmse")
model_performance(gbm_explain_test, score = "rmse")

## residual
rf_residual_train <- plot(model_residual(gbm_explain_train), type = "prediction")
rf_residual_test <- plot(model_residual(gbm_explain_test), type = "prediction")

# plot(rf_mr, lm_mr, type = "prediction", abline = TRUE)
# plot(rf_mr, lm_mr, type = "residual_density")
# plot(lm_mr, rf_mr, type = "residual_boxplot")
