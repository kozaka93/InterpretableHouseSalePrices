# Story House Sale Prices: eXplainable predictions for house sale 

*Authors: Piotr Grązka (SGH Warsaw School of Economics), Anna Kozak (Warsaw University of Technology), Paweł Wicherek (Warsaw University of Technology)*

*Mentors: Mateusz Zawisza (McKinsey & Company), Adam Zmaczyński (McKinsey & Company)*

## Introduction 

The problem we're working on is really important, and at some point in your life most people will have to deal with it. We are talking about buy/sell of real estate. Additionally, such a probelm is also used for commercial purposes because of developers or auction portals. Let's start with a few questions that will allow us to understand and define the problems

- *The seller does not know how to increase the cost of the apartment so that the investment outlay is lower than the added value (buying a basement will increase the price and renovating the bathroom is not worth it).*

- *The seller does not know how much to sell the apartment for (he makes an offer on the portal and does not know if the price is fair).*

- *The buyer does not know how much the apartment is worth (as above, whether the price is fair).*

- *Commercial problem: Auction services do not have tools to support sellers/buyers.*

These are just some of the questions we can ask. As a definition of our problem, we have set ourselves a property valuation, and through explanations we will try to get an answer depending on the position we choose.


We have divided our work into several stages, below we present a diagram with a step plan. It allowed us to plan our work, and now we will use it to tell you what we did.


![](images/plan.png)<!-- -->

We started our work with a literature review. Many works show a comparison of hedonistic models (linear regression) and machine learning models. Below there is a plot with comparison of results achieved by interpretable models (hedonic model) and black box model (ANN) based on the article \@ref(house_prices).

![](images/model_article.png)<!-- -->


We can conclude that we reduce the interpretability to an increase in the quality of model fitting.

The next point was data analysis, we work on dataset which contains house sale prices for King County, which includes Seattle. It is include homes sold between May 2014 and May 2015. Data available on [kaggle](https://www.kaggle.com/harlfoxem/housesalesprediction) and [openml](https://www.openml.org/d/42079).
We have analyzed the data. More [link](https://github.com/kozaka93/InterpretableHouseSalePrices/tree/master/Reports/DataAnalysis). Data contains 19 house features plus the price and the id columns, along with 21613 observations. 

- `id` unique ID for each home sold
- `date` date of the home sale
- `price` price of each home sold
- `bedrooms` number of bedrooms
- `bathrooms` number of bathrooms, where .5 accounts for a room with a toilet but no shower
- `sqft_living` square footage of the apartments interior living space
- `sqft_lot` square footage of the land space
- `floors` sumber of floors
- `waterfront` apartment was overlooking the waterfront or not
- `view` how good the view of the property was
- `condition` condition of the apartment
- `grade` level of construction and design
- `sqft_above` the square footage of the interior housing space that is above ground level
- `sqft_basement` the square footage of the interior housing space that is below ground level
- `yr_built` the year the house was initially built
- `yr_renovated` the year of the house's last renovation
- `zipcode` zipcode area
- `lat` lattitude
- `long` longitude
- `sqft_living15` the square footage of interior housing living space for the nearest 15 neighbors
- `sqft_lot15` the square footage of the land lots of the nearest 15 neighbors

We have collected methods to evaluate the performance of the regression model, we decided to use RMSRE (root mean square relative errors), because the difference of 50 thousand on a property worth millions and 50 thousand on a property worth 200 thousand is quite considerable. More about measures [link](https://github.com/kozaka93/InterpretableHouseSalePrices/tree/master/Reports/ModelAssessment).

Based on the literature we decided to test the following models:
- fixed effects model
- random effects model
- Spatial Autoregressive (SAR) model
- linear regression
- decision tree
- random forest
- gradient boosting, xgboost

Another idea how to enrich our solution was to add external data. The location of the property can significantly affect the price, so we also took into account the distance from public transport and the number of cultural facilities within a kilometre radius.


## Model 

Place a description of the model(s) here. Focus on key information on the design and quality of the model(s) developed.

## Explanations

Here, show how XAI techniques can be used to solve the problem.
Will dataset specific or instance specific techniques help more?

Will XAI be useful before (pre), during (in) or after (post) modeling?

What is interesting to learn from the XAI analysis?


## Summary and conclusions 

Here add the most important conclusions related to the XAI analysis.
What did you learn? 
Where were the biggest difficulties?
What else did you recommend?
