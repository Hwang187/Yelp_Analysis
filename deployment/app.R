################################################################################
#shiny

#global.R

library(shiny)
library(shinydashboard)
library(leaflet)
#list<-c("tap1","tap2","tap3")
library(reticulate)
use_python("/Users/dyb/anaconda/bin/python", required = TRUE)
setwd("/Users/dyb/Desktop/yelp_dataset/code/www")
category_income <- c("American Fast Food"='americanfastfoodincome', "Pizza"='pizzaincomoe', "Desserts"='dessertsincome',
                "Chinese"='chineseincome', "Italian"='italianincome', "Seafood"='seafoodincome', "Steakhouse"='steakhousesincome')


#####################################################################################
#ui.R

ui<-dashboardPage( 
  dashboardHeader(title = "Yelp Stars"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Slides", tabName = "slides", icon = icon("file-powerpoint")),
      menuItem("Food Categories", icon = icon("th"), 
               badgeColor = "green",
               menuItem("Chinese Food", icon = icon("chart-line"), tabName = "chinesefood",
                        badgeColor = "green"),
               menuItem("Pizza", icon = icon("chart-line"), tabName = "pizza",
                        badgeColor = "green"),
               menuItem("American Fast Food", icon = icon("chart-line"), tabName = "americanfastfood",
                        badgeColor = "green"),
               menuItem("Desserts", icon = icon("chart-line"), tabName = "desserts",
                        badgeColor = "green"),
               menuItem("Steakhouses", icon = icon("chart-line"), tabName = "steakhouses",
                        badgeColor = "green"),
               menuItem("Italian Food", icon = icon("chart-line"), tabName = "italianfood",
                        badgeColor = "green"),
               menuItem("Seafood", icon = icon("chart-line"), tabName = "seafood",
                        badgeColor = "green")
               )
      
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "slides",
              box(width=12,
                  tabBox(width=12,id="tabBox_next_previous",
                         tabPanel("P1",tags$img(src="p1.png",height=590,width=1180)),
                         tabPanel("P2",tags$img(src="p2.png",height=590,width=1180)),
                         tabPanel("P3",tags$img(src="p3.png",height=590,width=1180)),
                         tabPanel("P4",tags$img(src="p4.png",height=590,width=1180)),
                         #tabPanel("P5",includeHTML("Italian.html")
                           #       ),
                         tabPanel("P6",
                                  selectInput(inputId = "categoriesincome", choices =category_income,  label = "Categories"),
                                  plotOutput("figure") 
                                    
                                  ),
                         tabPanel("P7",tags$img(src="7.png",height=590,width=900)),
                         tabPanel("P8",tags$img(src="8.png",height=590,width=900)),
                         tabPanel("P9",tags$img(src="9.png",height=590,width=900)),
                         tabPanel("P10",tags$img(src="10.png",height=590,width=900)),
                         tabPanel("P11",tags$img(src="11.png",height=590,width=900)),
                         tabPanel("P12",tags$img(src="12.png",height=590,width=900)),
                         tabPanel("P13",tags$img(src="13.png",height=590,width=900)),
                         tabPanel("P14",tags$img(src="14.png",height=590,width=900)),
                         navbarMenu(
                           title = "categories",
                           tabPanel("P15",tags$img(src="15.png",height=590,width=900)),
                           tabPanel("P16",tags$img(src="16.png",height=590,width=900)),
                           tabPanel("P17",tags$img(src="17.png",height=590,width=900)),
                           tabPanel("P18",tags$img(src="18.png",height=590,width=900))
                         ),
                         tags$script("$('body').mouseover(function() {
                                     list_tabs=[];
                                     $('#tabBox_next_previous li a').each(function(){
                                     list_tabs.push($(this).html())
                                     });
                                     Shiny.onInputChange('List_of_tab', list_tabs);})
                                     ")
                         
                  ),
                  uiOutput("Next_Previous")
              )
      ),
  
      #########following is for testing
      
      tabItem(tabName = "chinesefood",
              navbarPage( "Stars VS hours",
                          tabPanel("Stars Distribution", tags$img(src="starsdistributionforchinesefood.png",height=590,width=900)),
                          tabPanel("Stars Trend", tags$img(src="starstrendforchinesefood.png",height=590,width=900)),
                          tabPanel("LADvis", includeHTML("Chinese.html")),
                          tabPanel("Stars Prediction", 
                                   wellPanel(textInput(inputId = "chinese1", label = "Food", width = '50%'),
                                             textInput(inputId = "chinese2", label = "Waiting Time",width = '50%'),
                                             actionButton(inputId = "SubmitChinese", label =  "submit"),
                                             h2(textOutput("predict_chinese_score")))
                                   )
      )),
      
      
      
      tabItem(tabName = "pizza",
              navbarPage( "Stars VS hours",
                          tabPanel("Stars Distribution", tags$img(src="starsdistributionforpizza.png",height=590,width=900)),
                          tabPanel("Stars Trend", tags$img(src="starstrendforpizza.png",height=590,width=900)),
                          tabPanel("LADvis", includeHTML("Pizza.html")),
                          tabPanel("Stars Prediction", 
                                   wellPanel(textInput(inputId = "pizza1", label = "Food"),
                                             textInput(inputId = "pizza2", label = "Waiting Time"),
                                             textInput(inputId = "pizza3", label = "Service"),
                                             textInput(inputId = "pizza4", label = "Delivery"),
                                             actionButton(inputId = "SubmitPizza", label =  "submit"),
                                             h2(textOutput("predict_pizza_score")))
                          )
              )),
      
      tabItem(tabName = "americanfastfood",
              navbarPage( "Stars VS hours",
                          tabPanel("Stars Distribution", tags$img(src="starsdistributionforamericanfastfood.png",height=590,width=900)),
                          tabPanel("Stars Trend", tags$img(src="starstrendforamericanfastfood.png",height=590,width=900)),
                          tabPanel("LADvis", includeHTML("American_fast_food.html")),
                          tabPanel("Stars Prediction", 
                                   wellPanel(textInput(inputId = "American_fast_food1", label = "Waiting Time"),
                                             textInput(inputId = "American_fast_food2", label = "Breakfast"),
                                             textInput(inputId = "American_fast_food3", label = "Place"),
                                             actionButton(inputId = "SubmitAmerican_fast_food", label =  "submit"),
                                             h2(textOutput("predict_American_fast_food_score")))
                          )
              )),
      
      tabItem(tabName = "desserts",
              navbarPage( "Stars VS hours",
                          tabPanel("Stars Distribution", tags$img(src="starsdistributionfordesserts.png",height=590,width=900)),
                          tabPanel("Stars Trend", tags$img(src="starstrendfordesserts.png",height=590,width=900)),
                          tabPanel("LADvis", includeHTML("Desserts.html")),
                          tabPanel("Stars Prediction", 
                                   wellPanel(textInput(inputId = "Desserts1", label = "Food Variety"),
                                             textInput(inputId = "Desserts2", label = "Environment"),
                                             textInput(inputId = "Desserts3", label = "Service"),
                                             textInput(inputId = "Desserts4", label = "Flavor"),
                                             actionButton(inputId = "SubmitDesserts", label =  "submit"),
                                             h2(textOutput("predict_Desserts_score")))
                          )
              )),
      
      tabItem(tabName = "steakhouses",
              navbarPage( "Stars VS hours",
                          tabPanel("Stars Distribution", tags$img(src="starsdistributionforsteakhouses.png",height=590,width=900)),
                          tabPanel("Stars Trend", tags$img(src="starstrendforsteakhouses.png",height=590,width=900)),
                          tabPanel("LADvis", includeHTML("Steakhouses.html")),
                          tabPanel("Stars Prediction", 
                                   wellPanel(textInput(inputId = "Steakhouses1", label = "Drink"),
                                             textInput(inputId = "Steakhouses2", label = "Food"),
                                             textInput(inputId = "Steakhouses3", label = "Waiting Time"),
                                             textInput(inputId = "Steakhouses4", label = "Place"),
                                             actionButton(inputId = "SubmitSteakhouses", label =  "submit"),
                                             h2(textOutput("predict_Steakhouses_score")))
                          )
              )),
      
      tabItem(tabName = "italianfood",
              navbarPage( "Stars VS hours",
                          tabPanel("Stars Distribution",  tags$img(src="starsdistributionforitalianfood.png",height=590,width=900)),
                          tabPanel("Stars Trend", tags$img(src="starstrendforitalianfood.png",height=590,width=900)),
                          tabPanel("LADvis", includeHTML("Italian.html")),
                          tabPanel("Stars Prediction", 
                                   wellPanel(textInput(inputId = "Italian1", label = "Food"),
                                             textInput(inputId = "Italian2", label = "Service"),
                                             textInput(inputId = "Italian3", label = "Environment"),
                                             actionButton(inputId = "SubmitItalian", label =  "submit"),
                                             h2(textOutput("predict_Italian_score")))
                          )
              )),
      
      tabItem(tabName = "seafood",
              navbarPage( "Stars VS hours",
                          tabPanel("Stars Distribution", tags$img(src="starsdistributionforseafood.png",height=590,width=900)),
                          tabPanel("Stars Trend", tags$img(src="starstrendforseafood.png",height=590,width=900)),
                          tabPanel("LADvis", includeHTML("Seafood.html")),
                          tabPanel("Stars Prediction", 
                                   wellPanel(textInput(inputId = "Seafood1", label = "Food"),
                                             textInput(inputId = "Seafood2", label = "Service"),
                                             textInput(inputId = "Seafood3", label = "Waiting Time"),
                                             actionButton(inputId = "SubmitSeafood", label =  "submit"),
                                             h2(textOutput("predict_Seafood_score")))
                          )
              ))
            
      
      
      
      
      
     
        )
          )
            )



