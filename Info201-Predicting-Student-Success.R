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
               
      ),
      
      # Plot page
      tabPanel("Factors Affecting Undergraduate Success",
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
