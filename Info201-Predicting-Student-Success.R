library(shiny)
library(ggplot2)
library(dplyr)

data <- read.delim("data/dataset.csv")


ui <- fluidPage(
  
  titlePanel("Predicting Students' Dropout and Academic Success"),
  
  # Main panel with tabs
  mainPanel(
    tabsetPanel(
      # Opening page with explanatory text
      tabPanel("Project Overview",
               tags$p("Created by Akhil Damidi, Luke Jin, Bill Yuliang, and Jack Villigrand"),
               fluidRow(
                 column(width = 6, 
                        tags$img(src = "https://storage.googleapis.com/kaggle-datasets-images/2780494/4802354/2b7db8e162649e95f56d8a3e8bb05395/dataset-cover.png?t=2023-01-03-09-19-56", width = "215%")),
                 
               ),
               tags$h1("Project Overview", style = "font-size: 2em; margin-top: 20px;"),
              
               tags$h1("What is our data?", style = "font-size: 2em; margin-top: 20px;"),
               tags$p("The data set we chose to work with was a data set predicting students’ dropping out, and their academic success. This data was collected by four authors, Valentim Realinho, Jorge Machado, Luis Baptista, and Monica V. Martins. We accessed this data through the website Kaggle. For undergraduate students in a variety of fields, this dataset contains information on their socioeconomic status, academic achievement, and demographics. It can be used to examine how various variables may affect academic success and dropout rates. Information such as the application method, course preference, grades, and economic indicators like the unemployment and inflation rates are all included. This dataset, which may be used across disciplines, offers insightful information about the factors that influence students' decision to continue their education or leave it early."),
               tags$h1("Who is our audience?", style = "font-size: 2em; margin-top: 20px;"),
               tags$p("Several different stakeholders, such as academics, educators, managers, and policymakers in the area of higher education, are anticipated to be quite interested in the dataset under review. Particularly those who are eager to learn more about the elements that influence student success and perseverance as well as those who are actively looking for methods to improve students' performance across a variety of academic fields."),
               tags$p("Given the rich and wide nature of the dataset, data scientists and analysts looking to examine and evaluate subjects linked to education or social science are also likely to find it interesting. Researchers have a great chance to investigate and comprehend the complexity of student performance and retention with the help of the dataset, which may also make it easier to establish interventions and policies that would enhance outcomes for students in higher education."),
               tags$p("In summary, the dataset offers a wealth of information that has the potential to inform the development of evidence-based strategies for supporting and improving student success. Its broad applicability and relevance to a diverse range of stakeholders underscore its significance and value as a critical resource for research and analysis in the field of higher education."),
               tags$h1("What we want to learn?", style = "font-size: 2em; margin-top: 20px;"),
               tags$ul(
                 tags$li("What are the demographic and academic factors that predict student dropout and academic success in various undergraduate courses, and how do these factors differ by field?"),
                 tags$li("How do students' grades change over time, and what factors are related to changes in grades from semester to semester?"),
                 tags$li("Do economic factors, such as unemployment, inflation, and GDP, of where students live in affect their dropout, enrollment or graduation?")
               )
      ),
      
      # Plot page
      tabPanel("Factors Affecting Academic Success",
               sidebarLayout(
                 sidebarPanel(
                   
                 ),
                 mainPanel(
                   
                 )
               )
      ),
      
      tabPanel("Grade Changes Over Time", 
               sidebarLayout(
                 sidebarPanel(
                   
                 ),
                 mainPanel(
                   
                  
                 )
               )
      ),
      
      tabPanel("Economic Factors and Education", 
               sidebarLayout(
                 sidebarPanel(
                   
                 ),
                 mainPanel(
                   
                   
                 )
               )
      ),
      
      tabPanel("Conclusion", 
               
      ),
    )
  )
)


server <- function(input, output) {
}

shinyApp(ui = ui, server = server)
