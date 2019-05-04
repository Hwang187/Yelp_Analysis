# Yelp_Analysis
Project in CSP571

This project is aim to help restaurant owners to gain high ratings on Yelp.com by giving recommendations based on our analysis of review and business data of Yelp.

The data processing and analysis workfolw are following:
1. Las Vegas business excavated
2. Related reviews and weather data excavated 
3. Data cleaning and preparation
4. Business analysis(overviews analysis, stars trend analysis, location analysis, weather influence analysis, income influence analysis)
5. Reviews analysis(TF_IDF, LDA, K_Means)
6. Deployment

Data Source:
- [Oringinal data](https://www.yelp.com/dataset)
- [supplementary data 1- Income by Location](https://datausa.io/profile/geo/las-vegas-nv)
- [supplementary data 2- Historical Hourly Weather Data](https://www.kaggle.com/selfishgene/historical-hourly-weather-data)

In this project, we used:
1. R 
2. Python
3. Spark
4. rshiny

To apply the project you need to:
1. In R, install jsonlite, dplyr, shiny, shinydashboard, shinydashboard, leaflet, reticulate
2. In python, install pandas, numpy, scipy, plotly, matplotlib, seaborn, cufflinks, folium, branca, math, gensim, nltk, pyLDAvis, sklearn

Detail of code:
- CitySpecify.R: Excavate Las Vegas business data 
- Missing_map.R: Checking misisng value and plot
- LV_reviews_Mining.py: Excavate Las Vegas reviews with Spark
- Reviews_byCategory.R: Classify reviews by category
- Reviews_Data_Cleaning.py: Cleaning up reviews and create dictionary and bow_corpus.
- Income_data_process_analysis.R: Income data cleaning and analysis
- Business_Analysis_Plot.py: Make visualization in business analysis
- Heatmap.py: Make heatmap of stars of restaurants on map
- Weather_Plot.py: Weather influence analysis visualization.
- TF_IDF.py: Generate TF_IDF matrix
- Number_Topic.py: Determin topic number
- K_Means.py: Apply K-means model				
- LDA.py: Apply LAD model				

Deployment Detail
- app.R: Application of deployment
- www: Contains all the required data and plot in deployment.
