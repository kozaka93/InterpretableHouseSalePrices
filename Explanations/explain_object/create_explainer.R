library(mlr)
library(DALEX)
library(DALEXtra)
library(xgboost)


load("Models/PredictiveModels/mlr/xgboost_onehot/mod_xgboost_onehot.rda")
load("Models/PredictiveModels/mlr/gbm_onehot/mod_gbm_onehot.rda")
load("Models/PredictiveModels/mlr/randomforest/mod_randomforest.rda")
load("Models/PredictiveModels/mlr/xgboost/mod_xgboost.rda")

test_onehot <- read.csv("Data/TrainAndTest/test_onehot.csv")
train_onehot <- read.csv("Data/TrainAndTest/train_onehot.csv")
test <- read.csv("Data/TrainAndTest/test.csv")
train <- read.csv("Data/TrainAndTest/train.csv")

explain_xgb1h <- DALEX::explain(
  model= mod_xgboost_onehot,
  data = train_onehot,
  y = exp(train$price_log),
  label = "xgboost_onehot",
  class = xgboost::xgboost,
  predict_function = function (x, y)
    exp(yhat(x, y))
)

explain_gbm1h <- DALEXtra::explain_mlr(
  model = mod_gbm_onehot,
  data = train_onehot,
  y = exp(train$price_log),
  label = "gbm_onehot",
  predict_function = function (x, y)
    exp(yhat(x, y))
)

explain_xgb <- DALEXtra::explain_mlr(
  model = mod_xgboost,
  data = train,
  y = exp(train$price_log),
  label = "xgboost",
  class = xgboost::xgboost,
  predict_function = function (x, y)
    exp(yhat(x, y))
)

explain_rf <- DALEXtra::explain_mlr(
  model = mod_randomforest,
  data = train,
  y = exp(train$price_log),
  label = "randomForest",
  class = randomForest::randomForest,
  predict_function = function (x, y)
    exp(yhat(x, y))
)


save(explain_gbm1h, file = "Explanations/explain_object/explain_gbm1h.rda")
save(explain_xgb1h, file = "Explanations/explain_object/explain_xgb1h.rda")
save(explain_rf, file = "Explanations/explain_object/explain_rf.rda")
save(explain_xgb, file = "Explanations/explain_object/explain_xgb.rda")