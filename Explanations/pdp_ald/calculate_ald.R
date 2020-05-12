### ald ###

library(DALEX)
library(DALEXtra)
library(ingredients)

train <- read.csv("Data/TrainAndTest/train.csv")
train$waterfront <- factor(train$waterfront)
train$zipcode <- factor(train$zipcode)
train_onehot <- read.csv("Data/TrainAndTest/train_onehot.csv")

test <- read.csv("Data/TrainAndTest/test.csv")
test$waterfront <- factor(test$waterfront)
test$zipcode <- factor(test$zipcode)
test_onehot <- read.csv("Data/TrainAndTest/test_onehot.csv")

#### decision tree model ####
load("Models/PredictiveModels/mlr/decisionTree/mod_rpart.rda")
decisiontree_explain <- explain_mlr(mod_rpart, 
                                    data = test[, -21], 
                                    y = test$price_log,
                                    label = "decision tree")
ald_decisiontree <- accumulated_dependence(decisiontree_explain, center = TRUE)

save(ald_decisiontree, file = "Explanations/pdp_ald/ald_decisiontree.rda")
plot(ald_decisiontree)

#### gbm model ####
load("Models/PredictiveModels/mlr/gbm/mod_gbm.rda")
gbm_explain <- explain_mlr(mod_gbm, 
                           data = test[, -21], 
                           y = test$price_log,
                           label = "gbm")
ald_gbm <- accumulated_dependence(gbm_explain, center = TRUE)

save(ald_gbm, file = "Explanations/pdp_ald/ald_gbm.rda")
plot(ald_gbm)

#### random forest model ####
load("Models/PredictiveModels/mlr/randomforest/mod_randomforest.rda")
rf_explain <- explain_mlr(mod_randomforest, 
                          data = test[, -21], 
                          y = test$price_log,
                          label = "randomforest")
ald_rf <- accumulated_dependence(rf_explain, center = TRUE)

save(ald_rf, file = "Explanations/pdp_ald/ald_rf.rda")
plot(ald_rf)

#### xgboost model ####
load("Models/PredictiveModels/mlr/xgboost/mod_xgboost.rda")
xgb_explain <- explain_mlr(mod_xgboost, 
                           data = test[, -21], 
                           y = test$price_log,
                           label = "xgboost")
ald_xgb <- accumulated_dependence(xgb_explain, center = TRUE)

save(ald_xgb, file = "Explanations/pdp_ald/ald_xgb.rda")
plot(ald_xgb)

#### decision tree one-hot model ####
load("Models/PredictiveModels/mlr/decisionTree_onehot/mod_decisiontree_onehot.rda")
decisiontree_onehot_explain <- explain_mlr(mod_rpart_onehot, 
                                           data = test_onehot[, -20], 
                                           y = test_onehot$price_log,
                                           label = "decision tree one-hot")
ald_decisiontree_onehot <- accumulated_dependence(decisiontree_onehot_explain, center = TRUE)

save(ald_decisiontree_onehot, file = "Explanations/pdp_ald/ald_decisiontree_onehot.rda")
plot(ald_decisiontree_onehot)

#### gbm one-hot model####
load("Models/PredictiveModels/mlr/gbm_onehot/mod_gbm_onehot.rda")
gbm_onehot_explain <- explain_mlr(mod_gbm_onehot, 
                                  data = test_onehot[, -20], 
                                  y = test_onehot$price_log,
                                  label = "gbm one-hot")
ald_gbm_onehot <- accumulated_dependence(gbm_onehot_explain, center = TRUE)

save(ald_gbm_onehot, file = "Explanations/pdp_ald/ald_gbm_onehot.rda")
plot(ald_gbm_onehot)

#### random forest one-hot model ####
load("Models/PredictiveModels/mlr/randomforest_onehot/mod_randomforest_onehot.rda")
rf_onehot_explain <- explain_mlr(mod_randomforest_onehot, 
                                 data = test_onehot[, -20], 
                                 y = test_onehot$price_log,
                                 label = "randomforest one-hot")
ald_rf_onehot <- accumulated_dependence(rf_onehot_explain, center = TRUE)

save(ald_rf_onehot, file = "Explanations/pdp_ald/ald_rf_onehot.rda")
plot(ald_rf_onehot)

#### xgboost one-hot model ####
load("Models/PredictiveModels/mlr/xgboost_onehot/mod_xgboost_onehot.rda")
xgb_onehot_explain <- explain_mlr(mod_xgboost_onehot, 
                                  data = test_onehot[, -20], 
                                  y = test_onehot$price_log,
                                  label = "xgboost one-hot")
ald_xgb_onehot <- accumulated_dependence(xgb_onehot_explain, center = TRUE)

save(ald_xgb_onehot, file = "Explanations/pdp_ald/ald_xgb_onehot.rda")
plot(ald_xgb_onehot)
#### lm one-hot model ####
load("Models/PredictiveModels/mlr/lm_onehot/mod_lm_onehot.rda")
lm_onehot_explain <- explain_mlr(mod_lm_onehot, 
                                 data = test_onehot[, -20], 
                                 y = test_onehot$price_log,
                                 label = "lm one-hot")
ald_lm_onehot <- accumulated_dependence(lm_onehot_explain, center = TRUE)

save(ald_lm_onehot, file = "Explanations/pdp_ald/ald_lm_onehot.rda")
plot(ald_lm_onehot)

