import pandas as pd
import os
import psutil
import geofast

def usage():
    # just some function to check memory usage by Python
    process = psutil.Process(os.getpid())
    return process.memory_info()[0] / float(2**20)
usage()

os.chdir("/home/wicherekp/Py/xai/")

cult = pd.read_csv("cultural.csv")

cult = cult.Location.str[1:-1].str.split(", ",expand=True)
cult.columns=["lat","long"]
cult.lat = cult.lat.astype(float)
cult.long = cult.long.astype(float)
cult=cult.dropna().reset_index(drop=True)

houses = pd.read_csv("houses+stops_0304.csv")

houses.date = (houses.date.str[0:8]).astype(int)

N = houses.shape[0]
houses["ncult"] = 0



for i in range(N):
    h = houses.loc[i,["long","lat"]] 
    h500 = geofast.distance(cult.long,cult.lat,h.long,h.lat)        
    houses.ncult[i] = sum(h500<1000)

# znajdź duplikaty
idiki = houses.groupby("id").size()
duplicates = idiki[idiki>1].index        

df = houses = houses.set_index("id") # checkpoint
# single
indexes_to_keep = set(df.index)-set(duplicates)
df = df.loc[indexes_to_keep,:]


for dup in duplicates:
    x = houses.loc[dup,:]
    x.price[0]=int(x.price.mean())
    x=x.iloc[0,:]
    df = df.append(x)
    
df.to_csv("final.csv")
        

from sklearn.model_selection import train_test_split

df_train,df_test=train_test_split(df,test_size=0.3)
df_train.shape
df_test.shape

df_train.to_csv("kc_train.csv")
df_test.to_csv("kc_test.csv")

df_train.ncult

import seaborn as sns
sns.set()
ax = sns.kdeplot(df_train.ncult)
ax.set(xlim=(0, 20))


import matplotlib.pyplot as plt
ax
