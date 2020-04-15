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


df_train = pd.read_csv("kc_train.csv")
df_test = pd.read_csv("kc_test.csv")

df = df_train.append(df_test)


df.info()

df.waterfront = df.waterfront.astype('category')
df.zipcode = df.zipcode.astype('category')

df["age"] = 2015- df.yr_built 
df["since_renovated"] = 2015-df[["yr_built","yr_renovated"]].max(axis=1) #by rows
df.columns
df.info()

sqft_to_m2 = 0.092903
df["m2_living"] = df.sqft_living*sqft_to_m2
df["m2_lot"] = df.sqft_lot*sqft_to_m2
df["m2_above"] = df.sqft_above*sqft_to_m2
df["m2_basement"] = df.sqft_basement*sqft_to_m2
df["m2_living15"] = df.sqft_living15*sqft_to_m2
df["m2_lot15"] = df.sqft_lot15*sqft_to_m2
df = df.drop(["sqft_living","sqft_lot",
              "sqft_living15","sqft_lot15",
              "sqft_above","sqft_basement"],axis=1)
df.info()
df = df.set_index("id")
df
import seaborn as sns; sns.set()
sns.kdeplot(df.lot)
sum(df.m2_lot>10)
df.shape


from sklearn.model_selection import train_test_split

df_train,df_test=train_test_split(df,test_size=0.3)
df_train.shape
df_test.shape

df_train.to_csv("kc_train_2.csv")
df_test.to_csv("kc_test_2.csv")
