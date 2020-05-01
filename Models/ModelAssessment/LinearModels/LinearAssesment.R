#### linear models assesment ####

## load models
load("Models/PredictiveModels/LinearModels/Model1.rda")
load("Models/PredictiveModels/LinearModels/Model2.rda")
load("Models/PredictiveModels/LinearModels/Model3.rda")

##load data
train <- read.csv("Data/TrainAndTest/train.csv")
test <- read.csv("Data/TrainAndTest/test.csv")

## transform variables
train$m2_above_log <- log(train$m2_above)
train$m2_basement_log <- log(train$m2_basement)
train$m2_lot_log <- log(train$m2_lot)
train$m2_living15_log <- log(train$m2_living15)
train$m2_lot15_log <- log(train$m2_lot15)
test$m2_above_log <- log(test$m2_above)
test$m2_basement_log <- log(test$m2_basement)
train$m2_basement_log[train$m2_basement == 0] <- 0
test$m2_basement_log[test$m2_basement == 0] <- 0
test$m2_lot_log <- log(test$m2_lot)
test$m2_living15_log <- log(test$m2_living15)
test$m2_lot15_log <- log(test$m2_lot15)
train$dist_stop_km <- train$dist_stop/1000
test$dist_stop_km <- test$dist_stop/1000

## define RMSE
RMSE <- function(actual, pred) { sqrt(mean((actual - pred)^2)) }

## define predictions
pred1 <- predict(Model1, train)
pred1test <- predict(Model1, test)

pred2 <- predict(Model2, train)
pred2test <- predict(Model2, test)

pred3 <- predict(Model3, train)
pred3test <- predict(Model3, test)

## Calculate RMSE for each model
rmse1 <- RMSE(train$price_log, pred1)
rmse1test <- RMSE(test$price_log, pred1test)

rmse2 <- RMSE(train$price_log, pred2)
rmse2test <- RMSE(test$price_log, pred2test)

rmse3 <- RMSE(train$price_log, pred3)
rmse3test <- RMSE(test$price_log, pred3test)

## plot residuals of RE model
hist(Model3@resp$wtres, breaks = 100, main = "Random effects model residuals", xlab = "")
plot(train$price_log, Model3@resp$wtres, main = "Random effects model residuals"
     , xlab = "price_log", ylab = "Residual")
