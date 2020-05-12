### pdp ###

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
pdp_decisiontree <- partial_dependence(decisiontree_explain)

save(pdp_decisiontree, file = "Explanations/pdp_ald/pdp_decisiontree.rda")
plot(pdp_decisiontree)

#### gbm model ####
load("Models/PredictiveModels/mlr/gbm/mod_gbm.rda")
gbm_explain <- explain_mlr(mod_gbm, 
                           data = test[, -21], 
                           y = test$price_log,
                           label = "gbm")
pdp_gbm <- partial_dependence(gbm_explain)

save(pdp_gbm, file = "Explanations/pdp_ald/pdp_gbm.rda")
plot(pdp_gbm)

#### random forest model ####
load("Models/PredictiveModels/mlr/randomforest/mod_randomforest.rda")
rf_explain <- explain_mlr(mod_randomforest, 
                          data = test[, -21], 
                          y = test$price_log,
                          label = "randomforest")
#pdp_rf <- partial_dependence(rf_explain)
pdp_rf_cat <- partial_dependence(rf_explain, variable_type = "categorical")

#save(pdp_rf, file = "Explanations/pdp_ald/pdp_rf.rda")
save(pdp_rf_cat, file = "../../../Desktop/pdp_ald/pdp_rf_cat.rda")
plot(pdp_rf_cat)

#### xgboost model ####
load("Models/PredictiveModels/mlr/xgboost/mod_xgboost.rda")
xgb_explain <- explain_mlr(mod_xgboost, 
                           data = test[, -21], 
                           y = test$price_log,
                           label = "xgboost")
pdp_xgb <- partial_dependence(xgb_explain)

save(pdp_xgb, file = "Explanations/pdp_ald/pdp_xgb.rda")
plot(pdp_xgb)

#### decision tree one-hot model ####
load("Models/PredictiveModels/mlr/decisionTree_onehot/mod_decisiontree_onehot.rda")
decisiontree_onehot_explain <- explain_mlr(mod_rpart_onehot, 
                                           data = test_onehot[, -20], 
                                           y = test_onehot$price_log,
                                           label = "decision tree one-hot")
pdp_decisiontree_onehot <- partial_dependence(decisiontree_onehot_explain)

save(pdp_decisiontree_onehot, file = "Explanations/pdp_ald/pdp_decisiontree_onehot.rda")
plot(pdp_decisiontree_onehot)

#### gbm one-hot model####
load("Models/PredictiveModels/mlr/gbm_onehot/mod_gbm_onehot.rda")
gbm_onehot_explain <- explain_mlr(mod_gbm_onehot, 
                                  data = test_onehot[, -20], 
                                  y = test_onehot$price_log,
                                  label = "gbm one-hot")
pdp_gbm_onehot <- partial_dependence(gbm_onehot_explain)

save(pdp_gbm_onehot, file = "Explanations/pdp_ald/pdp_gbm_onehot.rda")
plot(pdp_gbm_onehot)

#### random forest one-hot model ####
load("Models/PredictiveModels/mlr/randomforest_onehot/mod_randomforest_onehot.rda")
rf_onehot_explain <- explain_mlr(mod_randomforest_onehot, 
                                 data = test_onehot[, -20], 
                                 y = test_onehot$price_log,
                                 label = "randomforest one-hot")
pdp_rf_onehot <- partial_dependence(rf_onehot_explain)

save(pdp_rf_onehot, file = "Explanations/pdp_ald/pdp_rf_onehot.rda")
plot(pdp_rf_onehot)

#### xgboost one-hot model ####
load("Models/PredictiveModels/mlr/xgboost_onehot/mod_xgboost_onehot.rda")
xgb_onehot_explain <- explain_mlr(mod_xgboost_onehot, 
                                  data = test_onehot[, -20], 
                                  y = test_onehot$price_log,
                                  label = "xgboost one-hot")
pdp_xgb_onehot <- partial_dependence(xgb_onehot_explain)

save(pdp_xgb_onehot, file = "Explanations/pdp_ald/pdp_xgb_onehot.rda")
plot(pdp_xgb_onehot)
#### lm one-hot model ####
load("Models/PredictiveModels/mlr/lm_onehot/mod_lm_onehot.rda")
lm_onehot_explain <- explain_mlr(mod_lm_onehot, 
                                 data = test_onehot[, -20], 
                                 y = test_onehot$price_log,
                                 label = "lm one-hot")
pdp_lm_onehot <- partial_dependence(lm_onehot_explain)

save(pdp_lm_onehot, file = "Explanations/pdp_ald/pdp_lm_onehot.rda")
plot(pdp_lm_onehot)

