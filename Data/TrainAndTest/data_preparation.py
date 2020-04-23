import numpy as np
import pandas as pd
import copy as cp
import geofast


# read csv with id as index
houses = pd.read_csv("./Data/kc_house_data.csv",index_col=0) 


# find duplicates 
id_dup = houses.groupby("id").size()
duplicates = id_dup[id_dup>1].index

# copy singles to another dataframe
id_to_keep = set(houses.index) - set(duplicates)
houses_cp = houses.loc[id_to_keep,:]  # auxiliary variable/dataframe

# for each house that was sold several times,
# leave one with mean price
for dup in duplicates:
    x = cp.deepcopy(houses.loc[dup,:])
    x.price = x.price.mean().round(-3) # round with 1000$ accuracy
    x = x.iloc[0,:]
    houses_cp = houses_cp.append(x)

# overwrite
houses = houses_cp


## DISTANCE TO THE NEAREST STOP
stops = pd.read_csv("./Data/ExternalData/stops.txt")
houses["dist_stop"] = np.nan # new column
rows = houses.index
# for each house find distances to all stops and pick the minimal one
for n in rows:
    h = houses.loc[n,["long","lat"]]
    houses.loc[n,"dist_stop"] = geofast\
        .distance(h.long,h.lat, stops.stop_lon,stops.stop_lat)\
        .min()


# CULTURAL PLACES
cult = pd.read_csv("./Data/ExternalData/cultural.csv")
cult = cult[["Latitude","Longitude"]]
cult.columns=["lat","long"]
cult = cult.dropna()
houses["ncult"] = np.nan
# for each house find distances to all of the cultural spots
# and count how many of them there are in 1km range
for n in rows:   #rows=houses.index
    h = houses.loc[n,["long","lat"]] 
    h500 = geofast.distance(cult.long,cult.lat,h.long,h.lat)        
    houses.ncult[n] = sum(h500<1000)
    
    
# VARIABLE TRANSFORMATIONS
houses.waterfront = houses.waterfront.astype('category')
houses.zipcode = houses.zipcode.astype('category')

houses["age"] = 2015- houses.yr_built 
houses["since_renovated"] = 2015-houses[["yr_built","yr_renovated"]].max(axis=1) #by rows

# price on the log scale
houses["price_log"] = np.log(houses.price)

# square feet → square meters
sqft_to_m2 = 0.092903
houses["m2_living"] = houses.sqft_living*sqft_to_m2
houses["m2_lot"] = houses.sqft_lot*sqft_to_m2
houses["m2_above"] = houses.sqft_above*sqft_to_m2
houses["m2_basement"] = houses.sqft_basement*sqft_to_m2
houses["m2_living15"] = houses.sqft_living15*sqft_to_m2
houses["m2_lot15"] = houses.sqft_lot15*sqft_to_m2

# variable selection
houses = houses[["price_log","bedrooms","floors", "waterfront", "view",
                 "condition", "grade", "zipcode", 
                 "lat", "long", "dist_stop", "ncult",
                 "age","since_renovated","m2_living","m2_lot","m2_above",
                 "m2_basement","m2_living15","m2_lot15"]]

    
# split into train/test 
from sklearn.model_selection import train_test_split

df_train, df_test = train_test_split(houses,test_size=0.3)

#save
df_train.to_csv("train.csv")
df_test.to_csv("test.csv")