####################################################################################
#server.R


server<-function(input, output,session){
  Previous_Button=tags$div(actionButton("Prev_Tab",label = "Previous"))
  Next_Button=div(actionButton("Next_Tab", label = "Next"))
  output$Next_Previous=renderUI({
    div(column(1,offset=1,Previous_Button),column(1,offset=8,Next_Button))
    
  })
  observeEvent(input$Prev_Tab,
               {
                 tab_list=input$List_of_tab
                 current_tab=which(tab_list==input$tabBox_next_previous)
                 updateTabsetPanel(session,"tabBox_next_previous",selected=tab_list[current_tab-1])
               })
  
  observeEvent(input$Next_Tab,
               {
                 tab_list=input$List_of_tab
                 current_tab=which(tab_list==input$tabBox_next_previous)
                 updateTabsetPanel(session,"tabBox_next_previous",selected=tab_list[current_tab+1])
               })
  
  
  #data<-eventReactive(input$go, {rnorm(input$num)})
  #output$hist<-renderPlot({hist(data())})
  
  #output$stars<-renderPlot({plot(d2$hour,d2$average_stars,"h")})
  
  #output$Pi<-renderPlot({plot(Pi$hour,Pi$average_stars,"h", main="Pizza stars VS hour")})
  #output$Am<-renderPlot({plot(Am$hour,Am$average_stars,"h", main="American Fast Food stars VS hour")})
  #output$Ch<-renderPlot({plot(Ch$hour,Ch$average_stars,"h", main="Chinese Food stars VS hour")})
  #output$Be<-renderPlot({plot(Be$hour,Be$average_stars,"h", main="Beverages stars VS hour")})
  
  output$figure<-renderImage({sprintf("%s.png",input$categoriesincome)})
  
 
  
  
  
  
  
  output$predict_chinese_score<-renderText({
    #new_document = 'How a Pentagon deal became an identity crisis for Google, the food is really great and the place is quiet.'
    #I love the place there very much, it’s beautiful and quiet
    #the service there is very gentle and nice, besides I love the waiters smile
    #I didn’t wait too much time, the service  is quit
    #the food there is fantastic, espacilly the steak, it is so delicious
    source_python("Predict_Chinese.py")
    new_document<-eventReactive(input$SubmitChinese, {paste(input$chinese1,input$chinese2,sep = " ")})
    text<-paste("The stars of your restaurant is  approximately ",predict(new_document())[[2]],sep = "")
    text
  })
  
  output$predict_pizza_score<-renderText({
    source_python("Predict_Pizza.py")
    new_document<-eventReactive(input$SubmitPizza, {paste(input$pizza1,input$pizza2,input$pizza3,input$pizza4,sep = " ")})
    text<-paste("The stars of your restaurant is  approximately ",predict(new_document())[[2]],sep = "")
    text
  })
  
  output$predict_American_fast_food_score<-renderText({
    source_python("Predict_American_fast_food.py")
    new_document<-eventReactive(input$SubmitAmerican_fast_food, {paste(input$American_fast_food1,input$American_fast_food2,input$American_fast_food3,sep = " ")})
    text<-paste("The stars of your restaurant is  approximately ",predict(new_document())[[2]],sep = "")
    text
  })
  
  output$predict_Desserts_score<-renderText({
    source_python("Predict_Desserts.py")
    new_document<-eventReactive(input$SubmitDesserts, {paste(input$Desserts1,input$Desserts2,input$Desserts3,input$Desserts4,sep = " ")})
    text<-paste("The stars of your restaurant is  approximately ",predict(new_document())[[2]],sep = "")
    text
  })
  
  output$predict_Steakhouses_score<-renderText({
    source_python("Predict_Steakhouses.py")
    new_document<-eventReactive(input$SubmitSteakhouses, {paste(input$Steakhouses1,input$Steakhouses2,input$Steakhouses3,input$Steakhouses4,sep = " ")})
    text<-paste("The stars of your restaurant is  approximately ",predict(new_document())[[2]],sep = "")
    text
  })
  
  output$predict_Italian_score<-renderText({
    source_python("Predict_Italian.py")
    new_document<-eventReactive(input$SubmitItalian, {paste(input$Italian1,input$Italian2,input$Italian3,sep = " ")})
    text<-paste("The stars of your restaurant is  approximately ",predict(new_document())[[2]],sep = "")
    text
  })
  
  output$predict_Seafood_score<-renderText({
    source_python("Predict_Seafood.py")
    new_document<-eventReactive(input$SubmitSeafood, {paste(input$Seafood1,input$pSeafood2,input$Seafood3,sep = " ")})
    text<-paste("The stars of your restaurant is  approximately ",predict(new_document())[[2]],sep = "")
    text
  })
  
 
  output$map<-renderText({
    #source_python("/Users/dyb/Desktop/yelp_dataset/code/heatmap/Chinesemap.py")
    includeHTML(sprintf("Users/dyb/Desktop/yelp_dataset/code/heatmap/%s.html",input$categories))
    })
}

shinyApp(ui = ui, server = server)
























