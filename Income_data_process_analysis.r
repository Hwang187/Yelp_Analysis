library(readr)
r <- read_csv("LV_restaturant.csv")
View(r)
#missing data
library(Amelia)
missmap(r)
  #delete missing data
r<-r[!is.na(r$address),]
  #check
colnames(r)[colSums(is.na(r)) > 0]
##############################################################################
#generate 4 income data file from 2013-2016 
i <- read_csv("Data USA - Geo Map of Income by Location in Las Vegas, Nv.csv")
View(i)
i$census_tract <- substr(i$geo, 13, 18)
i$geo_name=i$geo=NULL
i_2013<-i[i$year==2013,]
View(i_2013)
i_2014<-i[i$year==2014,]
i_2015<-i[i$year==2015,]
i_2016<-i[i$year==2016,]
write.csv(i_2013,file="income_2013.csv")
write.csv(i_2014,file="income_2014.csv")
write.csv(i_2015,file="income_2015.csv")
write.csv(i_2016,file="income_2016.csv")

#prepare for geo code transform
i13 <- read_csv("chinese data by year/chinese_2013.csv")
i13<-i13[,c("ave_stars","census_tract")]
View(i13)
i14 <- read_csv("income_2014.csv")[,-1:2]
View(i14)
i15 <- read_csv("income_2015.csv")[,-1:2]
i16 <- read_csv("income_2016.csv")[,-1:2]

##################################################################################################
#generate 4 business data from 2013-2016
pr <- read_csv("Barbeque_review.csv")
View(pr)
i6 <- read_csv("2nd data by year/income_2016.csv")
i5 <- read_csv("2nd data by year/income_2015.csv")
i4 <- read_csv("2nd data by year/income_2014.csv")
i3 <- read_csv("2nd data by year/income_2013.csv")

View(i3)
  #extract only year from date
pr$date <- substr(pr$date, 1, 4)
  #split data based on year from 2013-2016
pr_2013<-pr[pr$date==2013,][,c("business_id","date","stars")]
#View(pr_2013)
pr_2014<-pr[pr$date==2014,][,c("business_id","date","stars")]
pr_2015<-pr[pr$date==2015,][,c("business_id","date","stars")]
pr_2016<-pr[pr$date==2016,][,c("business_id","date","stars")]
  #unique business_id & calculate mean(stars) of busines
library(dplyr)
br_2013<-tbl_df(pr_2013)%>%group_by(business_id)%>%summarize(date=2013,ave_stars=round(mean(stars),2))
#View(br_2013)
br_2014<-tbl_df(pr_2014)%>%group_by(business_id)%>%summarize(date=2014,ave_stars=round(mean(stars),2))
br_2015<-tbl_df(pr_2015)%>%group_by(business_id)%>%summarize(date=2015,ave_stars=round(mean(stars),2))
br_2016<-tbl_df(pr_2016)%>%group_by(business_id)%>%summarize(date=2016,ave_stars=round(mean(stars),2))
 #add coordinates to restuarant data
b_2013<-merge(br_2013,r,by.x="business_id",by.y="business_id")[,c("business_id","date","ave_stars","latitude","longitude")]
#View(b_2013)
b_2014<-merge(br_2014,r,by.x="business_id",by.y="business_id")[,c("business_id","date","ave_stars","latitude","longitude")]
b_2015<-merge(br_2015,r,by.x="business_id",by.y="business_id")[,c("business_id","date","ave_stars","latitude","longitude")]
b_2016<-merge(br_2016,r,by.x="business_id",by.y="business_id")[,c("business_id","date","ave_stars","latitude","longitude")]


#trance coordinates to census_code in 4 forms
install.packages("tigris")
library(tigris)
#2013
coord13 <-data.frame(lat = c(b_2013$latitude),long = c(b_2013$longitude))
#View(coord13)
b_2013$census_code <- apply(coord13, 1, function(row) call_geolocator_latlon(row['lat'], row['long']))
#coord1 <-data.frame(address= c(r$address),city = c(r$city),state = c(r$state))
#r$census_code <- apply(coord1, 1, function(row) call_geolocator(row['address'], row['city'],row['state']))
#View(b_2013)
#extract tract from census_code 
b_2013$census_tract <- substr(b_2013$census_code, 6, 11)
#View(b_2013)
#merge 2nd data and restuarant by catagory
b13<-tbl_df(b_2013)%>%group_by(census_tract)%>%summarize(med_stars=round(median(ave_stars),2))
#View(b13)
a13<-merge(x=b13,y=i3, by="census_tract",all.x = TRUE)
#View(a13)
s13<-a13[!is.na(a13$income),]
s13$X1<-s13$year<-NULL
#View(s13)
#output as csv file
write.csv(b_2013,file="Barbeque_2013.csv")
#b_2013 <- read_csv("Mediterranean_2013.csv")

