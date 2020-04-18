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

houses = pd.read_csv("kc_house_data.csv")
stops = pd.read_csv("./trans1/stops.txt")

def _find_closest(nth_row):
    # houses ← ramka domów
    # stops ← ramka przystanków
    h = houses.loc[nth_row,["long","lat"]]
    return geofast.\
        distance(h.long,h.lat, 
                 stops.stop_lon,stops.stop_lat)\
        .min()
    
N = houses.shape[0]
houses["dist_stop"] = 2020

for h in range(N):
    houses.loc[h,"dist_stop"] = _find_closest(h)
    
houses.dist_stop
houses.to_csv("houses+stops_0304.csv",index=False)


#import seaborn as sns
#df2 = pd.read_csv("houses+stops_0304.csv")
#df2
#sns.distplot(df2.dist_stop[df2.dist_stop<1500])





