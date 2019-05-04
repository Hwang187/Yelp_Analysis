# for importing json file into R
install.packages('jsonlite')
library('jsonlite')
library(dplyr)
library(ggplot2)
path = "/Users/wanghan/Projects/Yelp/yelp_dataset/business.json"

# Mining Las Vegas from bussiness dataset
CitySpecify <- function(path)
{
  # Input original data
  business <- stream_in(file(path))
  citycount <- table(business$city)
  business[business$city == '110 Las Vegas','city']='Las Vegas' # mistake:142830th  city:110 Las Vegas
  business[business$city == '','state'] # state=AZ not NV
  head(sort(citycount,decreasing = TRUE),50)
  names(citycount)[440:520] # need to integrate city name 'Las Vegas'
  names(citycount)[1126:length(names(citycount))] # recorded as 'Vegas'
  business[business$city == 'Los Vegas','city']='Las Vegas'
  business[business$city == 'La Vegas','city']='Las Vegas'
  businessLV <- business[grep('^las',tolower(business$city)),]
  businessLV <- rbind(businessLV,business[business$city == 'Lake Las Vegas',],business[business$city == 'Vegas',])
  businessLV <- businessLV[!businessLV$city %in% c('Lasalle','LaSalle'),]
  businessLV[,names(businessLV[1,14])] <- businessLV[,14][1:7]
  businessLV[,names(businessLV[1,12])] <- businessLV[,12][1:39]
  businessLVc <- businessLV[,-c(12,14)]
  return(businessLVc)
}

# Mining restaurant from all business 
restaurantSpecify = function(businessLVc)
{
  # Drop features which contains big proportion of missing value
  df_all = select(businessLVc,"business_id","name","address","city",
                  "state","latitude","longitude","stars","review_count","categories")
  restaurants = c("restaurants", "food", "fast food",
                  "coffee & tea", "sandwiches", "pizza", "burgers", "breakfast & brunch")
  r_ls = character()
  for(i in (1:length(df_all$categories)))
  {
    if(length(which(trimws(strsplit(tolower(df_all$categories), ",")[[i]]) %in% restaurants))>0)
    {
      r_ls = append(r_ls, df_all$business_id[i])
    }
  }
  df_r = data.frame(r_ls)
  colnames(df_r) = c("business_id")
  df_restaurant = merge(x=df_all, y=df_r, by="business_id" )
  
  # Out put data file for future analysis
  write.csv(df_all,file='LV_business.csv',row.names = FALSE,col.names = TRUE)
  write.csv(df_r,file='ResruarantID.csv',row.names = FALSE,col.names = TRUE)
  write.csv(df_restaurant,file='LV_restaturant.csv',row.names = FALSE,col.names = TRUE)
  return("Output successful")
}

missingMap <- function(businessLVc)
{
  # Check missing value
  Null_Counter = apply(businessLVc, 2, function(x) length(which(x == "" | is.na(x) | x == "NA"))/length(x))
  Null_Percent = Null_Counter[which(Null_Counter > 0)]
  barPlot = barplot(sort(Null_Percent), las=2, 
                    col=rainbow(49), cex.names=.5, ylim=c(0,1),
                    main = 'Missing Value Percentage',
                    ylab = 'Missing Percentage')
  return(barPlot)
}