#2014
coord14 <-data.frame(lat = c(b_2014$latitude),long = c(b_2014$longitude))
#View(coord14)
b_2014$census_code <- apply(coord14, 1, function(row) call_geolocator_latlon(row['lat'], row['long']))
#coord1 <-data.frame(address= c(r$address),city = c(r$city),state = c(r$state))
#r$census_code <- apply(coord1, 1, function(row) call_geolocator(row['address'], row['city'],row['state']))
#View(b_2014)
#extract tract from census_code 
b_2014$census_tract <- substr(b_2014$census_code, 6, 11)
#View(b_2014)
#merge 2nd data and restuarant by catagory
b14<-tbl_df(b_2014)%>%group_by(census_tract)%>%summarize(med_stars=round(median(ave_stars),2))
#View(b14)
a14<-merge(x=b14,y=i4, by="census_tract",all.x = TRUE)
#View(a14)
s14<-a14[!is.na(a14$income),]
s14$X1<-s14$year<-NULL
#View(s14)
#output as csv file
write.csv(b_2014,file="Barbeque_2014.csv")
#b_2014 <- read_csv("Beverages_2014.csv")

#2015
coord15 <-data.frame(lat = c(b_2015$latitude),long = c(b_2015$longitude))
#View(coord15)
b_2015$census_code <- apply(coord15, 1, function(row) call_geolocator_latlon(row['lat'], row['long']))
#coord1 <-data.frame(address= c(r$address),city = c(r$city),state = c(r$state))
#r$census_code <- apply(coord1, 1, function(row) call_geolocator(row['address'], row['city'],row['state']))
#View(b_2015)
#extract tract from census_code 
b_2015$census_tract <- substr(b_2015$census_code, 6, 11)
#View(b_2015)
#merge 2nd data and restuarant by catagory
b15<-tbl_df(b_2015)%>%group_by(census_tract)%>%summarize(med_stars=round(median(ave_stars),2))
#View(b13)
a15<-merge(x=b15,y=i5, by="census_tract",all.x = TRUE)
#View(a13)
s15<-a15[!is.na(a15$income),]
s15$X1<-s15$year<-NULL
#View(s15)
#output as csv file
write.csv(b_2015,file="Barbeque_2015.csv")
#library(readr)
#b_2015 <- read_csv("Beverages_2015.csv")

#2016
coord16 <-data.frame(lat = c(b_2016$latitude),long = c(b_2016$longitude))
#View(coord16)
b_2016$census_code <- apply(coord16, 1, function(row) call_geolocator_latlon(row['lat'], row['long']))
#coord1 <-data.frame(address= c(r$address),city = c(r$city),state = c(r$state))
#r$census_code <- apply(coord1, 1, function(row) call_geolocator(row['address'], row['city'],row['state']))
#View(b_2016)
#extract tract from census_code 
b_2016$census_tract <- substr(b_2016$census_code, 6, 11)
#View(b_2015)
#merge 2nd data and restuarant by catagory
b16<-tbl_df(b_2016)%>%group_by(census_tract)%>%summarize(med_stars=round(median(ave_stars),2))
#View(b13)
a16<-merge(x=b16,y=i6, by="census_tract",all.x = TRUE)
#View(a13)
s16<-a16[!is.na(a16$income),]
s16$X1<-s16$year<-NULL
#View(s15)
#output as csv file
write.csv(b_2016,file="Barbeque_2016.csv")
#library(readr)
#b_2015 <- read_csv("Beverages_2015.csv")
sh<-rbind(s13,s14,s15,s16)
View(sh)
write.csv(sh,file="Barbeque_2nd_data.csv")

######################################################################################
#modeling for income by location data of las vegas
######################################################################################
library(readr)
data <- read_csv('~/French_2nd_data.csv')
View(data)
plot(data$income,data$med_stars)
plot(data$med_stars,data$income)

tryy <- function(income){
  if (income > 75000){
    return (4)
  }
  else if (income >50000 && income < 75000){
    return (3)
  }
  else if (income > 25000 && income < 50000){
    return (2)
  }
  else{ return (1)}
}


data$category=as.factor(sapply(data$income, tryy))
fit3 <- lm(med_stars~category,data)
summary(fit3)
plot(fit3)
lines(data$income,fit3$fitted.values,col='red2')

data_sub <- data[data$category=='2',]
data_sub1 <- data[data$category=='3',]
data_sub2<-rbind(data[data$category=='2',],data[data$category=='3',])
cor(data_sub[,'income'],data_sub[,'med_stars'])
#View(data_sub)
fit4<- lm(med_stars~income,data_sub)
summary(fit4)

#plot(fit4)
plot(main="Barbeque vs income per capital by census tract--catogory 2",data_sub$income,data_sub$med_stars,col='blue')
lines(data_sub$income,fit4$fitted.values,col='red2')

cor(data_sub1[,'income'],data_sub1[,'med_stars'])
#View(data_sub1)
fit5 <- lm(med_stars~income,data_sub1)
summary(fit5)
#plot(fit5)
plot(main="Barbeque vs income per capital by census tract--catogory 3",data_sub1$income,data_sub1$med_stars,col='blue')
lines(data_sub1$income,fit5$fitted.values,col='red2')

cor(data_sub2[,'income'],data_sub2[,'med_stars'])
#View(data_sub2)
fit6 <- lm(med_stars~category,data_sub2)
summary(fit6) 
fit7 <- lm(med_stars~income,data_sub2)
summary(fit7)
#plot(fit6)
plot(main="Barbeque vs income per capital by census tract--catogory 2&3",data_sub2$income,data_sub2$med_stars,col='blue')
lines(data_sub2$income,fit7$fitted.values,col='red2')

