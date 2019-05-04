import numpy as np 
import pandas as pd 
import folium
import branca
from math import sin, cos, sqrt, atan2, radians

'''
This funcion is caculate distance between restaurants
The distance will be used to caculate average stars of restaurant in specific range
'''
def dist(loc1, loc2):
    R = 6373.0
    lat1 = radians(loc1['latitude'])
    lon1 = radians(loc1['longitude'])
    lat2 = radians(loc2['latitude'])
    lon2 = radians(loc2['longitude'])
    dlon = lon2 - lon1
    dlat = lat2 - lat1
    a = sin(dlat / 2)**2 + cos(lat1) * cos(lat2) * sin(dlon / 2)**2
    c = 2 * atan2(sqrt(a), sqrt(1 - a))
    return(R * c)

# Function to make heatmap on map

def heatmap(restaurant_category):
    LV_restaturant = pd.read_csv('/Users/wanghan/Projects/Yelp/Modified_Data/Geo/GeoData.csv')
    category_restaturant = pd.read_excel('/Users/wanghan/Projects/Yelp/Modified_Data/category_restaturant.xlsx')
    df1 = category_restaturant.dropna(subset=[restaurant_category])[[restaurant_category]]
    df1.columns = ['business_id']
    df = LV_restaturant.set_index('business_id').join(df1.set_index('business_id'), how = 'inner')
    t_list = ["Stamen Terrain", "Stamen Toner", "Mapbox Bright"]
    m = folium.Map(location=(36.1699, -115.1398), zoom_start = 11
                ,tiles = "Stamen Terrain"
                )
    df['Latitude'] = df['latitude'].astype(float)
    df['Longitude'] = df['longitude'].astype(float)
    heat_df = df[['Latitude', 'Longitude', 'avg_stars']]
    HeatMap(data=heat_df.groupby(['Latitude', 'Longitude']).sum().reset_index().values.tolist(),
            radius = 12,
            max_zoom=13).add_to(m)
    return m