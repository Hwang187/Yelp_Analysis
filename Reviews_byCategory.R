library(dplyr)

# Classify reviews data by restaurant category and output csv
Generate_category_reviews <- function(num)
{
  review <- read.csv('review.csv',header = T)
  American_fast_food_review <- review[review$business_id %in% as.list(category[,num])[[1]] ,]
  write.csv(American_fast_food_review,'/Users/dyb/Desktop/American_fast_food_review.csv',row.names = FALSE)
  return('True')
}
