import numpy as np 
import pandas as pd 
import folium
import branca
from folium import plugins
from folium.plugins import HeatMap
from math import sin, cos, sqrt, atan2, radians

str_category = ['American_fast_food', 'Breakfast_Brunch', 'Pizza', 'Desserts', 'bars',
       'mexican', 'chinese', 'Italian', 'Korean', 'Seafood', 'Japanese',
       'French', 'Indian', 'Middle_eastern', 'Barbeque', 'Beverages',
       'Steakhouses', 'vegetarian', 'Buffets', 'Southeast_Asia',
       'Mediterranean']
def heatmap(str_category):
    LV_restaturant = pd.read_csv('/Users/dyb/Desktop/yelp_dataset/code/heatmap/GeoData.csv')
    category_restaturant = pd.read_excel('/Users/dyb/Desktop/yelp_dataset/code/heatmap/category_restaturant.xlsx')
    df1 = category_restaturant.dropna(subset=[str_category])[[str_category]]
    df1.columns = ['business_id']
    df = LV_restaturant.set_index('business_id').join(df1.set_index('business_id'), how = 'inner')
    t_list = ["Stamen Terrain", "Stamen Toner", "Mapbox Bright"]
    m = folium.Map(location=(36.1699, -115.1398), zoom_start = 11
                ,tiles = "Stamen Terrain"
                )

    df['Latitude'] = df['latitude'].astype(float)
    df['Longitude'] = df['longitude'].astype(float)
    heat_df = df[['Latitude', 'Longitude', 'avg_stars']]

    # colormap = {0.0: 'pink', 0.3: 'blue', 0.5: 'green',  0.7: 'yellow', 1.0: 'red'}
    HeatMap(data=heat_df.groupby(['Latitude', 'Longitude']).sum().reset_index().values.tolist(),
            radius = 12,
            max_zoom=13).add_to(m)
    return m