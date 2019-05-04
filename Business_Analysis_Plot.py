import pandas as pd
import numpy as np
import scipy as sp
import plotly.plotly as py
import plotly.graph_objs as go
import plotly
import matplotlib.pyplot as plt
import seaborn as sns
import cufflinks as cf
cf.go_offline()
cf.set_config_file(offline=False, world_readable=True)
plotly.tools.set_credentials_file(username='hwang187', api_key='V8Hq7eud9bzcax7nkOJB')

# Demo Input
category_restaturant = pd.read_excel('/Users/wanghan/Projects/Yelp/Modified_Data/category_restaturant.xlsx')
LV_restaturant = pd.read_csv('/Users/wanghan/Projects/Yelp/Modified_Data/LV_restaturant.csv')
loc_R = LV_restaturant[['business_id','latitude','longitude','stars','review_count','categories']]
reviews_pizza = pd.read_csv('/Users/wanghan/Projects/Yelp/Modified_Data/Pizza_review.csv')
reviews_chinese =  pd.read_csv('/Users/wanghan/Projects/Yelp/Modified_Data/chinese_review.csv')
reviews_iltalian = pd.read_csv('/Users/wanghan/Projects/Yelp/Modified_Data/Italian_review.csv')
reviews_steak = pd.read_csv('/Users/wanghan/Projects/Yelp/Modified_Data/Steakhouses_review.csv')
reviews_AF = pd.read_csv('/Users/wanghan/Projects/Yelp/Modified_Data/review_per_category/American_fast_food_review.csv')
reviews_sea = pd.read_csv('/Users/wanghan/Projects/Yelp/Modified_Data/review_per_category/Seafood_review.csv')
reviews_deserrt = pd.read_csv('/Users/wanghan/Projects/Yelp/Modified_Data/review_per_category/Desserts_review.csv')

# Order review data by time
def review_process(df):
    df = df[['business_id', 'date', 'stars']]
    df['date'] = pd.to_datetime(df['date'])
    df = df.sort_values(['date'])
    return df

# Select specific category of restaurant
demo = ['Pizza','chinese','Italian','Steakhouses', 'American_fast_food', 'Desserts', 'Seafood']
def restaturant_process(str):
    df = category_restaturant.dropna(subset=[str])[[str]]
    df.columns = ['business_id']
    df = loc_R.set_index('business_id').join(df.set_index('business_id'), how = 'inner')
    return df

# Data preparation for time series visualization
def timeseries_prepare(df):
    df2 = df.set_index('date')[['stars']].resample('m').mean().dropna(subset=['stars'])[['stars']]
    df2 = df2.loc[df2.index.year >= 2012]
    return df2

# Stars distribution visualization
demo = ['Pizza','chinese','Italian','Steakhouses', 'American_fast_food', 'Seafood', 'Desserts']
def plot_overview(category):
    R = restaturant_process(category)
    return R['stars'].iplot(kind='hist', xTitle='Stars', yTitle='Count', title=category)

# Time series visualization
def plot_timeseries(num):
    rlst = [reviews_pizza, reviews_chinese, reviews_iltalian, 
            reviews_steak,reviews_AF, reviews_sea, reviews_deserrt]
    demo = ['Pizza','Chinese','Italian','Steakhouses',
            'American_fast_food', 'Seafood', 'Desserts']
    df = rlst[num]
    df1 = review_process(df)
    df2 = timeseries_prepare(df1)
    layout = go.Layout(
        title=go.layout.Title(
        text=demo[num],
        ),
        xaxis=go.layout.XAxis(title=go.layout.xaxis.Title(text='Time')),
        yaxis=go.layout.YAxis(dict(title = 'Average Stars',range=[df2['stars'].min()-0.2, df2['stars'].max()+0.2]))
        )
    return df2.iplot(kind='bar', xTitle='Date', yTitle='Average Stars',
                     title='Monthly Average Stars', opacity=0.4, layout = layout)