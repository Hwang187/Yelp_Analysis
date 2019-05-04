
'''
Using Spark excavate Las Vegas restaurants' reviews
'''
df_review = spark.read.json("review.json") 
df_Rid = spark.read.format("csv").option("header", "true").load("ResruarantID.csv")
LV_Review = df_review.join(df_Rid, df_review["business_id"] == df_Rid["business_id"],"inner").drop(df_Rid["business_id"])
LV_Review.coalesce(1).write.json("/user/maria_dev/Yelp/json")            
LV_Review.coalesce(1).write.format("csv").option("header", "true").save("/user/maria_dev/Yelp/csv") 
#LV_Review.read.mode('append').json("/user/maria_dev/Yelp")
#.coalesce(1)
