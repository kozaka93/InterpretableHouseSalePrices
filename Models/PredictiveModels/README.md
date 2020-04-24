## Predictive models

### Machine learning model created with [mlr](https://cran.r-project.org/web/packages/mlr/index.html) R package.


| Model     | Script | Parameters|
|-----------|--------|-----------|
| random forest| [link](https://github.com/kozaka93/InterpretableHouseSalePrices/tree/master/Models/PredictiveModels/mlr/randomforest)| `mtry` = 4, `num.trees` = 476, `min.node.size` = 6|
|gbm|[link](https://github.com/kozaka93/InterpretableHouseSalePrices/tree/master/Models/PredictiveModels/mlr/gbm)|`n.trees` = 847, `interaction.depth` = 5|
|xgboost|[link](https://github.com/kozaka93/InterpretableHouseSalePrices/tree/master/Models/PredictiveModels/mlr/xgboost)| `nrouds` = 246, `max_depth` = 6,`eta` = 0.106, `lambda` = 0.608|
|decision tree|[link](https://github.com/kozaka93/InterpretableHouseSalePrices/tree/master/Models/PredictiveModels/mlr/decisionTree)|`minsplit` = 26, `minbucket` = 5, `cp` = 0.00152|
|xgboost one-hot|[link]() |`nrouds` = 468, `max_depth` = 4, `eta` = 0.134, `lambda` = 0.763|
|gbm one-hot|[link]() | `n.trees` = 898, `interaction.depth` = 6|
|random forest one-hot|[link]()|`num.trees` = 155, `mtry` = 4, `min.node.size` = 1|
|decision tree one-hot|[link]()|`minsplit` = 35, `minbucket` = 9, `cp` = 0.0167|
|lm |[link]()|-|






