## Model assessment

### Verification, validation, and error analysis with [auditor](https://cran.r-project.org/web/packages/auditor/index.html) R package


| Model     |  RMSE train | RMSE test | Parameters|
|-----------|------------|-----------|-----------|
| random forest|  0.07931109|0.1674559| `mtry` = 4, `num.trees` = 476, `min.node.size` = 6|
|gbm|0.3924759|0.3904789|`n.trees` = 847, `interaction.depth` = 5|


###  Residuals