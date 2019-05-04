import pandas as pd
import numpy as np
import plotly.plotly as py
import plotly.graph_objs as go
import plotly
import matplotlib.pyplot as plt
import seaborn as sns
import cufflinks as cf

# Weather will be spilt by sky is clear or not
def clear_process(df):
    df = df[df['weather'] == 'sky is clear'][['stars', 'humidity', 'pressure', 'weather', 'temperature']]
    return df

def Noclear_process(df):
    df = df[df['weather'] != 'sky is clear'][['stars', 'humidity', 'pressure', 'weather', 'temperature']]
    return df

'''
Demo visualization of weather
In this function you only need to choose index of restaurant category and index of weather
Restaurant: [Pizza, Chinese, Seafood, Italian, Steakhouses, American_fast_food, Seafood, Desserts]
Weather: ['humidity', 'pressure', 'temperature']
'''
def plot_weather(num1, num2):
    rlst = [Pizza, Chinese, Seafood, Italian, Steakhouses, American_fast_food, Seafood, Desserts]
    wlst = ['humidity', 'pressure', 'temperature']
    demo = ['Pizza','Chinese','Italian','Steakhouses',
            'American_fast_food', 'Seafood', 'Desserts']
    df = rlst[num1]
    weather = wlst[num2]
    trace1 = go.Scatter(
        x = clear_process(df)[weather],
        y = clear_process(df)['stars'],
        mode = 'markers',
        name = 'Clear Sky'
    )
    trace2 = go.Scatter(
        x = Noclear_process(df)[weather],
        y = Noclear_process(df)['stars'],
        mode = 'markers',
        name = 'Sky is not clear'
    )
    layout= go.Layout(
        title= '%s Restaurants'%(demo[num1]),
        hovermode= 'closest',
        xaxis=dict(
            title= weather.capitalize()
        ),
        yaxis=dict(
            title = 'Stars'
        )
    )
    data = [trace1, trace2]
    fig= go.Figure(data=data, layout=layout)
    return py.iplot(fig)