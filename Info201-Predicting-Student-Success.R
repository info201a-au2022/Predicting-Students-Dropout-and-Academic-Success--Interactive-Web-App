library(shiny)
library(ggplot2)
library(dplyr)

data <- read.csv("data/dataset.csv")
getwd()
data1 <- data.frame(data)
names(data1) <- gsub("\\.", "_", names(data1))

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
                        tags$img(src = "https://storage.googleapis.com/kaggle-datasets-images/2780494/4802354/2b7db8e162649e95f56d8a3e8bb05395/dataset-cover.png?t=2023-01-03-09-19-56", width = "220%")),
                 
               ),
               tags$h1("Project Overview", style = "font-size: 2em; margin-top: 20px;"),
               tags$p("The report provides a thorough analysis of how social and economic factors affect kids' academic success. Determining the main elements that support student accomplishment is the main goal of this report, along with a study of the Predict Students' Dropout and Academic Success dataset. For academics, teachers, administrators, and policymakers working in the higher education field, this paper may be useful. This report may be particularly useful to people trying to understand the factors that promote student achievement and people trying to improve student performance across a variety of areas."),
               tags$p("Our goal has been to provide our users with easily understandable graphs that show the relationship between social and economic factors and student accomplishment. These graphical representations are integrated with the dataset's assembly by eminent authors Valentim Realinho, Jorge Machado, Luis Baptista, and Monica V. Martins. Also, our users have the option of focusing on particular elements that affect students' academic progress by using toggles and filters."),
               tags$h1("What is our data?", gistyle = "font-size: 2em; margin-top: 20px;"),
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
               h1("Do economic factors, such as unemployment, inflation, and GDP, of where students live in, affect their dropout, enrollment or graduation?"),
               sidebarLayout(
                 sidebarPanel(
                   width = 4,
                   selectInput("xvar", "X-axis variable", choices = c("Unemployment_rate", "Inflation_rate", "GDP")),
                   selectInput("yvar", "Y-axis variable", choices = c("Unemployment_rate", "Inflation_rate", "GDP"))
                 ),
                 mainPanel(
                   fluidRow(
                     offset = 2,
                     width = 5,
                     plotOutput("scatter_plot", height = "600px", width = "1000px"),
                     verbatimTextOutput("corr_info"))
                   
                 )
               ),
               h2("Therefore, unemployment rate, inflation rate and GDP have no clear relationship to the academic success of students,
                as the correlations are all close to 0.")
      ),
      
      tabPanel("Conclusion", 
               
      ),
    )
  )
)


server <- function(input, output) {
  output$target_counts <- renderTable(
    {
      table(data1$Target)
    }
  )
  
  output$corr_info <- renderPrint({
    # Select the data based on x and y variable selections
    cor <- data.frame(x = data1[[input$xvar]], y = data1[[input$yvar]], target = data1$Target)
    
    # Compute the correlation value
    corr <- cor(cor$x, cor$y)
    
    # Return the correlation information
    paste("The correlation between", input$xvar, "and", input$yvar, "is", round(corr, 2))
  })
  
  # Function to create scatter plot
  createScatterPlot <- function(xvar, yvar, data1) {
    ggplot(data1, aes_string(x = xvar, y = yvar, color = "Target")) + 
      geom_point(size = 10) + 
      labs(x = xvar, y = yvar, title = paste0("Scatter plot of ", xvar, " vs. ", yvar), color = "Target") +
      theme_bw() +
      theme(plot.title = element_text(hjust = 0.5, vjust = 1))
  }
  
  # Scatter plot output
  scatter_data <- reactive({
    createScatterPlot(input$xvar, input$yvar, data1)
  })
  
  output$scatter_plot <- renderPlot({
    scatter_data()
  })
}

shinyApp(ui = ui, server = server)