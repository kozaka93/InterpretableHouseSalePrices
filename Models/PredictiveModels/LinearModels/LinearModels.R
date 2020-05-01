#### linear regression models ####

## load libraries
library(lme4)

## load train and test data

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

## estimate models

## Model 1 - linear regression with log transformated explanatory variables
Model1 <- lm(price_log ~ bedrooms + bathrooms + floors + waterfront + view
             + condition + grade + dist_stop_km + ncult + since_renovated
             + m2_lot_log + m2_above_log + m2_basement_log + m2_living15_log + m2_lot15_log, data = train)


## Model 2 - adding zipcode-based intercepts
Model2 <- lm(price_log ~ bedrooms + bathrooms + floors + waterfront + view
             + condition + grade + dist_stop_km + ncult + since_renovated
             + m2_lot_log + m2_above_log + m2_basement_log + m2_living15_log + m2_lot15_log
             + factor(zipcode) + 0, data = train)


## Model 3 - adding mixed-effects to the model
Model3 <- lmer(price_log ~ bedrooms + bathrooms + floors + waterfront + view
               + condition + grade + dist_stop_km + ncult + since_renovated
               + m2_lot_log + m2_above_log + m2_basement_log + m2_living15_log
               + (view + waterfront + m2_lot_log + m2_above_log + m2_living15_log + m2_lot15_log| zipcode)
               , data = train)
