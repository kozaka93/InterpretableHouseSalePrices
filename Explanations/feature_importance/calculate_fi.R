### feature importance ###

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
fi_decisiontree <- model_parts(decisiontree_explain, 
                            loss_function = loss_root_mean_square,
                            n_sample = nrow(test))

save(fi_decisiontree, file = "Explanations/feature_importance/fi_decisiontree.rda")
plot(fi_decisiontree)

#### gbm model ####
load("Models/PredictiveModels/mlr/gbm/mod_gbm.rda")
gbm_explain <- explain_mlr(mod_gbm, 
                          data = test[, -21], 
                          y = test$price_log,
                          label = "gbm")
fi_gbm <- model_parts(gbm_explain, 
                      loss_function = loss_root_mean_square,
                       n_sample = nrow(test))

save(fi_gbm, file = "Explanations/feature_importance/fi_gbm.rda")
plot(fi_gbm)

#### random forest model ####
load("Models/PredictiveModels/mlr/randomforest/mod_randomforest.rda")
rf_explain <- explain_mlr(mod_randomforest, 
                           data = test[, -21], 
                           y = test$price_log,
                           label = "randomforest")
fi_rf <- model_parts(rf_explain, 
                      loss_function = loss_root_mean_square,
                      n_sample = nrow(test))

save(fi_rf, file = "Explanations/feature_importance/fi_rf.rda")
plot(fi_rf)

#### xgboost model ####
load("Models/PredictiveModels/mlr/xgboost/mod_xgboost.rda")
xgb_explain <- explain_mlr(mod_xgboost, 
                          data = test[, -21], 
                          y = test$price_log,
                          label = "xgboost")
fi_xgb <- model_parts(xgb_explain, 
                     loss_function = loss_root_mean_square,
                     n_sample = nrow(test))

save(fi_xgb, file = "Explanations/feature_importance/fi_xgb.rda")
plot(fi_xgb)

#### decision tree one-hot model ####
load("Models/PredictiveModels/mlr/decisionTree_onehot/mod_decisiontree_onehot.rda")
decisiontree_onehot_explain <- explain_mlr(mod_rpart_onehot, 
                                    data = test_onehot[, -20], 
                                    y = test_onehot$price_log,
                                    label = "decision tree one-hot")
fi_decisiontree_onehot <- model_parts(decisiontree_onehot_explain, 
                               loss_function = loss_root_mean_square,
                               n_sample = nrow(test_onehot))

save(fi_decisiontree_onehot, file = "Explanations/feature_importance/fi_decisiontree_onehot.rda")
plot(fi_decisiontree_onehot)

#### gbm one-hot model####
load("Models/PredictiveModels/mlr/gbm_onehot/mod_gbm_onehot.rda")
gbm_onehot_explain <- explain_mlr(mod_gbm_onehot, 
                           data = test_onehot[, -20], 
                           y = test_onehot$price_log,
                           label = "gbm one-hot")
fi_gbm_onehot <- model_parts(gbm_onehot_explain, 
                      loss_function = loss_root_mean_square,
                      n_sample = nrow(test_onehot))

save(fi_gbm_onehot, file = "Explanations/feature_importance/fi_gbm_onehot.rda")
plot(fi_gbm_onehot)

#### random forest one-hot model ####
load("Models/PredictiveModels/mlr/randomforest_onehot/mod_randomforest_onehot.rda")
rf_onehot_explain <- explain_mlr(mod_randomforest_onehot, 
                          data = test_onehot[, -20], 
                          y = test_onehot$price_log,
                          label = "randomforest one-hot")
fi_rf_onehot <- model_parts(rf_onehot_explain, 
                     loss_function = loss_root_mean_square,
                     n_sample = nrow(test_onehot))

save(fi_rf_onehot, file = "Explanations/feature_importance/fi_rf_onehot.rda")
plot(fi_rf_onehot)

#### xgboost one-hot model ####
load("Models/PredictiveModels/mlr/xgboost_onehot/mod_xgboost_onehot.rda")
xgb_onehot_explain <- explain_mlr(mod_xgboost_onehot, 
                           data = test_onehot[, -20], 
                           y = test_onehot$price_log,
                           label = "xgboost one-hot")
fi_xgb_onehot <- model_parts(xgb_onehot_explain, 
                      loss_function = loss_root_mean_square,
                        n_sample = nrow(test_onehot))

save(fi_xgb_onehot, file = "Explanations/feature_importance/fi_xgb_onehot.rda")
plot(fi_xgb_onehot)
#### lm one-hot model ####
load("Models/PredictiveModels/mlr/lm_onehot/mod_lm_onehot.rda")
lm_onehot_explain <- explain_mlr(mod_lm_onehot, 
                                  data = test_onehot[, -20], 
                                  y = test_onehot$price_log,
                                  label = "lm one-hot")
fi_lm_onehot <- model_parts(lm_onehot_explain, 
                             loss_function = loss_root_mean_square,
                             n_sample = nrow(test_onehot))

save(fi_lm_onehot, file = "Explanations/feature_importance/fi_lm_onehot.rda")
plot(fi_lm_onehot)



plot(fi_decisiontree, fi_gbm, fi_rf, fi_xgb, max_vars = 5)
plot(fi_decisiontree_onehot, fi_gbm_onehot, fi_rf_onehot, fi_xgb_onehot, fi_lm_onehot, max_vars = 5)
plot(fi_decisiontree, fi_gbm, fi_rf, fi_xgb, fi_decisiontree_onehot, fi_gbm_onehot, fi_rf_onehot, fi_xgb_onehot, fi_lm_onehot, max_vars = 5)
